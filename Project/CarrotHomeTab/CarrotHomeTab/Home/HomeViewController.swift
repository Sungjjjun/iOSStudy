//
//  HomeViewController.swift
//  CarrotHomeTab
//
//  Created by 박성준 on 2023/12/28.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    enum Section {
        case main
    }
    typealias Item = ItemInfo
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    let viewModel: HomeViewModel = HomeViewModel(network: NetworkService(configuration: .default))
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        bind()
        viewModel.fetch()
    }
    
    private func configureCollectionView() {
        // Presentation -> Diffable Data Source
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath) as? HomeViewCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        // Layout -> Compositional Layout
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func bind() {
        // Output(Data)
        viewModel.$items
            .receive(on: RunLoop.main)
            .sink { items in
                print("Update Collection View: \(items)")
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(items, toSection: .main)
                self.dataSource.apply(snapshot)
            }.store(in: &subscriptions)
        
        // Input(User Interaction)
        viewModel.itemTapped
            .sink { item in
                let detailStoryBoard = UIStoryboard(name: "Detail", bundle: nil)
                let detailViewController = detailStoryBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }.store(in: &subscriptions)
    }
    
//    @IBAction func ctaButtonTapped(_ sender: Any) {
//        let detailStoryBoard = UIStoryboard(name: "Detail", bundle: nil)
//        let detailViewController = detailStoryBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        navigationController?.pushViewController(detailViewController, animated: true)
//    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: \(indexPath.item.description)")
    }
}
