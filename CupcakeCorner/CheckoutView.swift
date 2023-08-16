//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by sebastian.popa on 8/15/23.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var hasCheckoutFailed = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is: \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order"){
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert("Checkout error", isPresented: $hasCheckoutFailed) {
            Button("Try again") {
                Task {
                    await placeOrder()
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Check if you're connected to the internet, otherwise the issue is probably on our end")
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(OrderAsStruct.self, from: data)
            
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderAsStruct.types[decodedOrder.type].lowercased()) cupcake is on its way!"
            showingConfirmation = true
        } catch {
            hasCheckoutFailed = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CheckoutView(order: Order())
        }
    }
}
