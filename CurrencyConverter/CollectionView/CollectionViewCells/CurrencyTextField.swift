//
//  AmountTextField.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 12/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import UIKit

class CurrencyTextField: UITextField {

    private let padding = UIEdgeInsets(top: 6.0, left: 0.0, bottom: 0.0, right: 2.0)
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.isUserInteractionEnabled = false
        lineView.frame.size.height = 2
        lineView.backgroundColor = UIColor.tiara
        return lineView
    }()

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func toggleColors() {
        if isFirstResponder {
            lineView.backgroundColor = .black
        } else {
            lineView.backgroundColor = UIColor.tiara
        }
    }
}

private extension CurrencyTextField {
    func commonInit() {
        addSubview(lineView)
        constraintLineView()
        textColor = UIColor.tiara
    }

    func constraintLineView() {
        lineView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        lineView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        lineView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 2.0).isActive = true
    }
}
