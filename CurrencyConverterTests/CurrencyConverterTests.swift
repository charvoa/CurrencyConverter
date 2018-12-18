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
//
//    let json =
//    """
//    {"base":"EUR","date":"2018-09-06","rates":{"AUD":1.6125,"BGN":1.9511,
//"BRL":4.7803,"CAD":1.5301,"CHF":1.1248,"CNY":7.9261,"CZK":25.653,"DKK":7.4388,
//"GBP":0.89609,"HKD":9.1105,"HRK":7.4163,"HUF":325.71,"IDR":17282.0,"ILS":4.1606,
//"INR":83.517,"ISK":127.49,"JPY":129.24,"KRW":1301.6,"MXN":22.312,"MYR":4.8005,
//"NOK":9.7526,"NZD":1.7591,"PHP":62.442,"PLN":4.308,"RON":4.6274,"RUB":79.384,
//"SEK":10.565,"SGD":1.5962,"THB":38.039,"TRY":7.6099,"USD":1.1606,"ZAR":17.781}}
//"""

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

//    func testJSONResult() {
//        let data = json.data(using: .utf8)
//    }
}
