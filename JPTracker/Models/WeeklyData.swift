//
//  WeeklyData.swift
//  Stocks
//
//  Created by Patrik Jankuv on 06/07/2024.
//


import Foundation

struct WeeklyTimeSeriesResponse: Codable {
    let metaData: MetaData
    let timeSeriesDaily: [String: TimeSeriesDay]
    
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDaily = "Weekly Time Series"
    }
    
    // Method to get last 3 years (156 weeks) of close prices
    func getLast1YearsClosePrices() -> [(String, Double)]? {
        return getClosePrices(for: 52)
    }

    // Method to get last 3 years (156 weeks) of close prices
    func getLast3YearsClosePrices() -> [(String, Double)]? {
        return getClosePrices(for: 156)
    }

    // Method to get last 5 years (261 weeks) of close prices
    func getLast5YearsClosePrices() -> [(String, Double)]? {
        return getClosePrices(for: 261)
    }

    
    // Helper method to get close prices for a specified number of months
    private func getClosePrices(for months: Int) -> [(String, Double)]? {
        let timeSeries = timeSeriesDaily
        let sortedDates = timeSeries.keys.sorted(by: >) // Sort dates in descending order to get the latest first
        let lastDates = sortedDates.prefix(months) // Get the last `months` records
        let closes = lastDates.compactMap { date -> (String, Double)? in
            guard let close = timeSeries[date]?.close, let closeValue = Double(close) else { return nil }
            return (date, closeValue)
        }
        return closes.sorted(by: { $0.0 < $1.0 }) // Sort by date
    }

}
