//
//  ProfileViewModel.swift
//  Expense Tracker
//
//  Created by Apple on 09/04/26.
//

import Foundation

class ProfileViewModel {

    struct User {
        var name: String
        var email: String
        var balance: String
        var spending: String
    }

    var user: User?

    // Validation
//    func validate(name: String?, email: String?, password: String?, confirmPassword: String?) -> String? {
//        
//        guard let name = name, !name.isEmpty,
//              let email = email, !email.isEmpty,
//              let password = password, !password.isEmpty,
//              let confirmPassword = confirmPassword, !confirmPassword.isEmpty
//        else {
//            return "Please fill all fields"
//        }
//        
//        if !email.contains("@") || !email.contains(".") {
//            return "Enter a valid email"
//        }
//        
//        if password != confirmPassword {
//            return "Passwords do not match"
//        }
//        
//        return nil // ✅ no error
//    }
    
    func validate(name: String?, email: String?, password: String?, confirmPassword: String?) -> String? {
        
        guard let name = name, !name.isEmpty,
              let email = email, !email.isEmpty,
              let password = password, !password.isEmpty,
              let confirmPassword = confirmPassword, !confirmPassword.isEmpty
        else {
            return "Please fill all fields"
        }
        
        // Email validation
        if !email.contains("@") || !email.contains(".") {
            return "Enter a valid email"
        }
        
        //  Password length validation
        if password.count < 8 {
            return "Password must be at least 8 characters"
        }
        
        // Password match
        if password != confirmPassword {
            return "Passwords do not match"
        }
        
        return nil
    }
    
//    func updateUser(name: String, email: String) {
//        user = User(
//            name: name,
//            email: email,
//            balance: "$20000",
//            spending: "$2000"
//        )
//    }
    
    func updateUser(name: String, email: String) {
        
        user = User(
            name: name,
            email: email,
            balance: "$20000",
            spending: "$2000"
        )
        
        // 🔥 SAVE GLOBALLY
        UserManager.shared.saveUser(name: name, email: email)
    }
}
