//
//  APIClient.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 12/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation
import Alamofire

protocol TestableAPI: class {
    var baseURL: URL? { get set }

    func setup(withURL urlString: String)
    func get(_ url: URL, completion: @escaping (NSDictionary?, Error?) -> Void)
}

final class APIClient: NSObject, TestableAPI {
    var baseURL: URL?

    static let shared = APIClient()
    private override init() {
        super.init()
    }

    func setup(withURL urlString: String) {
        self.baseURL = URL(string: urlString)
    }
}

extension APIClient {
    internal func get(_ url: URL, completion: @escaping (NSDictionary?, Error?) -> Void) {
        Alamofire.request(url, method: .get, parameters: [:])
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success:
                    guard let result = responseJSON.result.value, let json = result as? NSDictionary else {
                        completion(nil, nil)
                        return
                    }
                    completion(json, nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }

    func fetchRates(_ base: String = "AUD", completion: @escaping (NSDictionary?, Error?) -> Void) {

        guard let baseURL = self.baseURL else {
            assertionFailure("APIClient must be setup before use.\nUse setup(withUrl: String) in AppDelegate.")
            return
        }

        let url = baseURL.appendingPathComponent("latest").append("base", value: base)

        get(url) { (result, error) in
            completion(result, error)
        }
    }
}
