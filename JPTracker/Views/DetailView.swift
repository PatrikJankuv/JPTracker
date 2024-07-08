import SwiftUI
import Combine
import Charts



struct DetailView: View {
    @StateObject private var viewModel = DetailViewModel()
    let symbol: String
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                Text("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
                Image(systemName: "network.slash")
                Text(errorMessage)
            } else if let stockInfo = viewModel.stockInfo {
                ScrollView {
                    VStack(alignment: .leading, spacing: 4) {
                        HeaderView(stockInfo: stockInfo, stockDailyData: viewModel.stockDailyData, price: viewModel.stockPrice!, differente: viewModel.getDifference(for: viewModel.currentChartRange), differentePerc: viewModel.getDifferenceInPercentage(for: viewModel.currentChartRange))
                            .padding()
                    
                        if let closePrices = viewModel.chartData(for: viewModel.currentChartRange) {
                            ChartView(currentChartRange: $viewModel.currentChartRange, prices: closePrices)
                                .padding(.horizontal)
                        } else {
                            Text("No data available for the selected range.")
                                .padding()
                        }
                        
                        StockDetailsComponent(stockInfo: stockInfo)
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadData(for: symbol)
        }
    }
}


class DetailViewModel: ObservableObject {
    @Published var stockInfo: StockInfo?
    @Published var stockIntraDayData: IntraDayTimeSeriesResponse?
    @Published var stockDailyData: DailyTimeSeriesResponse?
    @Published var stockMonthlyData: MonthlyTimeSeriesResponse?
    @Published var stockWeeklyData: WeeklyTimeSeriesResponse?
    @Published var currentChartRange: ChartRange = .oneDay
    @Published var isLoading = true
    @Published var errorMessage: String?
    @Published var showFullDescription = false
    @Published var cancellables = Set<AnyCancellable>()
    @Published var stockPrice: Double?
    
    
    func loadData(for symbol: String) {
        let basicStockInfoPublisher = StockService.fetchBasicStockInfo(for: symbol)
        let stockDailyDataPublisher = StockService.fetchStockDailyData(for: symbol)
        let stockIntraDayDataPublisher = StockService.fetchStockIntraDayData(for: symbol)
        let stockWeeklyDataPublisher = StockService.fetchStockWeeklyData(for: symbol)
        let stockMonthlyDataPublisher = StockService.fetchStockMonthlyData(for: symbol)
        
        Publishers.Zip3(basicStockInfoPublisher, stockWeeklyDataPublisher, stockMonthlyDataPublisher)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                case .finished:
                    break
                }
            }, receiveValue: { stockInfo, stockWeeklyData, stockMonthlyData in
                self.stockInfo = stockInfo
                self.stockWeeklyData = stockWeeklyData
                self.stockMonthlyData = stockMonthlyData
                self.stockPrice = stockMonthlyData.getCurrentPrice()
            })
            .store(in: &cancellables)
        
        Publishers.Zip(stockDailyDataPublisher, stockIntraDayDataPublisher)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                case .finished:
                    break
                }
            }, receiveValue: {stockDailyData, stockIntraDayData in
                self.stockDailyData = stockDailyData
                self.stockIntraDayData = stockIntraDayData
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    func chartData(for range: ChartRange) -> [(String, Double)]? {
        switch range {
        case .oneDay:
            return self.stockIntraDayData?.getAllPrices()
        case .last3Months:
            return self.stockDailyData?.getAllPrices()
        case .last1Year:
            return self.stockWeeklyData?.getLast1YearsClosePrices()
        case .last3Years:
            return self.stockWeeklyData?.getLast3YearsClosePrices()
        case .all:
            return self.stockWeeklyData?.getLast5YearsClosePrices()
        }
    }
    
    // New function to calculate the difference based on currentChartRange
    func getDifference(for range: ChartRange) -> Double {
      guard let closePrices = chartData(for: range) else { return 0.0 }
      if closePrices.isEmpty { return 0.0 }

      let firstPrice = closePrices.first!.1
      let lastPrice = closePrices.last!.1

      return lastPrice - firstPrice
    }
    
    // New function to calculate the difference based on currentChartRange
    func getDifferenceInPercentage(for range: ChartRange) -> Double {
      guard let closePrices = chartData(for: range) else { return 0.0 }
      if closePrices.isEmpty { return 0.0 }

      let firstPrice = closePrices.first!.1
      let lastPrice = closePrices.last!.1

      return ((lastPrice - firstPrice) / firstPrice) * 100
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(symbol: "IBM")
    }
}
