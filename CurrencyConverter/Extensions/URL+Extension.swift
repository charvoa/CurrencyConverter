//
//  URL+Extension.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 12/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation

extension URL {

    @discardableResult
    func append(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        guard let value = value else { return absoluteURL }
        let queryItem = URLQueryItem(name: queryItem, value: value)

        queryItems.append(queryItem)

        urlComponents.queryItems = queryItems

        return urlComponents.url!
    }
}
