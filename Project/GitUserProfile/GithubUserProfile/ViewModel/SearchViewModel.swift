//
//  SearchViewModel.swift
//  GithubUserProfile
//
//  Created by 박성준 on 2023/12/14.
//

import Foundation
import Combine

final class SearchViewModel {
    let network: NetworkService
    var subscriptions = Set<AnyCancellable>()
    
    init(network: NetworkService, selectedUser: UserProfile?) {
        self.network = network
        self.selectedUser = CurrentValueSubject(selectedUser)
    }
    
    // Data => Output
    let selectedUser: CurrentValueSubject<UserProfile?, Never>
    
    var name: String { return self.selectedUser.value?.name ?? "n/a"}
    var login: String { return self.selectedUser.value?.login ?? ""}
    var followers: String {
        guard let value = selectedUser.value?.followers else { return "" }
        return "followers: \(value)"
    }
    var following: String {
        guard let value = selectedUser.value?.following else { return "" }
        return "following: \(value)"
    }
    var imageURL: URL? { return self.selectedUser.value?.avatarUrl }
    
    // User Action => Input
    func search(keyword: String) {
        let resource = Resource<UserProfile>(
            base: "https://api.github.com/",
            path: "users/\(keyword)",
            params: [:],
            header: ["Content-Type": "application/json"])

        // Network Service
        network.load(resource)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
                switch completion {
                case .failure(let error):
                    print(error)
                    self.selectedUser.value = nil
                case .finished: break
                }
            } receiveValue: { user in
                self.selectedUser.value = user
            }
            .store(in: &subscriptions)
    }
}
