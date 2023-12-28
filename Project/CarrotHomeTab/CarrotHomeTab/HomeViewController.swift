//
//  HomeViewController.swift
//  CarrotHomeTab
//
//  Created by 박성준 on 2023/12/28.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func ctaButtonTapped(_ sender: Any) {
        let detailStoryBoard = UIStoryboard(name: "Detail", bundle: nil)
        let detailViewController = detailStoryBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
