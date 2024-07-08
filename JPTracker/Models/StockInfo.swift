//
//  StockInfo.swift
//  Stocks
//
//  Created by Patrik Jankuv on 03/07/2024.
//

import Foundation

struct StockInfo: Codable {
    let symbol: String
    let assetType: String
    let name: String
    let description: String
    let cik: String
    let exchange: String
    let currency: String
    let country: String
    let sector: String
    let industry: String
    let address: String
    let fiscalYearEnd: String
    let latestQuarter: String
    let marketCapitalization: String
    let ebitda: String
    let peRatio: String
    let pegRatio: String
    let bookValue: String
    let dividendPerShare: String
    let dividendYield: String
    let eps: String
    let revenuePerShareTTM: String
    let profitMargin: String
    let operatingMarginTTM: String
    let returnOnAssetsTTM: String
    let returnOnEquityTTM: String
    let revenueTTM: String
    let grossProfitTTM: String
    let dilutedEPSTTM: String
    let quarterlyEarningsGrowthYOY: String
    let quarterlyRevenueGrowthYOY: String
    let analystTargetPrice: String
    let analystRatingStrongBuy: String
    let analystRatingBuy: String
    let analystRatingHold: String
    let analystRatingSell: String
    let analystRatingStrongSell: String
    let trailingPE: String
    let forwardPE: String
    let priceToSalesRatioTTM: String
    let priceToBookRatio: String
    let evToRevenue: String
    let evToEBITDA: String
    let beta: String
    let fiftyTwoWeekHigh: String
    let fiftyTwoWeekLow: String
    let fiftyDayMovingAverage: String
    let twoHundredDayMovingAverage: String
    let sharesOutstanding: String
    let dividendDate: String
    let exDividendDate: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case assetType = "AssetType"
        case name = "Name"
        case description = "Description"
        case cik = "CIK"
        case exchange = "Exchange"
        case currency = "Currency"
        case country = "Country"
        case sector = "Sector"
        case industry = "Industry"
        case address = "Address"
        case fiscalYearEnd = "FiscalYearEnd"
        case latestQuarter = "LatestQuarter"
        case marketCapitalization = "MarketCapitalization"
        case ebitda = "EBITDA"
        case peRatio = "PERatio"
        case pegRatio = "PEGRatio"
        case bookValue = "BookValue"
        case dividendPerShare = "DividendPerShare"
        case dividendYield = "DividendYield"
        case eps = "EPS"
        case revenuePerShareTTM = "RevenuePerShareTTM"
        case profitMargin = "ProfitMargin"
        case operatingMarginTTM = "OperatingMarginTTM"
        case returnOnAssetsTTM = "ReturnOnAssetsTTM"
        case returnOnEquityTTM = "ReturnOnEquityTTM"
        case revenueTTM = "RevenueTTM"
        case grossProfitTTM = "GrossProfitTTM"
        case dilutedEPSTTM = "DilutedEPSTTM"
        case quarterlyEarningsGrowthYOY = "QuarterlyEarningsGrowthYOY"
        case quarterlyRevenueGrowthYOY = "QuarterlyRevenueGrowthYOY"
        case analystTargetPrice = "AnalystTargetPrice"
        case analystRatingStrongBuy = "AnalystRatingStrongBuy"
        case analystRatingBuy = "AnalystRatingBuy"
        case analystRatingHold = "AnalystRatingHold"
        case analystRatingSell = "AnalystRatingSell"
        case analystRatingStrongSell = "AnalystRatingStrongSell"
        case trailingPE = "TrailingPE"
        case forwardPE = "ForwardPE"
        case priceToSalesRatioTTM = "PriceToSalesRatioTTM"
        case priceToBookRatio = "PriceToBookRatio"
        case evToRevenue = "EVToRevenue"
        case evToEBITDA = "EVToEBITDA"
        case beta = "Beta"
        case fiftyTwoWeekHigh = "52WeekHigh"
        case fiftyTwoWeekLow = "52WeekLow"
        case fiftyDayMovingAverage = "50DayMovingAverage"
        case twoHundredDayMovingAverage = "200DayMovingAverage"
        case sharesOutstanding = "SharesOutstanding"
        case dividendDate = "DividendDate"
        case exDividendDate = "ExDividendDate"
    }
}
