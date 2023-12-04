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
            case .breathing: return "Breathing Exercises"
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
        
        dataSource.supplementaryViewProvider = { (colletionView, kind, indexPath) in
            guard let header = colletionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "QuickFocusHeaderView", for: indexPath) as? QuickFocusHeaderView else {
                return nil
            }
            let allSections = Section.allCases
            let section = allSections[indexPath.section]
            header.configure(section.title)
            return header
        }
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
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20)
        section.interGroupSpacing = 20
        
        let headeSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headeSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
