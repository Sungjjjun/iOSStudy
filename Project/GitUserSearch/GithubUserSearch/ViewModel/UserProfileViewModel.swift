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
    
    init(network: NetworkService, loginID: String) {
        self.loginID = loginID
        self.network = network
    }
    
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
}
