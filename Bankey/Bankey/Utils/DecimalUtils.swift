//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Supapon Pucknavin on 4/11/2565 BE.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
