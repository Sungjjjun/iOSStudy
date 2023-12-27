//
//  BenefitGuideView.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/27.
//

import UIKit

final class BenefitGuideView: UIView {
    lazy var icon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(icon)
        addSubview(title)
        
        // Auto Layout 구성
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 30),
            icon.widthAnchor.constraint(equalToConstant: 30),
        ])
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
