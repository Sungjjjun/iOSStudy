//
//  MyPointViewController.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/26.
//

import UIKit

class MyPointViewController: UIViewController {
    
    var point: MyPoint = .default
    @IBOutlet var pointLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
}
