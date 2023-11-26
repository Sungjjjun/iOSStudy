//
//  ChatingListViewController.swift
//  ChatingList
//
//  Created by 박성준 on 2023/11/24.
//

import UIKit

class ChatingListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var chat: [Chat] = Chat.list

    
    override func viewDidLoad() {
        super.viewDidLoad()
        chat.sort(by: {chat1, chat2 in
            return chat1.date > chat2.date
        })
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension ChatingListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chat.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatingListCollectionViewCell", for: indexPath) as? ChatingListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(chat[indexPath.item])
        return cell
    }
    
    
}

extension ChatingListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}
