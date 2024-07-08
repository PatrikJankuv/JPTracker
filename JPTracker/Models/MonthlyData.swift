//
//  MonthlyData.swift
//  Stocks
//
//  Created by Patrik Jankuv on 04/07/2024.
//

import Foundation

struct MonthlyTimeSeriesResponse: Codable {
    let metaData: MetaData
    let timeSeriesDaily: [String: TimeSeriesDay]
    
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDaily = "Monthly Time Series"
    }
    
    // Method to get monthly close prices as [Double]
    func getAllMonthClosePrices() -> [(String, Double)]? {
        let timeSeries = timeSeriesDaily
        let dates = timeSeries.keys.sorted() // Assuming you want to plot in chronological order
        let closes = dates.compactMap { date -> (String, Double)? in
            guard let close = timeSeries[date]?.close, let closeValue = Double(close) else { return nil }
            return (date, closeValue)
        }
        return closes
    }
    
    // Method to get monthly close prices as [Double]
    func getCurrentPrice() -> Double? {
        let timeSeries = timeSeriesDaily
        let dates = timeSeries.keys.sorted() // Assuming you want to plot in chronological order
        let closes = dates.compactMap { date -> (String, Double)? in
            guard let close = timeSeries[date]?.close, let closeValue = Double(close) else { return nil }
            return (date, closeValue)
        }
        return closes.last?.1
    }
}
