//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 12/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation

class CurrencyModel: CustomDebugStringConvertible {
    var title: String
    var fullName: String
    var baseValue: Double
    var currentValue: Double?

    init(title: String, baseValue: Double, currentValue: Double? = nil) {
        self.title = title
        self.fullName = NSLocale.current.localizedString(forCurrencyCode: title) ?? ""
        self.baseValue = baseValue
        self.currentValue = currentValue
    }

    var debugDescription: String {
        return """
        Currency : \(fullName) - (\(title)) |
        baseValue : \(baseValue) |
        currentValue : \(String(describing: currentValue))
        """
    }
}
