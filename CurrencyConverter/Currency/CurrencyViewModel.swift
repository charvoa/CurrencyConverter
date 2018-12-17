//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 12/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation
import UIKit

struct CurrencyViewModel {
    var title: String
    var fullName: String
    var image: UIImage?
    var currentValue: String?

    init(_ model: CurrencyModel) {
        self.title = model.title
        self.fullName = model.fullName
        self.image = UIImage(named: model.title)
        self.currentValue = (model.currentValue != nil) ? String(format: "%.2f", model.currentValue!) : nil
    }
}
