//
//  ChartView.swift
//  Stocks
//
//  Created by Patrik Jankuv on 05/07/2024.
//

import SwiftUI
import Charts

enum ChartRange {
    case oneDay
    case last3Months
    case last1Year
    case last3Years
    case all
}

struct ChartView: View {
    @State private var isChartVisible = false
    @Binding var currentChartRange: ChartRange
    @State private var rawSelectedDate: String?
    @State private var selectedClosePrice: Double?
    let prices: [(String, Double)]
    
    var body: some View {
        let minClose = prices.min { $0.1 < $1.1 }?.1 ?? 0
        let maxClose = prices.max { $0.1 < $1.1 }?.1 ?? 0
        let diff = (maxClose - minClose < 30) ? (maxClose - minClose) : 30
        
        let minY = minClose - diff/4 // Start y-axis 40 units below the smallest record
        let maxY = maxClose + diff/4 // Start y-axis 25 units above the largest record
        
        // Chart section with range selector
        Picker(selection: $currentChartRange, label: Text("Select Range")) {
            Text("1 Day").tag(ChartRange.oneDay)
            Text("3 Months").tag(ChartRange.last3Months)
            Text("1 Year").tag(ChartRange.last1Year)
            Text("3 Years").tag(ChartRange.last3Years)
            Text("All").tag(ChartRange.all)
       }
       .pickerStyle(SegmentedPickerStyle())
       .padding(.top)
        
        Chart {
            ForEach(prices, id: \.0) { date, price in
                AreaMark(
                     x: .value("Date", date),
                     yStart: .value("Price", minY),
                     yEnd: .value("Price", price)
                 )
                 .foregroundStyle(LinearGradient(
                    gradient: Gradient(colors: [.purple.opacity(0.05), .blue.opacity(0.035), Color("Background")]),
                     startPoint: .top,
                     endPoint: .bottom
                 ))
                 .interpolationMethod(.catmullRom)
                
                LineMark(
                    x: .value("Date", date),
                    y: .value("Price", price)
                )
                .foregroundStyle(LinearGradient(
                    gradient: Gradient(colors: [.purple, .blue]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
            }
            if let selectedDate = rawSelectedDate {
                                RuleMark(
                                    x: .value("Selected", selectedDate)
                                )
                                .foregroundStyle(Color.gray.opacity(0.3))
                                .zIndex(-1)
                            }
        }
        .frame(height: 300)
        .aspectRatio(1, contentMode: .fit)
        .chartYScale(domain: minY...maxY)
        .chartXAxis(.hidden)
        .chartXSelection(value: $rawSelectedDate)
        .opacity(isChartVisible ? 1 : 0) // Apply opacity based on isChartVisible state
        .onAppear {
                    // Delay the animation using DispatchQueue
            withAnimation(.interactiveSpring(response: 1.5, dampingFraction: 1.0, blendDuration: 0.8)) {
                            self.isChartVisible = true
            }
        }
        .onChange(of: rawSelectedDate) { newDate in
            if let date = newDate {
                if let price = prices.first(where: { $0.0 == date })?.1 {
                    selectedClosePrice = price
                } else {
                    selectedClosePrice = nil
                }
            } else {
                selectedClosePrice = nil
            }
        }
        .overlay(
            VStack {
                if let selectedDate = rawSelectedDate, let closePrice = selectedClosePrice {
                    TooltipView(date: selectedDate, price: closePrice)
                        .transition(.opacity) // Smooth transition
                }
                Spacer()
            }
            .animation(.easeInOut, value: rawSelectedDate)
        )
        
        let chartXPoints = getXAxisPoint()

        Rectangle()
                       .frame(height: 1)
                       .foregroundColor(Color.gray.opacity(0.23))
        HStack{
            Text(chartXPoints[0])
                .font(.system(size: 12)) // Absolute size
                .foregroundColor(Color.gray.opacity(0.5))
            Spacer()
            Text(chartXPoints[1])
                .font(.system(size: 12)) // Absolute size
                .foregroundColor(Color.gray.opacity(0.5))
            Spacer()
            Text(chartXPoints[2])
                .font(.system(size: 12)) // Absolute size
                .foregroundColor(Color.gray.opacity(0.5))
        }
    }
    
    func getXAxisPoint() -> [String]{
        var chartXPoints: [String] = []

        // Ensure there are elements in prices
        if let first = prices.first?.0, let last = prices.last?.0 {
            if let index = first.firstIndex(of: " ") {
                let substring = first[index..<first.endIndex].dropFirst()
                chartXPoints.append(String(substring))
            }else{
                chartXPoints.append(first)
            }
            
            // Calculate middle index
            let middleIndex = prices.count / 2
            if middleIndex < prices.count {
                if let index = prices[middleIndex].0.firstIndex(of: " ") {
                    let substring = prices[middleIndex].0[index..<prices[middleIndex].0.endIndex].dropFirst()
                    chartXPoints.append(String(substring))
                }else{
                    chartXPoints.append(first)
                }
            }
            
            if let index = last.firstIndex(of: " ") {
                let substring = last[index..<last.endIndex].dropFirst()
                chartXPoints.append(String(substring))
            }else{
                chartXPoints.append(last)
            }
        }
        return chartXPoints
    }
}

struct TooltipView: View {
    var date: String
    var price: Double

    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .foregroundStyle(LinearGradient(
                    gradient: Gradient(colors: [.purple, .blue]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
            Text("\(date): ") +
            Text("\(String(format: "%.2f", price))$")
                .bold()
        }
        .padding(8)
        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white, lineWidth: 1)
        )
        
    }
}
