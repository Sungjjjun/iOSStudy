//
//  DetailViewModel.swift
//  CarrotHomeTab
//
//  Created by 박성준 on 2023/12/31.
//

import Foundation
import Combine

final class DetailViewModel {
    let network: NetworkService
    let itemInfo: ItemInfo
    
    @Published var itemInfoDetails: ItemInfoDetails? = nil
    var subscriptions = Set<AnyCancellable>()
    
    init(network: NetworkService, itemInfo: ItemInfo) {
        self.network = network
        self.itemInfo = itemInfo
    }
    
    func fetch() {
        // Simulate Network
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) { [unowned self] in
            self.itemInfoDetails = ItemInfoDetails(user: User.mock, item: self.itemInfo, details: ItemExtraInfo.mock)
        }
        
        // Real Network
//        let resource: Resource<ItemInfoDetails> = Resource(
//            base: "",
//            path: "",
//            params: [:],
//            header: [:]
//        )
//
//        network.load(resource)
//            .receive(on: RunLoop.main)
//            .sink { completion in
//                switch completion {
//                case .failure(let error):
//                    print("Error: \(error)")
//                case .finished:
//                    print("Finished")
//                }
//            } receiveValue: { itemDetails in
//                print(itemDetails)
//            }.store(in: &subscriptions)

    }
}
