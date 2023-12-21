//
//  FrameworkDetailViewModel.swift
//  AppleFramework-SwiftUI
//
//  Created by 박성준 on 2023/12/21.
//

import Foundation
import SwiftUI

final class FrameworkDetailViewModel: ObservableObject {
    @Published var framework: AppleFramework
    @Published var isSafariViewPresented: Bool = false

    init(framework: AppleFramework) {
        self.framework = framework
    }
}
