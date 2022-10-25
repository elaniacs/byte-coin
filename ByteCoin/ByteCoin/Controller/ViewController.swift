//
//  ViewController.swift
//  ByteCoin
//
//  Created by Cáren Sousa on 26/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
}

//MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    /* determine how many columns we want in our picker. */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /* how many rows this picker should have using */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    /* update the PickerView with some titles and detect when it is interacted with. */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    /* called every time the user scrolls the picker, recording the number of the line that was selected. */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdateCoin(_ coinData: CoinData) {
        DispatchQueue.main.async {
            self.currencyLabel.text = coinData.asset_id_quote
            self.bitcoinLabel.text = "\(coinData.rate.rounded(.awayFromZero))"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
