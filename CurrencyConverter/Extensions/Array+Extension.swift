//
//  Array+Extension.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 13/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation

extension RangeReplaceableCollection where Indices: Equatable {
    mutating func rearrange(from: Index, to indexTo: Index) {
        precondition(from != indexTo && indices.contains(from) && indices.contains(indexTo), "invalid indices")
        insert(remove(at: from), at: indexTo)
    }
}
