//
//  UserProfileSettings.swift
//  EnvironmentObjTest
//
//  Created by 박성준 on 2023/12/20.
//

import Foundation

final class UserProfileSettings: ObservableObject {
    @Published var name: String = ""
    @Published var age: Int = 0
    
    func haveBirthdayParty() {
        age += 1
    }
}
