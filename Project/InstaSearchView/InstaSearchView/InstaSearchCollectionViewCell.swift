//
//  InstaSearchCollectionViewCell.swift
//  InstaSearchView
//
//  Created by 박성준 on 2023/11/27.
//

import UIKit

class InstaSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animalImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        animalImageView.image = nil
    }
    
    func configure(_ imageName: String) {
        animalImageView.image = UIImage(named: imageName)
    }
}
