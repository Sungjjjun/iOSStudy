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
        let price = convertToCurrencyFomat(price: stock.price)
        
        rankLabel.text = "\(stock.rank)"
        companyIcon.image = UIImage(named: stock.imageName)
        companyLabel.text = stock.name
        stockPrice.text = "\(price) 원"
        diffLabel.text = "\(stock.diff)%"
        diffLabel.textColor = stock.diff <= 0 ? .red : .blue
    }
    
    // 1000 -> 1,000
    func convertToCurrencyFomat(price: Int) -> String {
        let numberFomatter = NumberFormatter()
        numberFomatter.numberStyle = .decimal
        numberFomatter.maximumFractionDigits = 0
        let result = numberFomatter.string(from: NSNumber(value: price)) ?? ""
        return result
    }
}
