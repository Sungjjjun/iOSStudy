//
//  ButtonView.swift
//  SwiftUI-Basic
//
//  Created by 박성준 on 2023/12/15.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        Button {
            print("Button Clicked")
        } label: {
            Text("Click Me")
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
