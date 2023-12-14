//
//  AppleFrameworkViewController.swift
//  AppleFramework
//
//  Created by 박성준 on 2023/11/26.
//

import UIKit
import Combine

class AppleFrameworkViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section {
        case main
    }
    
    // AppleFramework -> Item (redirecting)
    typealias Item = AppleFramework
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    // Combine
    var subscriptions = Set<AnyCancellable>()
    var viewModel: FrameworkListViewModel!
    
    // Data, Presentation, Layout
    // diffable data source
    // - presentation
    // snapshot
    // - data
    // compositional layout
    // - layout
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FrameworkListViewModel(items: AppleFramework.list)
        configureCollectionView()
        bind()
    }
    
    // 핵심 로직 (Combine으로 구성)
    private func bind() {
        viewModel.items
            .receive(on: RunLoop.main)
            .sink { [unowned self] list in
                self.applySectionItems(list)
            }.store(in: &subscriptions)
        
        viewModel.selectedItem
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { framework in
                let storyBoard = UIStoryboard(name: "Detail", bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "FrameworkDetailViewController") as! FrameworkDetailViewController
                viewController.viewModel = FrameworkDetailViewModel(framework: framework)
                
                // 모달뷰 에니메이션 스타일
                // viewController.modalTransitionStyle = .flipHorizontal
                
                // 풀스크린
                // viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            }.store(in: &subscriptions)
    }
    
    private func configureCollectionView() {
        // Presentation
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppleFrameworkCollectionViewCell", for: indexPath) as? AppleFrameworkCollectionViewCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        //Layout
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
    }
    
    private func applySectionItems(_ items: [Item], to section: Section = .main) {
        //Data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([section])
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot)
    }
    
    private func layout() -> UICollectionViewCompositionalLayout{
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        // Layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}


// 클릭된 앱이 무엇인지
extension AppleFrameworkViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath)
    }
}
