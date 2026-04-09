//
//  AuthManager.swift
//  Expense Tracker
//
//  Created by Apple on 09/04/26.
//

import Foundation

class AuthManager {
    
    static let shared = AuthManager()
    
    private let loginKey = "is_logged_in"
    private let loginTimeKey = "login_time"
    
    func login() {
        UserDefaults.standard.set(true, forKey: loginKey)
        UserDefaults.standard.set(Date(), forKey: loginTimeKey)
    }
    
//    func isLoggedIn() -> Bool {
//        
//        guard UserDefaults.standard.bool(forKey: loginKey),
//              let loginTime = UserDefaults.standard.object(forKey: loginTimeKey) as? Date
//        else {
//            return false
//        }
//        
//        let elapsed = Date().timeIntervalSince(loginTime)
//        
//        return elapsed < 3600 // 1 hour
//    }
    
    
    func isLoggedIn() -> Bool {
        
        guard UserDefaults.standard.bool(forKey: loginKey),
              let loginTime = UserDefaults.standard.object(forKey: loginTimeKey) as? Date
        else {
            return false
        }
        
        let elapsed = Date().timeIntervalSince(loginTime)
        
        let sessionDuration: TimeInterval = 1800 // 30 minutes (1800 seconds)
        
        if elapsed >= sessionDuration {
            logout()
            return false
        }
        
        return true
    }
    
    func logout() {
        UserDefaults.standard.set(false, forKey: loginKey)
    }
}
