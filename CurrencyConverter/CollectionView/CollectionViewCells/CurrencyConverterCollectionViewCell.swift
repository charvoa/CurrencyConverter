//
//  CurrencyConverterCollectionViewCell.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 12/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import UIKit
import Reusable

protocol CurrencyConverterCollectionViewCellDelegate: class {
    func cellIsEditing(_ text: String?)
}

class CurrencyConverterCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private var bgView: UIView!
    @IBOutlet var currencyTextField: CurrencyTextField!
    @IBOutlet private var currencyNameLabel: UILabel!
    @IBOutlet private var currencyTitleLabel: UILabel!
    @IBOutlet private var currencyImageView: UIImageView!

    weak var delegate: CurrencyConverterCollectionViewCellDelegate?

    func configure(_ viewModel: CurrencyViewModel) {
        currencyImageView.image = viewModel.image
        currencyImageView.contentMode = .scaleAspectFill
        currencyImageView.clipsToBounds = true
        currencyImageView.layer.cornerRadius = currencyImageView.bounds.width/2
        currencyImageView.layer.borderWidth = 2.0
        currencyImageView.layer.borderColor = UIColor.blackHaze.cgColor

        currencyTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        currencyTitleLabel.text = viewModel.title
        currencyTextField.textColor = .black

        currencyNameLabel.font = UIFont.boldSystemFont(ofSize: 13)
        currencyNameLabel.textColor = UIColor.tiara
        currencyNameLabel.text = viewModel.fullName

        if let currentValue = viewModel.currentValue {
            currencyTextField.text = currentValue
        } else {
            currencyTextField.placeholder = "0"
        }

        currencyTextField.adjustsFontSizeToFitWidth = false
        currencyTextField.font = UIFont.systemFont(ofSize: 27)
        currencyTextField.keyboardType = .decimalPad
        currencyTextField.textAlignment = .right
        currencyTextField.isUserInteractionEnabled = true
        currencyTextField.isEnabled = true
        currencyTextField.tag = 1
        currencyTextField.delegate = self
        currencyTextField.sizeToFit()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        currencyTextField.text = nil
        currencyTextField.placeholder = "0"
        currencyTextField.sizeToFit()
    }

    @discardableResult
    func setFirstResponder() -> Bool {
        return currencyTextField.becomeFirstResponder()
    }

    func endEditing() {
        currencyTextField.resignFirstResponder()
    }
}

extension CurrencyConverterCollectionViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let currencyTextField = textField as? CurrencyTextField else { return }
        currencyTextField.toggleColors()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let currencyTextField = textField as? CurrencyTextField else { return }
        currencyTextField.toggleColors()
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard textField is CurrencyTextField else { return false }
        guard let text = textField.text else { return true }

        let didPressBackspace = range.length == 1 && string.count == 0

        let newString = (text as NSString).replacingCharacters(in: range, with: string)

        let count = text.count + string.count - range.length

        if count <= 9 || didPressBackspace {
            delegate?.cellIsEditing(newString)
            return true
        }

        return false
    }
}
