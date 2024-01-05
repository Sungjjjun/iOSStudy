//
//  DiaryListViewModel.swift
//  EmotionDiary
//
//  Created by 박성준 on 2024/01/02.
//

/*
 전체 DiaryMood 리스트의 데이터(Sequence) => 월별로 따로 저장(Dictionary Type)
    - {"2022-04" : [DiaryMoode]}
 
 1. 초기 단계에서 기기 내부의 Storage에 저장된 MoodDiary에 접근
 2. 저장된 MoodDiary를 읽어 list에 저장
 3. 저장된 list를 기반으로 dictionary 생성
 */

import Foundation
import Combine

final class DiaryListViewModel: ObservableObject {
    let storage: MoodDiaryStorage
    
    @Published var list: [MoodDiary] = MoodDiary.list
    @Published var dic: [String : [MoodDiary]] = [:]
    var subscriptions = Set<AnyCancellable>()
    
    init(storage: MoodDiaryStorage) {
        self.storage = storage
        bind()
    }
    
    // Key(년월)을 시간순으로 정렬 후 Return
    var keys: [String] {
        return dic.keys.sorted { $0 < $1 }
    }
    
    // 초기 list 세팅 이후, dictionary 생성 및 storage 저장
    private func bind() {
        $list.sink { items in
            print("=====> List Changed: \(items)")
            self.dic = Dictionary(grouping: items, by: { $0.monthlyIdentifier })
            self.persist(items: items)
        }.store(in: &subscriptions)
    }
    
    // storage 저장
    func persist(items: [MoodDiary]) {
        guard items.isEmpty == false else { return }
        self.storage.persist(items)
    }
    
    // storage에서 MoodDiary list 읽어오기
    func fetch() {
        self.list = storage.fetch()
    }
}
