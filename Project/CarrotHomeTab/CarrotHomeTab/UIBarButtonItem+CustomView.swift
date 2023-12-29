//
//  UIBarButtonItem+CustomView.swift
//  CarrotHomeTab
//
//  Created by 박성준 on 2023/12/29.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    static func generate(with config: CustomBarItemConfigure, width: CGFloat? = nil) -> UIBarButtonItem{
        let customView = CustomBarItem(config: config)
        
        if let width = width {
            NSLayoutConstraint.activate([
                customView.widthAnchor.constraint(equalToConstant: width)
            ])
        }
        
        let barButtonItem  = UIBarButtonItem(customView: customView)
        return barButtonItem
    }
}
