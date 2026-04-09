//
//  AddTransactionViewModel.swift
//  Expense Tracker
//
//  Created by Apple on 09/04/26.
//

import Foundation

class AddTransactionViewModel {
    
    var category: String?
    var amount: String?
    var date: Date = Date()
    var type: TransactionType = .expense
    
    // MARK: - Validation
    func validate() -> String? {
        
        guard let category = category, !category.isEmpty else {
            return "Please enter category"
        }
        
        guard let amount = amount, !amount.isEmpty else {
            return "Please enter amount"
        }
        
        return nil
    }
    
    // MARK: - Create Expense
    func createExpense() -> Expense {
        
        return Expense(
            title: category ?? "",
            subtitle: type == .expense ? "Expense added" : "Income added",
            amount: "$\(amount ?? "0")",
            date: date,
            type: type
        )
    }
}
