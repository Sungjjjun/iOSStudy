//
//  BenefitListViewController.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/22.
//

import UIKit

// 3가지 Cell로 구성
//  1. 나의 포인트 보기 => Today
//  2. 오늘의 혜택 => Today
//  3. 나머지 혜택 => Other
class BenefitListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    enum Section: Int {
        case today
        case other
    }
    // 여러가지의 Hashable 모델을 포괄할 수 있음
    typealias Item = AnyHashable
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var todaySectionItems: [AnyHashable] = TodaySectionItem(point: .default, today: .today).sectionItems
    var otherSectionItems: [AnyHashable] = Benefit.others
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            let cell = self.configureCell(for: section, item: item, collectionView: collectionView, indexPath: indexPath)
            return cell
        })
        
        // Data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.today, .other])
        snapshot.appendItems(todaySectionItems, toSection: .today)
        snapshot.appendItems(otherSectionItems, toSection: .other)
        dataSource.apply(snapshot)
        
        // Layout
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
        navigationItem.title = "헤택"
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10)
        section.interGroupSpacing = 20
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureCell(for section: Section, item: Item, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell? {
        switch section {
        case .today:
            // Today = 나의 포인트 + 오늘의 혜택
            
            // 나의 포인트
            if let point = item as? MyPoint {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPointCell", for: indexPath) as? MyPointCell else { return nil }
                cell.configure(item: point)
                return cell
                
            // 오늘의 혜택
            } else if let todayBenefit = item as? Benefit {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayBenefitCell", for: indexPath) as? TodayBenefitCell else { return nil }
                cell.configure(item: todayBenefit)
                return cell
            } else {
                return nil
            }
        case .other:
            // Other = 나머지 혜택들
            if let otherBenefit = item as? Benefit {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherBenefitCell", for: indexPath) as? OtherBenefitCell else { return nil }
                cell.configure(item: otherBenefit)
                return cell
            } else {
                return nil
            }
        }
    }
}

extension BenefitListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource.itemIdentifier(for: indexPath)
        print("\(item)")
        
        if let benefit = item as? Benefit {
            
        } else if let point = item as? MyPoint {
            let myPointStoryBoard = UIStoryboard(name: "MyPoint", bundle: nil)
            let myPointViewController = myPointStoryBoard.instantiateViewController(withIdentifier: "MyPointViewController") as! MyPointViewController
            myPointViewController.point = point
            navigationController?.pushViewController(myPointViewController, animated: true)
        } else {
            
        }
    }
}
