//
//  Utils.swift
//  Stocks
//
//  Created by Patrik Jankuv on 04/07/2024.
//

import Foundation

class Utils{
    static func formatNumber(_ numberString: String) -> String {
        guard let number = Double(numberString) else { return numberString }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? numberString
    }
    
    static func doubleToString(_ change: Double?) -> String {
        guard let change = change else { return "N/A" }
        return String(format: "%.2f", change)
    }
    
    
}
