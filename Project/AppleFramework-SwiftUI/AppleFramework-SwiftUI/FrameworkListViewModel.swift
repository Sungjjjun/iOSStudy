//
//  FrameworkListViewModel.swift
//  AppleFramework-SwiftUI
//
//  Created by 박성준 on 2023/12/20.
//

import Foundation

final class FrameworkListViewModel: ObservableObject {
    @Published var models: [AppleFramework] = AppleFramework.list
    @Published var selectedItem: AppleFramework?
    @Published var isShowingDetail: Bool = false
}
