//
//  Grid.swift
//
//
//  Created by Егор Пехота on 07.03.2021.
//

import SwiftUI

// Displays View items in a grid.

struct Grid<Item, ItemView>: View where Item: Equatable, Item: Identifiable, ItemView: View {
    // Items array.
    private var items: [Item]
    
    // Returns view for an item.
    private var viewForItem: (Item) -> ItemView
    
    // Initializes values for `self.items` with array of `Item` and `self.viewForItem` with a closure.
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
     
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
     
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) {item in
            self.body(for: item, in:layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(of: item)!
        return viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index))
    }
}
