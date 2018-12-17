//
//  CurrencyService.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 12/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation

final class CurrencyService {
    private let converterService = ConverterService()
    var currencies: [CurrencyModel] = []
    private var lock: Bool = false

    func fetchCurrencies(completion: @escaping (Bool) -> Void) {
        var models = [CurrencyModel]()

        let baseModel = CurrencyModel(title: converterService.base, baseValue: 1.0)
        models.append(baseModel)
        APIClient.shared.fetchRates(converterService.base) { [weak self] (result, _) in
            guard let strongResult = result else {
                completion(false)
                return
            }

            if let rates = strongResult["rates"] as? NSDictionary {
                for (key, value) in rates {
                    if let keyString = key as? String, let valueDouble = value as? Double {
                        let model = CurrencyModel(title: keyString, baseValue: valueDouble)
                        models.append(model)
                    }
                }
            }

            self?.currencies = models
            completion(true)
        }
    }

    func updateCurrencies(withBase base: String? = nil, completion: @escaping (Bool) -> Void) {
        guard !currencies.isEmpty else { return }

        converterService.base = base ?? converterService.base

        let baseModel = currencies[0]
        baseModel.baseValue = 1.0

        APIClient.shared.fetchRates(converterService.base) { [weak self] (result, _) in
            guard let strongResult = result, let sSelf = self else {
                completion(false)
                return
            }

            if let rates = strongResult["rates"] as? NSDictionary {
                for (key, value) in rates {
                    let object = sSelf.currencies.filter { $0.title == key as? String }.first
                    object?.baseValue = value as? Double ?? 1.0
                    if object?.currentValue != nil {
                        object?.currentValue = sSelf.converterService
                            .convert(baseModel.currentValue ?? 0.0, object?.baseValue ?? 0.0)
                    }
                }
                completion(true)
            }
        }
    }

    func updateCurrencies(_ value: Double) {
        guard !lock else { return }

        lock = true
        currencies.forEach {
            $0.currentValue = converterService.convert(value, $0.baseValue)
        }
        lock = false
    }

    func resetCurrencies() {
        currencies.forEach {
            $0.currentValue = nil
        }
    }

    func updateBase(_ value: CurrencyModel) {
        converterService.base = value.title
    }
}
