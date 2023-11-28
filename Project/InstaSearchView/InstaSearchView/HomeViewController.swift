//
//  HomeViewController.swift
//  InstaSearchView
//
//  Created by 박성준 on 2023/11/28.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        
        if let layout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let imageName = "animal\(indexPath.item + 1)"
        cell.configure(imageName)
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = homeCollectionView.bounds.width
        let height = width * 3/4 + 60
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
