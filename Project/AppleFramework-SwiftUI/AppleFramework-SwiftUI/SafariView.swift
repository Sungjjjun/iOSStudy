//
//  SafariView.swift
//  AppleFramework-SwiftUI
//
//  Created by 박성준 on 2023/12/21.
//

import SwiftUI
import SafariServices

struct SafariView:  UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}
