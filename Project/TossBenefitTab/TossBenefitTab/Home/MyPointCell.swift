//
//  MyPointCell.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/22.
//

import UIKit

class MyPointCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var pointLabel: UILabel!
    func configure(item: MyPoint) {
        imageView.image = UIImage(named: "ic_point")
        titleLabel.text = "내 포인트"
        pointLabel.text = "\(item.point) 원"
    }
}
