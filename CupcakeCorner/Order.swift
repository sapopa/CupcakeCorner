//
//  Order.swift
//  CupcakeCorner
//
//  Created by sebastian.popa on 8/14/23.
//

import SwiftUI

@dynamicMemberLookup
class Order: ObservableObject {
    @Published var order = OrderAsStruct()
    
    subscript<T>(dynamicMember keyPath : KeyPath<OrderAsStruct, T>) -> T {
        order[keyPath: keyPath]
    }
    
    subscript<T>(dynamicMember keyPath : WritableKeyPath<OrderAsStruct, T>) -> T {
        get {
            order[keyPath: keyPath]
        }
        
        set {
            order[keyPath: keyPath] = newValue
        }
    }
}
