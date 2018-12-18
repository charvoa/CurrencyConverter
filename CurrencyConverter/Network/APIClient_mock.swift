//
//  APIClient_mock.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 18/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation

// swiftlint:disable type_name
final class APIClient_mock: NSObject, TestableAPI {
    var baseURL: URL?

    let json =
    """
    {"base":"EUR","date":"2018-09-06","rates":{"AUD":1.6125,"BGN":1.9511,
"BRL":4.7803,"CAD":1.5301,"CHF":1.1248,"CNY":7.9261,"CZK":25.653,"DKK":7.4388,
"GBP":0.89609,"HKD":9.1105,"HRK":7.4163,"HUF":325.71,"IDR":17282.0,"ILS":4.1606,
"INR":83.517,"ISK":127.49,"JPY":129.24,"KRW":1301.6,"MXN":22.312,"MYR":4.8005,
"NOK":9.7526,"NZD":1.7591,"PHP":62.442,"PLN":4.308,"RON":4.6274,"RUB":79.384,
"SEK":10.565,"SGD":1.5962,"THB":38.039,"TRY":7.6099,"USD":1.1606,"ZAR":17.781}}
"""

    func setup(withURL urlString: String) {
        self.baseURL = URL(string: urlString)
    }

    func get(_ url: URL, completion: @escaping (NSDictionary?, Error?) -> Void) {
        let dictionary = json.convertToDictionary() as NSDictionary?

        completion(dictionary, nil)
    }
}

//final class APIClient_mock: NSObject {
//    var baseURL: URL?
//
//    static let shared = APIClient_mock()
//    private override init() {
//        super.init()
//    }
//
//    func setup(withURL urlString: String) {
//        self.baseURL = URL(string: urlString)
//    }
//}
//
//private extension APIClient {
//    func get(_ url: URL, completion: @escaping (NSDictionary?, Error?) -> Void) {
//        Alamofire.request(url, method: .get, parameters: [:])
//            .validate(statusCode: 200..<300)
//            .responseJSON { responseJSON in
//                switch responseJSON.result {
//                case .success:
//                    guard let result = responseJSON.result.value, let json = result as? NSDictionary else {
//                        completion(nil, nil)
//                        return
//                    }
//                    completion(json, nil)
//                case .failure(let error):
//                    completion(nil, error)
//                }
//        }
//    }
//}
//
//extension APIClient {
//
//    func fetchRates(_ base: String = "AUD", completion: @escaping (NSDictionary?, Error?) -> Void) {
//
//        guard let baseURL = self.baseURL else {
//            assertionFailure("APIClient must be setup before use.\nUse setup(withUrl: String) in AppDelegate.")
//            return
//        }
//
//        let url = baseURL.appendingPathComponent("latest").append("base", value: base)
//
//        get(url) { (result, error) in
//            completion(result, error)
//        }
//    }
//}
