//
//  HomeViewCell.swift
//  CarrotHomeTab
//
//  Created by 박성준 on 2023/12/30.
//

import UIKit
import Kingfisher

class HomeViewCell: UICollectionViewCell {
    
    @IBOutlet var thumbnailImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var numOfChatsLabel: UILabel!
    @IBOutlet var numOfLikesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImage.layer.cornerRadius = 10
    }
    
    func configure(_ item: ItemInfo) {
        thumbnailImage.kf.setImage(with: URL(string: item.thumbnailURL)!)
        titleLabel.text = item.title
        locationLabel.text = item.location
        priceLabel.text = "\(formatNumber(item.price)) 원"
        numOfChatsLabel.text = "\(item.numOfChats)"
        numOfLikesLabel.text = "\(item.numOfLikes)"
    }
    
    private func formatNumber(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let result = formatter.string(from: NSNumber(integerLiteral: price)) ?? ""
        return result
    }
}
