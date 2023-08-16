//
//  OrderAsStruct.swift
//  CupcakeCorner
//
//  Created by sebastian.popa on 8/16/23.
//

import SwiftUI

struct OrderAsStruct: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmptyButBetter || streetAddress.isEmptyButBetter || city.isEmptyButBetter || zip.isEmptyButBetter {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2 // 2$ per cupcake
        
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity) // 1$ per frosting per cupcake
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2 // 0.5$ per added sprinkles per cupcake
        }
        
        return cost
    }
}
