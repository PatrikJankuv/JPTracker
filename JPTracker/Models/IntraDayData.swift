//
//  IntraDayData.swift
//  Stocks
//
//  Created by Patrik Jankuv on 06/07/2024.
//

import Foundation

struct IntraDayTimeSeriesResponse: Codable {
    let metaData: IntraDayMetaData
    let timeSeriesDaily: [String: TimeSeriesDay]
    
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDaily = "Time Series (5min)"
    }
    
    // Method to get monthly close prices as [Double]
    func getAllPrices() -> [(String, Double)]? {
        let timeSeries = timeSeriesDaily
        let dates = timeSeries.keys.sorted() // Assuming you want to plot in chronological order
        let closes = dates.compactMap { date -> (String, Double)? in
            guard let close = timeSeries[date]?.close, let closeValue = Double(close) else { return nil }
            return (date, closeValue)
        }
        return closes
    }
}
