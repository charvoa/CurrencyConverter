//
//  CurrencyConverterFlowLayout.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 12/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation
import UIKit

final class CurrencyConverterFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView else { return }

        let width = collectionView.bounds.width
        self.itemSize = CGSize(width: width,
                               height: 85)
        self.scrollDirection = .vertical
        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
