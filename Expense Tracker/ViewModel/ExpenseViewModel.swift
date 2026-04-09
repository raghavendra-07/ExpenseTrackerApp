//
//  ExpenseViewModel.swift
//  Expense Tracker
//
//  Created by Apple on 08/04/26.
//

class ExpenseViewModel {

    // Default data
    private var defaultWeekly: [Expense] = []
    private var defaultMonthly: [Expense] = []
    
    // User added data
    private var userExpenses: [Expense] = []
    
    // Final display data
    private(set) var expenses: [Expense] = []

    enum ExpenseType {
        case weekly
        case monthly
    }

    init() {
        setupDefaultData()
    }

    // MARK: - Default Data
    private func setupDefaultData() {
        
        defaultWeekly = [
            Expense(title: "FOOD", subtitle: "Lesser than last week", amount: "$1000"),
            Expense(title: "TRAVEL", subtitle: "More than last week", amount: "$4000"),
            Expense(title: "ELECTRONICS", subtitle: "Macbook Air", amount: "$900"),
            Expense(title: "OTHERS", subtitle: "Miscellaneous", amount: "$1100")
        ]
        
        defaultMonthly = [
            Expense(title: "FOOD", subtitle: "Spent on groceries", amount: "$3200"),
            Expense(title: "TRAVEL", subtitle: "Trip expenses", amount: "$12000"),
            Expense(title: "SHOPPING", subtitle: "Clothes & accessories", amount: "$8000"),
            Expense(title: "BILLS", subtitle: "Electricity & internet", amount: "$2500"),
            Expense(title: "ENTERTAINMENT", subtitle: "Movies & subscriptions", amount: "$1500"),
            Expense(title: "HEALTH", subtitle: "Medical expenses", amount: "$900"),
            Expense(title: "OTHERS", subtitle: "Miscellaneous", amount: "$1100")
        ]
    }

    // MARK: - Load Data
    func loadData(type: ExpenseType) {
        
        switch type {
            
        case .weekly:
            // Merge default + user
            expenses = userExpenses + defaultWeekly
            
        case .monthly:
            // Monthly stays default
            expenses = defaultMonthly
        }
    }

    // MARK: - Add Expense
    func addExpense(_ expense: Expense) {
        userExpenses.insert(expense, at: 0)
    }

    func numberOfRows() -> Int {
        return expenses.count
    }

    func expense(at index: Int) -> Expense {
        return expenses[index]
    }
}

//class ExpenseViewModel {
//
//    private(set) var expenses: [Expense] = []
//
//    enum ExpenseType {
//        case weekly
//        case monthly
//    }
//
//    func loadData(type: ExpenseType) {
//        
//        switch type {
//            
//        case .weekly:
//            expenses = [
//                Expense(title: "FOOD", subtitle: "Lesser than last week", amount: "$1000"),
//                Expense(title: "TRAVEL", subtitle: "More than last week", amount: "$4000"),
//                Expense(title: "ELECTRONICS", subtitle: "Macbook Air", amount: "$900"),
//                Expense(title: "OTHERS", subtitle: "Miscellaneous", amount: "$1100")
//            ]
//            
//        case .monthly:
//            expenses = [
//                Expense(title: "FOOD", subtitle: "Spent on groceries", amount: "$3200"),
//                Expense(title: "TRAVEL", subtitle: "Trip expenses", amount: "$12000"),
//                Expense(title: "SHOPPING", subtitle: "Clothes & accessories", amount: "$8000"),
//                Expense(title: "BILLS", subtitle: "Electricity & internet", amount: "$2500"),
//                Expense(title: "ENTERTAINMENT", subtitle: "Movies & subscriptions", amount: "$1500"),
//                Expense(title: "HEALTH", subtitle: "Medical expenses", amount: "$900"),
//                Expense(title: "OTHERS", subtitle: "Miscellaneous", amount: "$1100")
//            ]
//        }
//    }
//
//    func numberOfRows() -> Int {
//        return expenses.count
//    }
//
//    func expense(at index: Int) -> Expense {
//        return expenses[index]
//    }
//    
//    func addExpense(_ expense: Expense) {
//        expenses.insert(expense, at: 0)
//    }
//}


