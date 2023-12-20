//
//  SecondView.swift
//  EnvironmentObjTest
//
//  Created by 박성준 on 2023/12/20.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
            VStack(spacing: 30) {
                NavigationLink {
                    ThirdView()
                } label: {
                    Text("Third View")
                }
            }.navigationTitle("Second View")
        
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
