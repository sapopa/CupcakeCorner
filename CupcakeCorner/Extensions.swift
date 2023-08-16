//
//  Extensions.swift
//  CupcakeCorner
//
//  Created by sebastian.popa on 8/16/23.
//

import Foundation

extension String {
    var isEmptyButBetter: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
