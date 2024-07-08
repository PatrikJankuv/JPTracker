//
//  DescriptionComponent.swift
//  Stocks
//
//  Created by Patrik Jankuv on 04/07/2024.
//

import SwiftUI

struct DescriptionComponent: View {
    let stockInfo: StockInfo
    @State var showFullDescription = false
    let maxCharactersToShow = 300
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Description")
                .font(.headline)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
            Text(trimmedDescription(stockInfo: stockInfo, showFullDescription: showFullDescription, maxCharactersToShow: maxCharactersToShow))
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 8)
            Button(action: {
                showFullDescription.toggle()
            }) {
                Text(showFullDescription ? "Less" : "More")
                    .foregroundColor(Color("Primary"))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
            }
        }
        .background(Color("Background"))
        .cornerRadius(10)
        .shadow(radius: 4)
        .padding(.bottom)
    }
    
    private func trimmedDescription(stockInfo: StockInfo, showFullDescription: Bool, maxCharactersToShow: Int) -> String {
        if showFullDescription {
            return stockInfo.description
        } else {
            if stockInfo.description.count > maxCharactersToShow {
                let index = stockInfo.description.index(stockInfo.description.startIndex, offsetBy: maxCharactersToShow)
                return String(stockInfo.description.prefix(upTo: index)) + "..."
            } else {
                return stockInfo.description
            }
        }
    }
}
