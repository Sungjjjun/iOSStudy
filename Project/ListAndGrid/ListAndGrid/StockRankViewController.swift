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
        // StockRankCollectionViewCell은 UICollectionViewCell 상속
        // cell은 UICollectionViewCell이지만 StockRankCollectionViewCell은 아닐수 있음.
        // 따라서, Casting을 통해 만약 StockRankCollectionViewCell인 경우에만 셀 업데이트
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StockRankCollectionViewCell", for: indexPath) as? StockRankCollectionViewCell else {
            return UICollectionViewCell()
        }
        //StockRankCollectionViewCell인 경우
        let stock = stockList[indexPath.item]
        cell.configure(stock)
        return cell
        
    }
}

extension StockRankViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // width == collectionView width
        // height =? 80
        
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
}
