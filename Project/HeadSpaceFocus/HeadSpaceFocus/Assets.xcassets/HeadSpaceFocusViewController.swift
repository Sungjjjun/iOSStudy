//
//  HeadSpaceFocusViewController.swift
//  HeadSpaceFocus
//
//  Created by 박성준 on 2023/11/30.
//

import UIKit

class HeadSpaceFocusViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    enum Section {
        case main
    }
    
    typealias Item = Focus
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    let list: [Focus] = Focus.list
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Presentation
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadSpaceFocusCell", for: indexPath) as? HeadSpaceFocusCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        // Data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)
        
        // Layout
        collectionView.collectionViewLayout = layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
      
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
 }
