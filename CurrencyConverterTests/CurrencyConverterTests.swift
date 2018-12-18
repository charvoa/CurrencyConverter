//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Nicolas CHARVOZ on 12/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterTests: XCTestCase {

    func testCurrencyViewModel() {
        let currencyModel = CurrencyModel(title: "EUR", baseValue: 1.0)
        let currencyViewModel = CurrencyViewModel(currencyModel)

        XCTAssertEqual(currencyViewModel.fullName, "Euro")
        XCTAssertEqual(currencyViewModel.title, "EUR")
        XCTAssertEqual(currencyViewModel.currentValue, nil)
    }

    func testCurrencyConverter() {
        let gbpModel = CurrencyModel(title: "GBP", baseValue: 1.11)
        let converterService = ConverterService()
        converterService.base = "GBP"

        let result = converterService.convert(3, gbpModel.baseValue)

        XCTAssertEqual(result, 3*1.11)
    }
}
