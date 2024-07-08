//
//  SegmentedPicker.swift
//  Stocks
//
//  Created by Patrik Jankuv on 07/07/2024.
//

import SwiftUI

struct SegmentedPicker<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    @Binding var selection: SelectionValue?
    @Binding var items: [SelectionValue]
    @Namespace private var pickerTransition
    private var selectionColor: Gradient = Colors.primaryColorGradient
    private var content: (SelectionValue) -> Content

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    // Add a Spacer at the beginning
                    Spacer()
                        .frame(width: 8) // Adjust the width as needed

                    LazyHGrid(rows: [GridItem(.flexible())], spacing: 6) {
                        ForEach(items, id:\.self) { item in
                            let selected = selection == item
                            ZStack {
                                if selected {
                                    Capsule()
                                        .foregroundStyle(selectionColor)
                                        .matchedGeometryEffect(id: "picker", in: pickerTransition)
                                    content(item).id(item)
                                        .foregroundStyle(.white)
                                        .bold()
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 8)
                                        .lineLimit(1)
                                        .clipShape(Capsule())
                                }
                                else {
                                    Capsule()
                                        .foregroundStyle(.clear)
                                    content(item).id(item)
                                        .foregroundStyle(.black)
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 8)
                                        .lineLimit(1)
                                        .clipShape(Capsule())
                                }
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    selection = item
                                }
                            }
                            .onChange(of: selection) {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    proxy.scrollTo(selection)
                                }
                            }
                        }
                    }
                    .onAppear {
                        if selection == nil, let first = items.first {
                            selection = first
                        }
                    }

                    // Add a Spacer at the end
                    Spacer()
                        .frame(width: 16) // Adjust the width as needed
                }
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    init(
        selection: Binding<SelectionValue?>,
        items: Binding<[SelectionValue]>,
        selectionColor: Gradient = Colors.primaryColorGradient,
        @ViewBuilder content: @escaping (SelectionValue) -> Content
    ) {
        _selection = selection
        _items = items
        self.selectionColor = selectionColor
        self.content = content
    }
}
