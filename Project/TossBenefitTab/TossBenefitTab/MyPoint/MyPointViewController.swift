//
//  MyPointViewController.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/26.
//

import UIKit
import Combine

class MyPointViewController: UIViewController {
    
    @IBOutlet var pointLabel: UILabel!
    
    var viewModel: MyPointViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func bind() {
        viewModel.$point
            .receive(on: RunLoop.main)
            .sink { point in
                self.pointLabel.text = "\(point.point) 원"
            }.store(in: &subscriptions)
    }
}
