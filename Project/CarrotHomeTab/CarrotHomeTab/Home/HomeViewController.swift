//
//  HomeViewController.swift
//  CarrotHomeTab
//
//  Created by 박성준 on 2023/12/28.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    let viewModel: HomeViewModel = HomeViewModel(network: NetworkService(configuration: .default))
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.fetch()
    }
    
    private func bind() {
        // Output(Data)
        viewModel.$items
            .receive(on: RunLoop.main)
            .sink { items in
                print("Update Collection View: \(items)")
            }.store(in: &subscriptions)
        
        // Input(User Interaction)
        viewModel.itemTapped
            .sink { item in
                let detailStoryBoard = UIStoryboard(name: "Detail", bundle: nil)
                let detailViewController = detailStoryBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }.store(in: &subscriptions)
    }
    
//    @IBAction func ctaButtonTapped(_ sender: Any) {
//        let detailStoryBoard = UIStoryboard(name: "Detail", bundle: nil)
//        let detailViewController = detailStoryBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        navigationController?.pushViewController(detailViewController, animated: true)
//    }
}
