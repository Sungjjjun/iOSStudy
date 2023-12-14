//
//  SearchViewModel.swift
//  GithubUserSearch
//
//  Created by 박성준 on 2023/12/14.
//

import Foundation
import Combine

final class SearchViewModel {
    var subscriptions = Set<AnyCancellable>()
    
    init(network: NetworkService) {
        self.network = network
    }
    // Data => Output
    var network: NetworkService
    @Published private(set) var users = [SearchResult]()
    
    // User Action => Input
    func search(keyword: String) {
        let resource = Resource<SearchUserResponse>(
            base: "https://api.github.com/",
            path: "search/users",
            params: ["q": keyword],
            header: ["Content-Type": "application/json"])
        
        network.load(resource)
            .map{ $0.items }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.users, on: self)
            .store(in: &subscriptions)
    }
}
