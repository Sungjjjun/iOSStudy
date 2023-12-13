import UIKit
import Combine

class SearchViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @Published private(set) var users: [SearchResult] = []
    var subscriptions = Set<AnyCancellable>()
    let network = NetworkService(configuration: .default)
    
    enum Section {
        case main
    }
    typealias Item = SearchResult
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedSearchController()
        configureColletionView()
        bind()
    }
    
    // Search Controller
    private func embedSearchController() {
        self.navigationItem.title = "Search Git User"
        
        let searchViewController = UISearchController(searchResultsController: nil)
        searchViewController.hidesNavigationBarDuringPresentation = false
        searchViewController.searchBar.placeholder = "Input ID What You want to search"
        searchViewController.searchBar.delegate = self
        searchViewController.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchViewController
    }
    
    // CollectionView 구성
    private func configureColletionView() {
        // Presentation -> Diffable Data Source
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else {
                return nil
            }
            cell.user.text = item.login
            return cell
        })
        
        // Layout -> Compositional Layout
        collectionView.collectionViewLayout = layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // Data Binding
    private func bind() {
        // - Data -> View
        $users
            .receive(on: RunLoop.main)
            .sink { users in
                // 검색된 사용자를 CollectionView Update (Snapshot)
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(users, toSection: .main)
                self.dataSource.apply(snapshot)
            }
            .store(in: &subscriptions)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        print("Button Clicked: \(keyword)")
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text ?? ""
        print("Input Text: \(keyword)")
        
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
        
        // Request 생성
//        let base = "https://api.github.com/"
//        let path = "search/users"
//        let params: [String: String] = ["q": keyword]
//        let header: [String: String] = ["Content-Type": "application/json"]
//
//        var urlComponents = URLComponents(string: base + path)!
//        let queryItem = params.map { (key: String, value: String) in
//            return URLQueryItem(name: key, value: value)
//        }
//        urlComponents.queryItems = queryItem
//        var request = URLRequest(url: urlComponents.url!)
//        header.forEach { (key: String, value: String) in
//            request.addValue(value, forHTTPHeaderField: key)
//        }
//
//        URLSession.shared.dataTaskPublisher(for: request)
//            .map{ $0.data }
//            .decode(type: SearchUserResponse.self, decoder: JSONDecoder())
//            .map{ $0.items }
//            .replaceError(with: [])
//            .receive(on: RunLoop.main)
//            .assign(to: \.users, on: self)
//            .store(in: &subscriptions)
    }
}
