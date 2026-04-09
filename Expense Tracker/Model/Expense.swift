//
//  Expense.swift
//  Expense Tracker
//
//  Created by Apple on 08/04/26.
//

import Foundation





struct Expense {
    let title: String
    let subtitle: String
    let amount: String
    let date: Date
    let type: TransactionType
    
    init(title: String,
         subtitle: String,
         amount: String,
         date: Date = Date(),
         type: TransactionType = .expense) {
        
        self.title = title
        self.subtitle = subtitle
        self.amount = amount
        self.date = date
        self.type = type
    }
}


enum TransactionType {
    case expense
    case income
}
