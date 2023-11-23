//
//  StockRankCollectionViewCell.swift
//  ListAndGrid
//
//  Created by 박성준 on 2023/11/23.
//

import UIKit

class StockRankCollectionViewCell: UICollectionViewCell {
    // UI 컴포넌트 연결
    // UI 컴포넌트 데이터 업데이트
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var companyIcon: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var stockPrice: UILabel!
    @IBOutlet weak var diffLabel: UILabel!
    
    func configure(_ stock: StockModel) {
        rankLabel.text = "\(stock.rank)"
        companyIcon.image = UIImage(named: stock.imageName)
        companyLabel.text = stock.name
        stockPrice.text = "\(stock.price) 원"
        diffLabel.text = "\(stock.diff)%"
        diffLabel.textColor = stock.diff <= 0 ? .red : .blue
    }
}
