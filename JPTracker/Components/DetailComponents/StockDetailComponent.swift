//
//  StockDetailComponent.swift
//  Stocks
//
//  Created by Patrik Jankuv on 04/07/2024.
//

import SwiftUI


struct StockDetailsComponent: View {
    let stockInfo: StockInfo

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                StockBasicInfoComponent(stockInfo: stockInfo)
                    .padding(.horizontal)
                    .padding(.top)
                Spacer()
                CustomSegmentedControl(categories: getCategories())
                Spacer()
                DescriptionComponent(stockInfo: stockInfo)
                    .padding(.horizontal)
            }
            }
        }
        
    private func getCategories() -> [Category]{
        let categories = [
            Category(title: "Basic Information", attributes: [
                "Symbol": stockInfo.symbol,
                "Asset Type": stockInfo.assetType,
                "Name": stockInfo.name,
                "Currency": stockInfo.currency,
                "Country": stockInfo.country,
                "Sector": stockInfo.sector,
                "Industry   ": stockInfo.industry,
                "Shares Outstanding": stockInfo.sharesOutstanding,
                "Address    ": stockInfo.address
            ]),
            Category(title: "Financial Metrics", attributes: [
                "Market Capitalization": stockInfo.marketCapitalization,
                "EBITDA": stockInfo.ebitda,
                "P/E Ratio": stockInfo.peRatio,
                "PEG Ratio": stockInfo.pegRatio,
                "Book Value": stockInfo.bookValue,
                "Dividend Per Share": stockInfo.dividendPerShare,
                "Dividend Yield": stockInfo.dividendYield,
                "EPS": stockInfo.eps,
                "Revenue Per Share (TTM)": stockInfo.revenuePerShareTTM,
                "Dividend Date": stockInfo.dividendDate,
                "Ex-Dividend Date": stockInfo.exDividendDate
            ]),
            Category(title: "Profitability and Margins", attributes: [
                "Profit Margin": stockInfo.profitMargin,
                "Operating Margin (TTM)": stockInfo.operatingMarginTTM,
                "Return on Assets (TTM)": stockInfo.returnOnAssetsTTM,
                "Return on Equity (TTM)": stockInfo.returnOnEquityTTM
            ]),
            Category(title: "Financial Performance", attributes: [
                "Latest Quarter": stockInfo.latestQuarter,
                "Fiscal Year End": stockInfo.fiscalYearEnd,
                "Revenue (TTM)": stockInfo.revenueTTM,
                "Gross Profit (TTM)": stockInfo.grossProfitTTM,
                "Diluted EPS (TTM)": stockInfo.dilutedEPSTTM,
                "Quarterly Earnings Growth (YOY)": stockInfo.quarterlyEarningsGrowthYOY,
                "Quarterly Revenue Growth (YOY)": stockInfo.quarterlyRevenueGrowthYOY
            ]),
            Category(title: "Analyst Ratings and Price Targets", attributes: [
                "Analyst Target Price": stockInfo.analystTargetPrice,
                "Strong Buy Ratings": stockInfo.analystRatingStrongBuy,
                "Buy Ratings": stockInfo.analystRatingBuy,
                "Hold Ratings": stockInfo.analystRatingHold,
                "Sell Ratings": stockInfo.analystRatingSell,
                "Strong Sell Ratings": stockInfo.analystRatingStrongSell
            ]),
            Category(title: "Valuation Metrics", attributes: [
                "Trailing P/E": stockInfo.trailingPE,
                "Forward P/E": stockInfo.forwardPE,
                "Price to Sales Ratio (TTM)": stockInfo.priceToSalesRatioTTM,
                "Price to Book Ratio": stockInfo.priceToBookRatio,
                "EV to Revenue": stockInfo.evToRevenue,
                "EV to EBITDA": stockInfo.evToEBITDA,
                "Beta": stockInfo.beta
            ]),
            Category(title: "Market Data", attributes: [
                "52-Week High": stockInfo.fiftyTwoWeekHigh,
                "52-Week Low": stockInfo.fiftyTwoWeekLow,
                "50-Day Moving Average": stockInfo.fiftyDayMovingAverage,
                "200-Day Moving Average": stockInfo.twoHundredDayMovingAverage
            ])
        ]

        return categories
    }
}


struct StockDetailComponent_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailsComponent(stockInfo: StockInfo(symbol: "IBM", assetType: "Common Stock", name: "International Business Machines", description: "International Business Machines Corporation (IBM) is an American multinational technology company headquartered in Armonk, New York, with operations in over 170 countries. The company began in 1911, founded in Endicott, New York, as the Computing-Tabulating-Recording Company (CTR) and was renamed International Business Machines in 1924. IBM is incorporated in New York. IBM produces and sells computer hardware, middleware and software, and provides hosting and consulting services in areas ranging from mainframe computers to nanotechnology. IBM is also a major research organization, holding the record for most annual U.S. patents generated by a business (as of 2020) for 28 consecutive years. Inventions by IBM include the automated teller machine (ATM), the floppy disk, the hard disk drive, the magnetic stripe card, the relational database, the SQL programming language, the UPC barcode, and dynamic random-access memory (DRAM). The IBM mainframe, exemplified by the System/360, was the dominant computing platform during the 1960s and 1970s.", cik: "51143", exchange: "NYSE", currency: "USD", country: "USA", sector: "TECHNOLOGY", industry: "COMPUTER & OFFICE EQUIPMENT", address: "1 NEW ORCHARD ROAD, ARMONK, NY, US", fiscalYearEnd: "December", latestQuarter: "2024-03-31", marketCapitalization: "161426096000", ebitda: "14380000000", peRatio: "19.92", pegRatio: "4.2", bookValue: "25.32", dividendPerShare: "6.64", dividendYield: "0.038", eps: "8.82", revenuePerShareTTM: "67.94", profitMargin: "0.132", operatingMarginTTM: "0.102", returnOnAssetsTTM: "0.0458", returnOnEquityTTM: "0.362", revenueTTM: "62068998000", grossProfitTTM: "32688000000", dilutedEPSTTM: "8.82", quarterlyEarningsGrowthYOY: "0.701", quarterlyRevenueGrowthYOY: "0.015", analystTargetPrice: "168.44", analystRatingStrongBuy: "4", analystRatingBuy: "5", analystRatingHold: "9", analystRatingSell: "3", analystRatingStrongSell: "0", trailingPE: "19.92", forwardPE: "18.12", priceToSalesRatioTTM: "2.701", priceToBookRatio: "7.42", evToRevenue: "3.453", evToEBITDA: "14.54", beta: "0.706", fiftyTwoWeekHigh: "197.22", fiftyTwoWeekLow: "126.32", fiftyDayMovingAverage: "170.03", twoHundredDayMovingAverage: "167.87", sharesOutstanding: "918603000", dividendDate: "2024-06-10", exDividendDate: "2024-05-09"))
    }
}
