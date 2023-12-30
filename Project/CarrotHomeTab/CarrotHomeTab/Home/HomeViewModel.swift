//
//  HomeViewModel.swift
//  CarrotHomeTab
//
//  Created by 박성준 on 2023/12/30.
//

import Foundation
import Combine

// List 가져오기(Network를 통해) [✅]
// Item 선택 시 다른 뷰로 Push [✅]
final class HomeViewModel {
    let network: NetworkService
    
    let itemTapped = PassthroughSubject<ItemInfo, Never>()
    var subscriptions = Set<AnyCancellable>()
    @Published var items: [ItemInfo] = []
    
    init(network: NetworkService) {
        self.network = network
    }
    
    // Network를 통해 데이터 가져오기
    func fetch() {
        let resource: Resource<[ItemInfo]> = Resource(
            base: "https://my-json-server.typicode.com/",
            path: "cafielo/demo/products",
            params: [:],
            header: ["Content-Type": "application/json"]
        )
        
        network.load(resource)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { items in
                self.items = items
            }.store(in: &subscriptions)
    }
}
