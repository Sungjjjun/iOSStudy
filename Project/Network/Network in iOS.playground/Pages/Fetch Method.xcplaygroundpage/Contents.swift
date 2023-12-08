//: [Previous](@previous)

import Foundation

enum NetworkError: Error {
  case invalidRequest
  case transportError(Error)
  case responseError(statusCode: Int)
  case noData
  case decodingError(Error)
}

struct GithubProfile: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case followers
        case following
    }
}

// Network 담당 서비스
final class NetworkService {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    func fetchProfile(userName: String, completion: @escaping (Result<GithubProfile, Error>) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(userName)")!

        let task = session.dataTask(with: url) { data, response, error in
            // Error
            if let error = error {
                completion(.failure(NetworkError.transportError(error)))
                return
            }
            
            // Response Error
            if let httpResponse = response as? HTTPURLResponse,
                    !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.responseError(statusCode: httpResponse.statusCode)))
                return
            }
            
            // data에 값이 없을 때
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let profile = try decoder.decode(GithubProfile.self, from: data)
                completion(.success(profile))
            } catch let error as NSError {
                // Decoding Error
                completion(.failure(NetworkError.decodingError(error)))
            }
        }
        task.resume()
    }
}

// NetworkService를 이용한 작업
let networkService = NetworkService(configuration: .default)
networkService.fetchProfile(userName: "Sungjjjun") { result in
    switch result {
    case .failure(let error):
        print(error)
    case.success(let profile):
        print(profile)
    }
}

//: [Next](@next)
