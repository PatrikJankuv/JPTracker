//
//  MockStockService.swift
//  Stocks
//
//  Created by Patrik Jankuv on 04/07/2024.
//

import Foundation
import Combine


class MockStockService {
    static let cacheExpirationInterval: TimeInterval = 3600 // Cache expiration interval in seconds
    static var cache: [String: (timestamp: Date, stockInfo: StockInfo?, dailyData: DailyTimeSeriesResponse?)] = [:]
    
    static func fetchBasicStockInfo(for symbol: String) -> AnyPublisher<StockInfo, Error> {
        if let cachedData = cache[symbol], let stockInfo = cachedData.stockInfo, Date().timeIntervalSince(cachedData.timestamp) < cacheExpirationInterval {
            return Just(stockInfo)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            // Simulated stock info
            let stockInfo = StockInfo(
                symbol: "TSLA",
                assetType: "Common Stock",
                name: "Tesla Inc",
                description: "Tesla, Inc. is an American electric vehicle and clean energy company based in Palo Alto, California. Tesla's current products include electric cars, battery energy storage from home to grid-scale, solar panels and solar roof tiles, as well as other related products and services. In 2020, Tesla had the highest sales in the plug-in and battery electric passenger car segments, capturing 16% of the plug-in market (which includes plug-in hybrids) and 23% of the battery-electric (purely electric) market. Through its subsidiary Tesla Energy, the company develops and is a major installer of solar photovoltaic energy generation systems in the United States. Tesla Energy is also one of the largest global suppliers of battery energy storage systems, with 3 GWh of battery storage supplied in 2020.",
                cik: "1318605",
                exchange: "NASDAQ",
                currency: "USD",
                country: "USA",
                sector: "MANUFACTURING",
                industry: "MOTOR VEHICLES & PASSENGER CAR BODIES",
                address: "3500 DEER CREEK RD, PALO ALTO, CA, US",
                fiscalYearEnd: "December",
                latestQuarter: "2024-03-31",
                marketCapitalization: "737534345000",
                ebitda: "12265000000",
                peRatio: "59.15",
                pegRatio: "2.982",
                bookValue: "20.19",
                dividendPerShare: "None",
                dividendYield: "None",
                eps: "3.91",
                revenuePerShareTTM: "29.8",
                profitMargin: "0.144",
                operatingMarginTTM: "0.055",
                returnOnAssetsTTM: "0.0472",
                returnOnEquityTTM: "0.237",
                revenueTTM: "94745002000",
                grossProfitTTM: "20853000000",
                dilutedEPSTTM: "3.91",
                quarterlyEarningsGrowthYOY: "-0.534",
                quarterlyRevenueGrowthYOY: "-0.087",
                analystTargetPrice: "181.76",
                analystRatingStrongBuy: "7",
                analystRatingBuy: "13",
                analystRatingHold: "21",
                analystRatingSell: "6",
                analystRatingStrongSell: "4",
                trailingPE: "59.15",
                forwardPE: "67.57",
                priceToSalesRatioTTM: "5.67",
                priceToBookRatio: "8.35",
                evToRevenue: "12.42",
                evToEBITDA: "58.23",
                beta: "2.318",
                fiftyTwoWeekHigh: "299.29",
                fiftyTwoWeekLow: "138.8",
                fiftyDayMovingAverage: "179.34",
                twoHundredDayMovingAverage: "205.7",
                sharesOutstanding: "3189200000",
                dividendDate: "None",
                exDividendDate: "None"
            )
            
            cache[symbol] = (timestamp: Date(), stockInfo: stockInfo, dailyData: cache[symbol]?.dailyData)
            
            return Just(stockInfo)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    static func fetchStockDailyData(for symbol: String) -> AnyPublisher<DailyTimeSeriesResponse, Error> {
        if let cachedData = cache[symbol], let dailyData = cachedData.dailyData, Date().timeIntervalSince(cachedData.timestamp) < cacheExpirationInterval {
            return Just(dailyData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            // Simulated daily data
            let metaData = DailyMetaData(information: "Mock Information", symbol: symbol, lastRefreshed: "2024-07-03", outputSize: "Compact", timeZone: "US/Eastern")
            let timeSeriesDaily = [
                "2024-07-03": TimeSeriesDay(open: "115.0", high: "115.0", low: "105.0", close: "112.0", volume: "100000"),
                "2024-07-02": TimeSeriesDay(open: "108.0", high: "112.0", low: "105.0", close: "110.0", volume: "90000"),
                "2024-07-01": TimeSeriesDay(open: "105.0", high: "110.0", low: "102.0", close: "108.0", volume: "85000"),
                "2024-06-30": TimeSeriesDay(open: "107.0", high: "111.0", low: "104.0", close: "105.0", volume: "92000"),
                "2024-06-29": TimeSeriesDay(open: "109.0", high: "113.0", low: "106.0", close: "107.0", volume: "88000"),
                "2024-06-28": TimeSeriesDay(open: "112.0", high: "116.0", low: "108.0", close: "109.0", volume: "95000"),
                "2024-06-27": TimeSeriesDay(open: "115.0", high: "118.0", low: "111.0", close: "112.0", volume: "105000"),
                "2024-06-26": TimeSeriesDay(open: "113.0", high: "117.0", low: "110.0", close: "115.0", volume: "98000"),
                "2024-06-25": TimeSeriesDay(open: "112.0", high: "114.0", low: "108.0", close: "113.0", volume: "90000"),
                "2024-06-24": TimeSeriesDay(open: "110.0", high: "113.0", low: "106.0", close: "112.0", volume: "85000")
            ]
            
            let dailyData = DailyTimeSeriesResponse(metaData: metaData, timeSeriesDaily: timeSeriesDaily)
            
            cache[symbol] = (timestamp: Date(), stockInfo: cache[symbol]?.stockInfo, dailyData: dailyData)
            
            return Just(dailyData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    static func fetchStockMonthlyData(for symbol: String) -> AnyPublisher<MonthlyTimeSeriesResponse, Error> {
        
        
            // Simulated daily data
            let metaData = MetaData(information: "Mock Information", symbol: symbol, lastRefreshed: "2024-07-03", timeZone: "US/Eastern")
            let timeSeriesDaily = [
                "2024-07-03": TimeSeriesDay(open: "115.0", high: "115.0", low: "105.0", close: "112.0", volume: "100000"),
                "2024-07-02": TimeSeriesDay(open: "108.0", high: "112.0", low: "105.0", close: "110.0", volume: "90000"),
                "2024-07-01": TimeSeriesDay(open: "105.0", high: "110.0", low: "102.0", close: "108.0", volume: "85000"),
                "2024-06-30": TimeSeriesDay(open: "107.0", high: "111.0", low: "104.0", close: "105.0", volume: "92000"),
                "2024-06-29": TimeSeriesDay(open: "109.0", high: "113.0", low: "106.0", close: "107.0", volume: "88000"),
                "2024-06-28": TimeSeriesDay(open: "112.0", high: "116.0", low: "108.0", close: "109.0", volume: "95000"),
                "2024-06-27": TimeSeriesDay(open: "115.0", high: "118.0", low: "111.0", close: "112.0", volume: "105000"),
                "2024-06-26": TimeSeriesDay(open: "113.0", high: "117.0", low: "110.0", close: "115.0", volume: "98000"),
                "2024-06-25": TimeSeriesDay(open: "112.0", high: "114.0", low: "108.0", close: "113.0", volume: "90000"),
                "2024-06-24": TimeSeriesDay(open: "110.0", high: "113.0", low: "106.0", close: "112.0", volume: "85000")
            ]
            
            let dailyData = MonthlyTimeSeriesResponse(metaData: metaData, timeSeriesDaily: timeSeriesDaily)
                        
            return Just(dailyData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        
    }
}

