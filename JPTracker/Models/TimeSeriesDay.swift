//
//  TimeSeriesDay.swift
//  Stocks
//
//  Created by Patrik Jankuv on 04/07/2024.
//

import Foundation

struct TimeSeriesDay: Codable {
    let open: String
    let high: String
    let low: String
    let close: String
    let volume: String
    
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
    
    // Method to compute the change between open and close values
    func changeBetweenOpenAndClose() -> Double? {
        guard let openValue = Double(open), let closeValue = Double(close) else {
            return nil
        }
        return openValue - closeValue
    }
    
    // Method to compute the percentage difference between open and close values
    func percentageDifference() -> Double? {
        guard let openValue = Double(open), let closeValue = Double(close) else {
            return nil
        }
        return ((openValue - closeValue) / openValue) * 100
    }
}
