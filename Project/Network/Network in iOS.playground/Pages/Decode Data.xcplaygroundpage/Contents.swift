//: [Previous](@previous)

import Foundation


struct GithubProfile: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let followers: Int
    let following: Int
    let publicRepos: Int
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url" // '_'가 있는 경우, 지정한 문자열을 키로 찾아서 저장, 지정한 문자열이 없는 경우에는 변수명으로 찾음.
        case htmlUrl = "html_url"
        case publicRepos = "public_repos"
        case followers
        case following
    }
}
// App Model -> JSon (Incoding)
// Json -> App Model (Decoding)
// configuration -> urlsession -> urlsessionTask
let configuration = URLSessionConfiguration.default
let session = URLSession(configuration: configuration)
let url = URL(string: "https://api.github.com/users/Sungjjjun")!

let task = session.dataTask(with: url) { data, response, error in
    guard let httpResponse = response as? HTTPURLResponse,
            (200..<300).contains(httpResponse.statusCode) else {
        print("-----> Response: \(response!)")
        return
    }
    
    guard let data = data else { return }
    do {
        let decoder = JSONDecoder()
        let profile = try decoder.decode(GithubProfile.self, from: data)
        print(profile.publicRepos)
    } catch let error as NSError {
        print("Error 발생: \(error)")
    }
}

task.resume()
//: [Next](@next)
