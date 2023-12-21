//
//  UserProfile.swift
//  GithubUserSearch
//
//  Created by 박성준 on 2023/12/21.
//

import Foundation

struct UserProfile: Hashable, Identifiable, Decodable {
    var id: Int64
    var login: String
    var name: String
    var avatarUrl: URL
    var htmlUrl: String
    var followers: Int
    var following: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case followers
        case following
    }
}

extension UserProfile {
    static let mock = UserProfile(
        id: 103017099,
        login: "Sungjjjun",
        name: "SUNGJUN PARK",
        avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/103017099?v=4")!,
        htmlUrl: "https://github.com/Sungjjjun",
        followers: 2,
        following: 2
    )
}
