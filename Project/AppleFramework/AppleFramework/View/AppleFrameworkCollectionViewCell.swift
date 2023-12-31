//
//  AppleFrameworkCollectionViewCell.swift
//  AppleFramework
//
//  Created by 박성준 on 2023/11/26.
//

import UIKit

class AppleFrameworkCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appLabel.numberOfLines = 1
        appLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configure(_ frame: AppleFramework) {
        appImageView.image = UIImage(named: frame.imageName)
        appLabel.text = frame.name
    }
}
