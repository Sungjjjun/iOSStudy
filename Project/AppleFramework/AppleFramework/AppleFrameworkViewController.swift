//
//  AppleFrameworkViewController.swift
//  AppleFramework
//
//  Created by 박성준 on 2023/11/26.
//

import UIKit

class AppleFrameworkViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section {
        case main
    }
    
    // AppleFramework -> Item (redirecting)
    typealias Item = AppleFramework
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    let list: [AppleFramework] = AppleFramework.list
    
    // Data, Presentation, Layout
    // diffable data source
    // - presentation
    // snapshot
    // - data
    // compositional layout
    // - layout
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        navigationController?.navigationBar.topItem?.title = "🥸 I'm from Codes"
    }
}


// 클릭된 앱이 무엇인지
extension AppleFrameworkViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let framework = list[indexPath.item]
        print(framework.name)
    }
}
