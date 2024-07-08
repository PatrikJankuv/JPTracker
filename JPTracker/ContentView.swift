//
//  ContentView.swift
//  Stocks
//
//  Created by Patrik Jankuv on 03/07/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DetailView(symbol: "IBM")
    //        DetailView(symbol: "TSLA")
    //        DetailView(symbol: "GOOG")
                .tabItem {
                    Image(systemName: "house")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

#Preview {
    ContentView()
}
