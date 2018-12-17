//
//  ConverterService.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 12/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation

final class ConverterService {
    var base = "EUR"

    func convert(_ value: Double, _ converter: Double) -> Double {
        return value * converter
    }
}
