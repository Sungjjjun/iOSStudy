import UIKit
import SwiftUI
import Combine

class SearchViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var subscriptions = Set<AnyCancellable>()
    var viewModel: SearchViewModel!
    
    enum Section {
        case main
    }
    typealias Item = SearchResult
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchViewModel(network: NetworkService(configuration: .default))
        embedSearchController()
        configureColletionView()
        bind()
    }
    
    // Search Controller
    private func embedSearchController() {
        self.navigationItem.title = "Search Github User"
        
        let searchViewController = UISearchController(searchResultsController: nil)
        searchViewController.hidesNavigationBarDuringPresentation = false
        searchViewController.searchBar.placeholder = "Input ID What You want to search"
        searchViewController.searchBar.delegate = self
        
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
        collectionView.delegate = self
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
        viewModel.$users
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
        viewModel.search(keyword: keyword)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userID = viewModel.users[indexPath.item].login
        let profileViewModel = UserProfileViewModel(network: NetworkService(configuration: .default), loginID: userID)
        let profileView = UserProfileView(viewModel: profileViewModel)
        let hostingController = UIHostingController(rootView: profileView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
