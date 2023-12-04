//
//  QuickFocusViewController.swift
//  HeadSpaceFocus
//
//  Created by 박성준 on 2023/12/04.
//

import UIKit

class QuickFocusViewController: UIViewController {
    @IBOutlet var colletionView: UICollectionView!
    enum Section: CaseIterable{
        case breathing
        case walking
        
        var title: String {
            switch self {
            case .breathing: return "Breating Exercises"
            case .walking: return "Mindful Walks"
            }
        }
    }
    typealias Item = QuickFocus
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    let breathing: [QuickFocus] = QuickFocus.breathing
    let walking: [QuickFocus] = QuickFocus.walking
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Presentation -> Diffable DataSource
        dataSource = UICollectionViewDiffableDataSource(collectionView: colletionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickFocusCell", for: indexPath) as? QuickFocusCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        // Data -> Snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.breathing, .walking])
        // snapshot.appendSections(Section.allCases)
        snapshot.appendItems(walking, toSection: .walking)
        snapshot.appendItems(breathing, toSection: .breathing)
        dataSource.apply(snapshot)
        
        // Layout -> Compositional Layout
        colletionView.collectionViewLayout = layout()
    }
    
    func layout() -> UICollectionViewCompositionalLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
