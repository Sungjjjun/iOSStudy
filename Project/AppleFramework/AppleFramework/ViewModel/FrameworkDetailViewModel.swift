//
//  FrameworkDetailViewModel.swift
//  AppleFramework
//
//  Created by 박성준 on 2023/12/14.
//

import Foundation
import Combine

class FrameworkDetailViewModel {
    init(framework: AppleFramework) {
        self.framework = CurrentValueSubject(framework)
    }
    
    // Data => Output
    let framework: CurrentValueSubject<AppleFramework, Never>
    
    // User Action => Input
    let buttonTapped = PassthroughSubject<AppleFramework, Never>()
    
    func learnMoreTapped() {
        buttonTapped.send(framework.value)
    }
}
