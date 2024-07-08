//
//  HeaderComponent.swift
//  Stocks
//
//  Created by Patrik Jankuv on 04/07/2024.
//

import SwiftUI

struct HeaderView: View {
    let stockInfo: StockInfo
    let stockDailyData: DailyTimeSeriesResponse?
    let price: Double
    let differente: Double
    let differentePerc: Double
    
    var body: some View {
        VStack {
            Text(stockInfo.name)
                .font(.title)
                .multilineTextAlignment(.leading)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading) // Ensure text expands to fill VStack width
                .fixedSize(horizontal: false, vertical: true) // Allow multiline if needed
            HStack {
                VStack(alignment: .leading) {
                    Text(stockInfo.symbol)
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer() // Pushes content to top-left corner
                }
                Spacer() // Pushes VStack to the left
                VStack(alignment: .trailing) {
                    Text("\(String(format: "%.2f", price)) $")
                        .font(.title)
                        .multilineTextAlignment(.leading)
                    
                    Label {
                        Text("\(Utils.doubleToString(differente)) (\(Utils.doubleToString(differentePerc))%)")
                            .font(.body)
                            .foregroundColor(determineColor())
                    } icon: {
                        determineIcon()
                            .foregroundColor(determineColor())
                    }
                }
            }
        }
    }
    
    
    private func determineIcon() -> Image {
            if differente > 0 {
                return Image(systemName: "arrowtriangle.up.fill")
            } else if differente < 0 {
                return Image(systemName: "arrowtriangle.down.fill")
            } else {
                // Handle case where differente is zero (optional)
                return Image(systemName: "arrowtriangle.right.fill")
            }
        }

        private func determineColor() -> Color {
            if differente > 0 {
                return .green
            } else if differente < 0 {
                return .red
            } else {
                return .gray
            }
        }
}
