//
//  CustomSegmentedControl.swift
//  Stocks
//
//  Created by Patrik Jankuv on 07/07/2024.
//

import SwiftUI

struct Category: Identifiable, Hashable {
    var id: UUID { UUID() }
    var title: String
    var attributes: [String: String]
}

struct CustomSegmentedControl: View {
    let color = Colors.primaryColorGradient
    @State var categories: [Category]
    @State private var selectedCategory: Category?

    var body: some View {
        VStack{
            SegmentedPicker(
                selection: $selectedCategory,
                items: $categories,
                selectionColor: Colors.primaryColorGradient
            ) { book in Text(book.title)}
            
            if let selectedCategory {
                VStack{
                    ForEach(selectedCategory.attributes.sorted(by: >), id: \.key) { key, value in
                        HStack {
                            Text("\(key)")
                                .bold()
                            Spacer()
                            Text("\(value)")
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 4)
                    }
                }.padding(.horizontal)
            }
        }
        .padding(.vertical)
//        .background(Color("Background"))
        }
    init(categories: [Category]) {
        self.categories = categories
    }
}
