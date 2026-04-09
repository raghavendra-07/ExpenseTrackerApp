//
//  AuthViewModel.swift
//  Expense Tracker
//
//  Created by Apple on 09/04/26.
//

import Foundation

class AuthViewModel {
    
    var isSignIn = true
    
    func toggleMode() {
        isSignIn.toggle()
    }
    
    func validate(
        name: String?,
        email: String?,
        password: String?,
        confirmPassword: String?
    ) -> String? {
        
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty
        else {
            return "Please fill all fields"
        }
        
        if !email.contains("@") {
            return "Invalid email"
        }
        
        if password.count < 8 {
            return "Password must be at least 8 characters"
        }
        
        if !isSignIn {
            guard let name = name, !name.isEmpty,
                  let confirm = confirmPassword, !confirm.isEmpty
            else {
                return "Fill all fields"
            }
            
            if password != confirm {
                return "Passwords do not match"
            }
        }
        
        return nil
    }
}
