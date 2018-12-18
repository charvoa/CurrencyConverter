//
//  String+Extension.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 17/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation

extension String {
    static let numberFormatter = NumberFormatter()

    var doubleValue: Double? {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return nil
    }
}
