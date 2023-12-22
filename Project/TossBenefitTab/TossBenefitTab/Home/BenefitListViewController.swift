//
//  BenefitListViewController.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/22.
//

import UIKit

class BenefitListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    enum Section {
        case today
        case other
    }
    // 여러가지의 Hashable 모델을 포괄할 수 있음
    typealias Item = AnyHashable
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var todaySectionItems: [AnyHashable] = []
    var otherSectionItems: [AnyHashable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "헤택"
    }
}
