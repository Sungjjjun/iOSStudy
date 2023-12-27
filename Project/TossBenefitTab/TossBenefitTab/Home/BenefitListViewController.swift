//
//  BenefitListViewController.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/22.
//

import UIKit
import Combine

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
    var subscriptions = Set<AnyCancellable>()
    var viewModel: BenefitListViewModel = BenefitListViewModel()
    
    private func bind() {
        // Output => Data
        viewModel.$todaySectionItems
            .receive(on: RunLoop.main)
            .sink { items in
                self.applySnapshot(items: items, section: .today)
            }
            .store(in: &subscriptions)
        
        viewModel.$otherSectionItems
            .receive(on: RunLoop.main)
            .sink { items in
                self.applySnapshot(items: items, section: .other)
            }
            .store(in: &subscriptions)
        
        // Input => User Interaction
        viewModel.benefitDidTapped
            .receive(on: RunLoop.main)
            .sink { benefit in
                let buttonBenefitStoryBoard = UIStoryboard(name: "ButtonBenefit", bundle: nil)
                let buttonBenefitViewController = buttonBenefitStoryBoard.instantiateViewController(withIdentifier: "ButtonBenefitViewController") as! ButtonBenefitViewController
                buttonBenefitViewController.viewModel = ButtonBenefitViewModel(benefit: benefit)
                self.navigationController?.pushViewController(buttonBenefitViewController, animated: true)
            }
            .store(in: &subscriptions)
        
        viewModel.pointDidTapped
            .receive(on: RunLoop.main)
            .sink { point in
                let myPointStoryBoard = UIStoryboard(name: "MyPoint", bundle: nil)
                let myPointViewController = myPointStoryBoard.instantiateViewController(withIdentifier: "MyPointViewController") as! MyPointViewController
                myPointViewController.viewModel = MyPointViewModel(point: point)
                self.navigationController?.pushViewController(myPointViewController, animated: true)
            }
            .store(in: &subscriptions)
    }
    
    // 네트워크를 통해 받은 데이터를 Snapshot에 적용해주는 함수
    private func applySnapshot(items: [Item], section: Section) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureCollectionView()
        bind()
        viewModel.fetchItem()
    }
    
    private func setupUI() {
        navigationItem.title = "헤택"
    }
    
    private func configureCollectionView() {
        // Presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            let cell = self.configureCell(for: section, item: item, collectionView: collectionView, indexPath: indexPath)
            return cell
        })
        
        // Data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.today, .other])
        snapshot.appendItems([], toSection: .today)
        snapshot.appendItems([], toSection: .other)
        dataSource.apply(snapshot)
        
        // Layout
        collectionView.collectionViewLayout = layout()
        collectionView.delegate = self
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
        
        if let benefit = item as? Benefit {
            viewModel.benefitDidTapped
                .send(benefit)
        } else if let point = item as? MyPoint {
            viewModel.pointDidTapped
                .send(point)
        } else {
            
        }
    }
}
