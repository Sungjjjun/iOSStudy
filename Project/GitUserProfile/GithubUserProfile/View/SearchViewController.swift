import UIKit
import Combine
import Kingfisher

class UserProfileViewController: UIViewController {
    // Setup UI
    // UserProfile
    // Bind
    // Search Controller
    // Network
    var viewModel: SearchViewModel!
    var subscription = Set<AnyCancellable>()
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel = SearchViewModel(network: NetworkService(configuration: .default), selectedUser: nil)
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
        viewModel.selectedUser
            .receive(on: RunLoop.main)
            .sink { [unowned self] _ in
                self.nameLabel.text = viewModel.name
                self.loginLabel.text = viewModel.login
                self.followerLabel.text = viewModel.followers
                self.followingLabel.text = viewModel.following
                
                // Image 넣기 (URL으로)
                self.thumbnail.kf.setImage(with: viewModel.imageURL)
            }
            .store(in: &subscription)
    }
}

extension UserProfileViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keywords = searchController.searchBar.text ?? ""
    }
}

extension UserProfileViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Search Bar에 빈 값이 있는 경우 return
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        viewModel.search(keyword: keyword)
    }
}
