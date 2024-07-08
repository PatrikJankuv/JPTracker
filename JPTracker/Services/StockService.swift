import Foundation
import Combine

class StockService: AlphaVantageService {
    static func fetchBasicStockInfo(for symbol: String) -> AnyPublisher<StockInfo, Error> {
        let urlString = "https://www.alphavantage.co/query?function=OVERVIEW&symbol=\(symbol)&apikey=\(apiKey)"
        return fetchData(from: urlString, decodeTo: StockInfo.self)
    }
    
    static func fetchStockIntraDayData(for symbol: String) -> AnyPublisher<IntraDayTimeSeriesResponse, Error> {
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=5min&apikey=\(apiKey)"
        return fetchData(from: urlString, decodeTo: IntraDayTimeSeriesResponse.self)
    }
    
    static func fetchStockDailyData(for symbol: String) -> AnyPublisher<DailyTimeSeriesResponse, Error> {
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=\(symbol)&apikey=\(apiKey)"
        return fetchData(from: urlString, decodeTo: DailyTimeSeriesResponse.self)
    }
    
    static func fetchStockMonthlyData(for symbol: String) -> AnyPublisher<MonthlyTimeSeriesResponse, Error> {
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=\(symbol)&apikey=\(apiKey)"
        return fetchData(from: urlString, decodeTo: MonthlyTimeSeriesResponse.self)
    }
    
    static func fetchStockWeeklyData(for symbol: String) -> AnyPublisher<WeeklyTimeSeriesResponse, Error> {
        let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=\(symbol)&apikey=\(apiKey)"
        return fetchData(from: urlString, decodeTo: WeeklyTimeSeriesResponse.self)
    }
    
    private static func fetchData<T: Decodable>(from urlString: String, decodeTo type: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: NSError(domain: "Invalid URL", code: -1, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> T in
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
