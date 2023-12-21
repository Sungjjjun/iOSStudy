//
//  UserProfileViewModel.swift
//  GithubUserSearch
//
//  Created by 박성준 on 2023/12/21.
//

import Foundation
import Combine

final class UserProfileViewModel: ObservableObject {
    let loginID: String
    let network: NetworkService
    
    @Published var selectedUser: UserProfile?
    var subscriptions = Set<AnyCancellable>()
    
    init(network: NetworkService, loginID: String) {
        self.loginID = loginID
        self.network = network
    }
    
    var imageURL: URL? { return selectedUser?.avatarUrl }
    var name: String { return selectedUser?.name ?? "n/a" }
    var login: String { return selectedUser?.login ?? "n/a" }
    var followers: String {
        guard let value = selectedUser?.followers else { return "" }
        return "followers: \(value)"
    }
    var following: String {
        guard let value = selectedUser?.following else { return "" }
        return "followers: \(value)"
    }
    
    // 주어진 로그인 아이디를 기반으로 UserProfile 검색
    func search(keyword: String) {
        let resource = Resource<UserProfile>(
            base: "https://api.github.com/",
            path: "users/\(keyword)",
            params: [:],
            header: ["Content-Type": "application/json"])
        
        network.load(resource)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.selectedUser = nil
                    print("Error: \(error)")
                case .finished: break
                }
            }, receiveValue: { user in
                self.selectedUser = user
            })
            .store(in: &subscriptions)
    }
}
