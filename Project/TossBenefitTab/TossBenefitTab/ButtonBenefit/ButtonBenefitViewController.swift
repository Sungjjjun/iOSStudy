//
//  ButtonBenefitViewController.swift
//  TossBenefitTab
//
//  Created by 박성준 on 2023/12/26.
//

import UIKit

class ButtonBenefitViewController: UIViewController {
    
    var benefit: Benefit = .today
    var benefitDetials: BenefitDetails = .default

    @IBOutlet var ctaButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        self.ctaButton.layer.masksToBounds = true
        self.ctaButton.layer.cornerRadius = 5
        ctaButton.setTitle(benefit.ctaTitle, for: .normal)
    }
}
