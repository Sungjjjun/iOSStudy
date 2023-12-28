//
//  CutomBarItem.swift
//  CarrotHomeTab
//
//  Created by 박성준 on 2023/12/28.
//

import Foundation
import UIKit

struct CustomBarItemConfigure {
    typealias Handler = () -> Void
    
    let title: String?
    let image: UIImage?
    let handler: Handler
    
    init(title: String? = nil, image: UIImage? = nil, handler: @escaping Handler) {
        self.title = title
        self.image = image
        self.handler = handler
    }
}

final class CustomBarItem: UIButton {
    // Title, Image, Action Handler
    var customBarItemConfig: CustomBarItemConfigure
    
    init(config: CustomBarItemConfigure) {
        self.customBarItemConfig = config
        super.init(frame: .zero)
        setUpStyle()
        updateConfig()
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setUpStyle() {
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        self.titleLabel?.textColor = .label
        self.imageView?.tintColor = .label
        
    }
    
    private func updateConfig() {
        self.setTitle(customBarItemConfig.title, for: .normal)
        self.setImage(customBarItemConfig.image, for: .normal)
    }
    
    @objc func buttonTapped() {
        customBarItemConfig.handler()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
