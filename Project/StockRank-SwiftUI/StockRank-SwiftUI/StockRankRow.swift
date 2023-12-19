//
//  StockRankRow.swift
//  StockRank-SwiftUI
//
//  Created by 박성준 on 2023/12/18.
//

import SwiftUI

struct StockRankRow: View {
    
    @Binding var stockModel: StockModel
    
    var body: some View {
        HStack {
            Text("\(stockModel.rank)")
                .font(.system(size: 15, weight: .bold))
                .frame(width: 30)
                .foregroundColor(.blue)
            Image(stockModel.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 5) {
                Text(stockModel.name)
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                HStack {
                    Text("\(stockModel.price)원")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text("\(stockModel.diff * 100, specifier: "%.2f")%")
                        .font(.system(size: 12))
                        .foregroundColor(stockModel.diff >= 0 ? .red : .blue)
                }
            }
            Spacer()
            Image(systemName: "heart.fill")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(stockModel.isFavorite ? .white : .gray)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

struct StockRankRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRankRow(stockModel: .constant(StockModel.list[2]))
            .previewLayout(.fixed(width: 390, height: 80))
    }
}
