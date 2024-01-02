//
//  DiaryListViewModel.swift
//  EmotionDiary
//
//  Created by 박성준 on 2024/01/02.
//

/*
 전체 DiaryMood 리스트의 데이터(Sequence) => 월별로 따로 저장(Dictionary Type)
    - {"2022-04" : [DiaryMoode]}
 */

import Foundation

final class DiaryListViewModel: ObservableObject {
    @Published var list: [MoodDiary] = MoodDiary.list
    @Published var dic: [String : [MoodDiary]] = [:]
    
    init() {
        self.dic = Dictionary(grouping: self.list, by: { $0.monthlyIdentifier })
    }
    
    // Key(년월)을 시간순으로 정렬 후 Return
    var keys: [String] {
        return dic.keys.sorted { $0 < $1 }
    }
}
