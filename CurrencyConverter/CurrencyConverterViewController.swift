//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Nicolas CHARVOZ on 12/12/2018.
//  Copyright © 2018 NicolasCharvoz. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CurrencyConverterFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.keyboardDismissMode = .interactive
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cellType: CurrencyConverterCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    private let currencyService = CurrencyService()
    private lazy var dispatchService: DispatchService = {
        let service = DispatchService()
        service.delegate = self

        return service
    }()

    private var isUpdating = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
}

private extension CurrencyConverterViewController {
    func setupUI() {
        setupCollectionView()
    }

    func loadData() {
        currencyService.fetchCurrencies { [weak self] (success) in
            guard let sSelf = self else { return }
            guard success else { return }

            sSelf.collectionView.reloadData(withOffset: nil, max: sSelf.currencyService.currencies.count)
        }
    }

    func setupCollectionView() {
        view.addSubview(collectionView)

        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension CurrencyConverterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencyService.currencies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CurrencyConverterCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.configure(CurrencyViewModel(currencyService.currencies[indexPath.row]))
        cell.delegate = self

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topIndexPath = IndexPath(item: 0, section: 0)
        let topCell = collectionView.cellForItem(at: topIndexPath) as? CurrencyConverterCollectionViewCell

        guard indexPath.row != 0 else {
            topCell?.setFirstResponder()
            return
        }

        dispatchService.stop()
        currencyService.currencies.rearrange(from: indexPath.row, to: 0)
        update()

        collectionView.performBatchUpdates({
            collectionView.moveItem(at: indexPath, to: topIndexPath)
            collectionView.scrollToItem(at: topIndexPath, at: .top, animated: true)
        }, completion: { _ in
            let secondCell = collectionView.cellForItem(at: topIndexPath) as? CurrencyConverterCollectionViewCell
            topCell?.endEditing()
            secondCell?.setFirstResponder()
            self.dispatchService.reset()
        })
    }

    func update() {
        isUpdating = true
        currencyService.updateCurrencies(withBase: currencyService.currencies.first?.title) { [weak self] (success) in
            if success {
                guard let sSelf = self else { return }
                sSelf.collectionView.reloadData(withOffset: 0, max: sSelf.currencyService.currencies.count)
            }

            self?.isUpdating = false
        }
    }
}

extension CurrencyConverterViewController: CurrencyConverterCollectionViewCellDelegate {
    func cellIsEditing(_ text: String?) {
        guard
            let doubleValue = text?.doubleValueWithComma() else {
                dispatchService.stop()
                currencyService.resetCurrencies()
                collectionView.reloadData(withOffset: 0, max: currencyService.currencies.count)
                return
        }

        dispatchService.reset()
        currencyService.updateCurrencies(doubleValue)
        collectionView.reloadData(withOffset: 0, max: currencyService.currencies.count)
    }
}

extension CurrencyConverterViewController: DispatchServiceDelegate {
    func shouldRun() {
        guard !isUpdating else { return }

        update()
    }
}
