//
//  ContentView.swift
//  TextScrollingTest
//
//  Created by Jo Lingenfelter on 4/14/23.
//

import SwiftUI

struct Fruit: Identifiable {
    let name: String
    let isFavorite: Bool
    let id: UUID = UUID()

    static let preview: Fruit = Fruit(name: "Apple", isFavorite: true)
}

private struct ScrollingContentWidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat

    static var defaultValue: Value = 0.0

    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value += nextValue()
    }
}

struct ContentView: View {
    let fruit = [
        Fruit(name: "Apple", isFavorite: true),
        Fruit(name: "Pear", isFavorite: false),
        Fruit(name: "Banana", isFavorite: false),
        Fruit(name: "Watermelon", isFavorite: true),
        Fruit(name: "Orange", isFavorite: false),
        Fruit(name: "Strawberry", isFavorite: false),
        Fruit(name: "Tomato", isFavorite: false)
    ]

    @State
    private var offSet: CGFloat = 0.0

    @State
    private var contentWidth: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Color.mint.frame(height: 300)

                HStack {
                    ForEach(fruit) { fruit in
                        FruitView(fruit: fruit)
                            .anchorPreference(key: ScrollingContentWidthPreferenceKey.self, value: .bounds) { anchor in
                                return geometry[anchor].width
                            }
                    }
                }
                .offset(x: geometry.size.width + abs(contentWidth - geometry.size.width))
                .offset(x: offSet)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color.indigo.gradient)
                }
                .animation(.linear(duration: 7.0).repeatForever(autoreverses: false), value: offSet)  // Some function of the width of the screen and the content
            }
            .frame(width: geometry.size.width, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .onAppear {
                offSet = -geometry.size.width - contentWidth - abs(contentWidth - geometry.size.width)
            }
            .onPreferenceChange(ScrollingContentWidthPreferenceKey.self) { newWidth in
                self.contentWidth = newWidth
            }
        }
        .scenePadding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
