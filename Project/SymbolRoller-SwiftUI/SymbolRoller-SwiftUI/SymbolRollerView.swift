//
//  ContentView.swift
//  SymbolRoller-SwiftUI
//
//  Created by joonwon lee on 2022/05/21.
//

import SwiftUI

struct SymbolRollerView: View {
    
    let symbols: [String] = ["sun.min", "moon", "cloud", "wind", "snowflake"]
    
    @State private var imageName: String = "moon"
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding([.top, .leading, .trailing], 25.0)
                .foregroundColor(.black)
            Spacer()
            Text(imageName)
                .font(.system(size: 30, weight: .bold))
            Button {
                imageName = symbols.randomElement()!
            } label: {
                HStack {
                    Image(systemName: "arrow.3.trianglepath")
                    VStack {
                        Text("Reload")
                            .font(.system(size: 30, weight: .bold))
                        Text("click me to reload")
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 80)
            .foregroundColor(.white)
            .background(.pink)
            .clipShape(Capsule())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolRollerView()
    }
}
