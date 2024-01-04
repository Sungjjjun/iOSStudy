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
    @Published var diary: MoodDiary = MoodDiary(date: "", text: "", mood: .great)
    
    @Published var isPresented: Binding<Bool>
    @Published var date: Date = Date()
    @Published var mood: Mood = .great
    
    var subscriptions = Set<AnyCancellable>()
    
    init(isPresented: Binding<Bool>) {
        self.isPresented = isPresented
        
        // 날짜 업데이트
        $date
            .receive(on: RunLoop.main)
            .sink { date in
                self.updateDate(date: date)
            }.store(in: &subscriptions)
        
        // 기분 업데이트
        $mood
            .receive(on: RunLoop.main)
            .sink { mood in
                self.updateMood(mood: mood)
            }.store(in: &subscriptions)
    }
    
    private func updateDate(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        let dateString = formatter.string(from: date)
        self.diary.date = dateString
    }
    
    private func updateMood(mood: Mood) {
        self.diary.mood = mood
    }
}
