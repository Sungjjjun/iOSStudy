//
//  QuickFocusHeaderView.swift
//  HeadSpaceFocus
//
//  Created by 박성준 on 2023/12/04.
//

import UIKit

class QuickFocusHeaderView: UICollectionReusableView {
    @IBOutlet var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
