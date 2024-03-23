//
//  MainView.swift
//  Pizza Loyalty
//
//  Created by özgün aksoy on 2024-03-22.
//

import SwiftUI

@Observable class CartViewModel {
    var cartItems: [CartItem] = []
    
    func addItem(item: CartItem) {
        if cartItems.contains(where: { $0.name == item.name }) {
            if let index = cartItems.firstIndex(where: { $0.name == item.name}) {
                cartItems[index].quantity += 1
            }
        } else {
            cartItems.append(item)
        }
    }
    
    var total: Double {
        var totalCost = 0.0
        for item in cartItems {
            totalCost += item.price * Double(item.quantity)
        }
        return totalCost
    }
}

struct MainView: View {
    
    @State private var cartVM = CartViewModel()

    var body: some View {
        
        NavigationStack {
            VStack {
                pointsView
                
                orderView
                
                cartView
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                   
                }
            }
        }
    }
    
    private var cartView: some View {
       
        List {
            Text(cartVM.cartItems.isEmpty ? "Cart Empty" : "Cart")
                .font(.headline)
            
            ForEach(cartVM.cartItems) { item in
                HStack {
                    Text(item.name.capitalized)
                        
                    Spacer()
                    Text("$\(item.price, specifier: "%.2f") x \(item.quantity)")
                }
                .font(.subheadline)
            }
            if !cartVM.cartItems.isEmpty {
                HStack {
                    Text("Total: $\(cartVM.total, specifier: "%.2f")")
                        .font(.headline)
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Buy Now")
                            .buttonModifier(.red)
                    }
                }
            }
        }
        
    }
    
    private var orderView: some View {
        VStack {
            ForEach(Pizzas.allCases) { pizza in
                HStack {
                    Image(pizza.rawValue)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(.rect(cornerRadius: 20))
                    Text(pizza.title)
                        .font(.title2)
                    
                    Spacer()
                    
                    VStack {
                        Text(pizza.price, format: .currency(code: "CAD"))
                            .font(.callout)
                        
                        Button {
                            cartVM.addItem(item: CartItem(name: pizza.rawValue, price: pizza.price, quantity: 1))
                        } label: {
                            Text("Add to Cart")
                                .buttonModifier
                        }
                    }
                }
                .padding(8)
                .background {
                    Color(.secondarySystemBackground)
                        .clipShape(.rect(cornerRadius: 20))
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var pointsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Your Points")
                .font(.title)
                .fontWeight(.heavy)
            
            HStack {
                ForEach(0 ..< 5) { index in
                    Image(systemName: index < 4 ? "star.fill" : "star")
                        .imageScale(.large)
                }
                
                Spacer()
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("250")
                        .font(.title3)
                    Text("Points")
                        .font(.subheadline)
                }
                
            }
            
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20).stroke(.green, lineWidth: 2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    MainView()
}

enum Pizzas: String, Hashable, Identifiable, CaseIterable {
    case pepperoni, fourCheese, margherita
    
    var id: Self { return self }
    
    var title: String {
        switch self {
        case .pepperoni:
            return "Pepperoni"
        case .fourCheese:
            return "Four Cheese"
        case .margherita:
            return "Marggerita"
        }
    }
    
    var price: Double {
        switch self {
        case .pepperoni:
            20.0
        case .fourCheese:
            18.5
        case .margherita:
            15.5
        }
    }
}
