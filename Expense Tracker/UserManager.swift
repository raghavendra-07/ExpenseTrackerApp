//
//  UserManager.swift
//  Expense Tracker
//
//  Created by Apple on 09/04/26.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    private let nameKey = "user_name"
    private let emailKey = "user_email"
    
    func saveUser(name: String, email: String) {
        UserDefaults.standard.set(name, forKey: nameKey)
        UserDefaults.standard.set(email, forKey: emailKey)
    }
    
    func getUserName() -> String {
        return UserDefaults.standard.string(forKey: nameKey) ?? "Alex"
    }
    
    func getUserEmail() -> String {
        return UserDefaults.standard.string(forKey: emailKey) ?? "alex@gmail.com"
    }
    
    func isUserRegistered(email: String) -> Bool {
        let savedEmail = UserDefaults.standard.string(forKey: emailKey)
        return savedEmail == email
    }
}
