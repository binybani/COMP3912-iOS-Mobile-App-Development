//
//  problem5.swift
//  Final
//
//  Created by Yubin Kim on 2023-07-29.
//

import Foundation
//problem5
struct Item {
    var name: String
    var weight: Int
}

struct Bag {
    var items: [Item]

    func totalWeight() -> Int {
        return items.reduce(0) { $0 + $1.weight }
    }

    func heaviestItem() -> Item? {
        return items.max(by: { $0.weight < $1.weight })
    }

    func sortedItemsByWeight() -> [Item] {
        return items.sorted(by: { $0.weight < $1.weight })
    }
}

// Test
let key = Item(name: "Key", weight: 50)
let battery = Item(name: "Battery", weight: 40)
let watch = Item(name: "Watch", weight: 100)
let ring = Item(name: "Ring", weight: 30)
let iPhone = Item(name: "iPhone", weight: 300)
let cup = Item(name: "Cup", weight: 250)
let notebook = Item(name: "Notebook", weight: 150)

let myBag = Bag(items: [key, battery, watch, ring, iPhone, cup, notebook])

let totalWeight = myBag.totalWeight()
print("Total Wieght: \(totalWeight)")

if let heaviestItem = myBag.heaviestItem() {
    print("The highest weight in the suitcase: \(heaviestItem.name)")
} else {
    print("Empty bag")
}

let sortedItems = myBag.sortedItemsByWeight()
print("Items sorted based on their weight ascendingly:")
for item in sortedItems {
    print("\(item.name): \(item.weight)")
}
