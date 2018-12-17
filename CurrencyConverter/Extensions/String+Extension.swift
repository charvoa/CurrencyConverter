//
//  String+Extension.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 17/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation

extension String {
    func doubleValueWithComma() -> Double? {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = ","

        return formatter.number(from: self)?.doubleValue
    }

    func truncated() -> String {
        if count >= 9 {
            return "..." + self[index(endIndex, offsetBy: -8)...]
        }
        return self
    }
}
