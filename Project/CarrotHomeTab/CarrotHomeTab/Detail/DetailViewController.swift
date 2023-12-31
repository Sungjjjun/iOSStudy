//
//  DetailViewController.swift
//  CarrotHomeTab
//
//  Created by 박성준 on 2023/12/28.
//


// ItemInfo에 있는 PostID를 통해 서버에 해당 제품의 상세 정보 요청
import UIKit

class DetailViewController: UIViewController {

    var detailViewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        detailViewModel.fetch()
    }
    
    private func bind() {
        
    }
}
