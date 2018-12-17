//
//  DispatchManager.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 14/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import Foundation

protocol DispatchServiceDelegate: class {
    func shouldRun()
}

final class DispatchService {
    private var timer = Timer()

    weak var delegate: DispatchServiceDelegate?

    func launch() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
                             selector: #selector(self.shouldRun),
                             userInfo: nil, repeats: true)
    }

    func reset() {
        stop()
        launch()
    }

    func stop() {
        timer.invalidate()
    }
}

extension DispatchService {
    @objc func shouldRun() {
        guard timer.isValid else { return }
        delegate?.shouldRun()
    }
}
