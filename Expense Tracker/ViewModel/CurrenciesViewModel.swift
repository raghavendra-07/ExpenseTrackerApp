//
//  CurrenciesViewModel.swift
//  Expense Tracker
//
//  Created by Apple on 09/04/26.
//

import Foundation

class CurrenciesViewModel {
    
    private(set) var currencies: [Currency] = []
    
    init() {
        loadCurrencies()
    }
    
    private func loadCurrencies() {
        currencies = [
            Currency(code: "CAD", name: "Canadian Dollar", isEnabled: false),
            Currency(code: "USD", name: "US Dollar", isEnabled: true),
            Currency(code: "INR", name: "Indian Rupee", isEnabled: true),
            Currency(code: "EUR", name: "Euro", isEnabled: false)
        ]
    }
    
    // MARK: - Helpers
    
    func numberOfRows() -> Int {
        return currencies.count
    }
    
    func currency(at index: Int) -> Currency {
        return currencies[index]
    }
    
    func toggleCurrency(at index: Int) {
        currencies[index] = Currency(
            code: currencies[index].code,
            name: currencies[index].name,
            isEnabled: !currencies[index].isEnabled
        )
    }
}
