//
//  StockBasicInfo.swift
//  Stocks
//
//  Created by Patrik Jankuv on 07/07/2024.
//

import SwiftUI

struct StockBasicInfoComponent: View {
    let stockInfo: StockInfo
    
    var body: some View {
        // Info Card
        HStack{
            VStack(alignment: .center, spacing: 4) {
                infoRow(title: "Market Cap", value: "\(Utils.formatNumber(stockInfo.marketCapitalization)) $")
                infoRow(title: "Divident", value: stockInfo.dividendPerShare)
                infoRow(title: "52 Week High", value: stockInfo.fiftyTwoWeekHigh)
            }
            .frame(maxWidth: .infinity)
            Spacer()
            VStack(alignment: .center, spacing: 4) {
                infoRow(title: "PE Ratio", value: stockInfo.peRatio)
                infoRow(title: "Exchange", value: stockInfo.exchange)
                infoRow(title: "52 Week Low", value: stockInfo.fiftyTwoWeekLow)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color("Background"))
        .cornerRadius(10)
        .shadow(radius: 4)
    }
    
    private func infoRow(title: String, value: String) -> some View {
        VStack {
            Text("\(title):")
                .foregroundColor(.gray)
                .font(.footnote)
            Text(value)
                .font(.callout)
            Spacer()
        }
    }
}

//#Preview {
//    StockBasicInfoComponent()
//}
