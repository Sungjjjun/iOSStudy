import UIKit
import Combine
import Kingfisher

class UserProfileViewController: UIViewController {
    // Setup UI
    // UserProfile
    // Bind
    // Search Controller
    // Network
    @Published private(set) var user: UserProfile?
    var subscription = Set<AnyCancellable>()
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        embededSearchControl()
        bind()
    }
    
    private func setupUI() {
        thumbnail.layer.cornerRadius = 80
    }
    
    private func embededSearchControl() {
        self.navigationItem.title = "Search"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Sungjjjun"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
    }
    
    private func bind() {
        $user
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                self.update(result)
            }
            .store(in: &subscription)
    }
    
    private func update(_ user:  UserProfile?) {
        guard let user = user else {
            self.nameLabel.text = "n/a"
            self.loginLabel.text = "n/a"
            self.followerLabel.text = ""
            self.followingLabel.text = ""
            self.thumbnail.image = nil
            return
        }
        self.nameLabel.text = user.name
        self.loginLabel.text = user.login
        self.followerLabel.text = "follower: \(user.followers)"
        self.followingLabel.text = "following: \(user.following)"
        
        // Image 넣기 (URL으로)
        self.thumbnail.kf.setImage(with: user.avatarUrl)
    }
}

extension UserProfileViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keywords = searchController.searchBar.text ?? ""
        print("search: \(keywords)")
    }
}

extension UserProfileViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Button Clicked: \(searchBar.text!)")
        
        // Search Bar에 빈 값이 있는 경우 return
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        
        let base = "https://api.github.com/"
        let path = "users/\(keyword)"
        let params: [String: String] = [:]
        let header: [String: String] = ["Content-Type": "application/json"]
        
        var urlComponent = URLComponents(string: base + path)!
        let queryItems = params.map { (key: String, value: String) in
            return URLQueryItem(name: key, value: value)
        }
        urlComponent.queryItems = queryItems
        
        var request = URLRequest(url: urlComponent.url!)
        header.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                return result.data
            }
            .decode(type: UserProfile.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .print()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self.user = nil
                case .finished: break
                }
            } receiveValue: { user in
                self.user = user
            }
            .store(in: &subscription)
    }
}
