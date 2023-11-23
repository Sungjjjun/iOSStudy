//
//  StockRankViewController.swift
//  ListAndGrid
//
//  Created by 박성준 on 2023/11/22.
//

import UIKit

class StockRankViewController: UIViewController {

    let stockList: [StockModel] = StockModel.list
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Data - 어떤 데이터, Presentation - 셀을 어떻게 표현, Layout - 셀들의 레이아웃을 어떻게 표현
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension StockRankViewController: UICollectionViewDataSource {
    // 데이터가 얼만큼 들어와??
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stockList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCollectionViewCell", for: indexPath)
        return cell
        
    }
}

extension StockRankViewController: UICollectionViewDelegateFlowLayout {
    
}
