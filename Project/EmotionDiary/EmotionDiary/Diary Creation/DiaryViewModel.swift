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
    
    @Published var diaries: Binding<[MoodDiary]>
    @Published var isPresented: Binding<Bool>
    @Published var date: Date = Date()
    @Published var mood: Mood = .great
    @Published var text: String = ""
    
    var subscriptions = Set<AnyCancellable>()
    
    init(isPresented: Binding<Bool>, diaries: Binding<[MoodDiary]>) {
        self.isPresented = isPresented
        self.diaries = diaries
        
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
        
        // 내용 업데이트
        $text
            .receive(on: RunLoop.main)
            .sink { text in
                self.updateText(text: text)
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
    
    private func updateText(text: String) {
        self.diary.text = text
    }
    
    func completed() {
        guard diary.date.isEmpty == false else { return }
        print("일기 작성 완료")
        
        // 저장 [✅]
        diaries.wrappedValue.append(diary)
        
        // 페이지 닫기 [✅]
        isPresented.wrappedValue = false
    }
    
    func delete() {
        
    }
}
