//
//  DiaryViewModel.swift
//  EmotionDiary
//
//  Created by 박성준 on 2024/01/03.
//

import Foundation
import SwiftUI
import Combine

final class DiaryViewModel: ObservableObject {
    @Published var isPresented: Binding<Bool>
    @Published var date: Date = Date()
    var subscriptions = Set<AnyCancellable>()
    
    init(isPresented: Binding<Bool>) {
        self.isPresented = isPresented
        
        $date
            .receive(on: RunLoop.main)
            .sink { date in
                print(date)
            }.store(in: &subscriptions)
    }
}
