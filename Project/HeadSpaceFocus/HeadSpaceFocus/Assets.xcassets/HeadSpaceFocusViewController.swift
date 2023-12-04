 //
//  HeadSpaceFocusViewController.swift
//  HeadSpaceFocus
//
//  Created by 박성준 on 2023/11/30.
//

import UIKit

class HeadSpaceFocusViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var refreshButton: UIButton!
    var curated: Bool = false // 추천된 상태
    var list: [Focus] = Focus.list
    
    enum Section {
        case main
    }
    typealias Item = Focus
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshButton.layer.cornerRadius = 10
        
        //Presentation
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadSpaceFocusCell", for: indexPath) as? HeadSpaceFocusCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        //Data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)
        
        //Layout
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
        
        updateTitle()
    }
    
    private func layout() ->UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // 버튼 타이틀 업데이트
    func updateTitle() {
        let title = curated ? "See All" : "See Recommendation"
        refreshButton.setTitle(title, for: .normal)
    }
    
    @IBAction func isButtonTapped(_ sender: Any) {
        curated.toggle()
        self.list = curated ? Focus.recommendations : Focus.list
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot)
        
        updateTitle()
    }
}

extension HeadSpaceFocusViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "QuickFocus", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "QuickFocusViewController") as! QuickFocusViewController
        
//        present(viewController, animated: true)
        viewController.title = list[indexPath.item].title
        navigationController?.pushViewController(viewController, animated: true)
    }
}
