//
//  CartItem.swift
//  Pizza Loyalty
//
//  Created by özgün aksoy on 2024-03-22.
//

import Foundation

struct CartItem: Hashable, Identifiable {
    var id = UUID().uuidString
    var name: String
    var price: Double
    var quantity: Int
}

struct MockCart {
    static var items: [CartItem] = [
        CartItem(name: Pizzas.pepperoni.rawValue, price: Pizzas.pepperoni.price, quantity: 1),
        CartItem(name: Pizzas.fourCheese.rawValue, price: Pizzas.fourCheese.price, quantity: 1),
        CartItem(name: Pizzas.margherita.rawValue, price: Pizzas.margherita.price, quantity: 1)
    ]
}
