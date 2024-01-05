//
//  DiaryDetailsViewModel.swift
//  EmotionDiary
//
//  Created by 박성준 on 2024/01/06.
//

import Foundation
import SwiftUI
import Combine

final class DiaryDetailsViewModel: ObservableObject {
    @Published var diary: MoodDiary = MoodDiary(date: "", text: "", mood: .great)
    
    @Published var diaries: Binding<[MoodDiary]>
    
    init(diary: MoodDiary, diaries: Binding<[MoodDiary]>) {
        self.diary = diary
        self.diaries = diaries
    }
    
    func delete() {
        diaries.wrappedValue = diaries.wrappedValue.filter { $0.id != diary.id }
    }
}
