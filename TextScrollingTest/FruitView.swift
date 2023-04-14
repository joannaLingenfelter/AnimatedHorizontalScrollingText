//
//  FruitView.swift
//  TextScrollingTest
//
//  Created by Jo Lingenfelter on 4/14/23.
//

import SwiftUI

struct FruitView: View {
    let fruit: Fruit

    @ScaledMetric
    private var iconOffset: CGFloat = 20

    @ScaledMetric
    private var padding: CGFloat = 10

    var body: some View {
        ZStack {
            Text(fruit.name)
                .padding(padding)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.gray)
                }

            if fruit.isFavorite {
                Image(systemName: "star.fill")
                    .offset(y: iconOffset)
                    .foregroundStyle(Color.yellow.gradient)
            }
        }
        .padding(.vertical)
        .fixedSize()
    }
}

struct FruitView_Previews: PreviewProvider {
    static var previews: some View {
        FruitView(fruit: .preview)
    }
}
