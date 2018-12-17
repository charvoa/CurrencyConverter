//
//  UICollectionView+Extension.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 14/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func reloadData(withOffset: Int?, max: Int) {
        guard let offset = withOffset else {
            self.reloadData()
            return
        }

        let startIndexPath = offset + 1

        for index in startIndexPath ..< max {
            self.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
    }
}
