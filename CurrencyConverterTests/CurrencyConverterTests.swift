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

    func testConverterService() {
        let gbpModel = CurrencyModel(title: "GBP", baseValue: 1.11)
        let converterService = ConverterService()
        converterService.base = "GBP"

        XCTAssertEqual(converterService.convert(3, gbpModel.baseValue), 3*1.11)
        XCTAssertEqual(converterService.convert(4, gbpModel.baseValue), 4*1.11)
        XCTAssertEqual(converterService.convert(5.12, gbpModel.baseValue), 5.12*1.11)
        XCTAssertEqual(converterService.convert(8.45, gbpModel.baseValue), 8.45*1.11)
    }

    func testAPIClient() {
        let mockClient = APIClient_mock()

        mockClient.get(URL(string: "/mock")!) { (dictionary, error) in
            XCTAssertNotNil(dictionary?["rates"])
            XCTAssertNil(error)
        }
    }
}
