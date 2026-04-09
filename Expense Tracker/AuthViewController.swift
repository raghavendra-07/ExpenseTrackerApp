//
//  AuthViewController.swift
//  Expense Tracker
//
//  Created by Apple on 09/04/26.
//

import Foundation
import UIKit

class AuthViewController: UIViewController {
    
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!

    @IBOutlet weak var confirmPasswordView: UIView!

    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var mainIconView: UIView!
    
    @IBOutlet weak var expensesSwitchView: UIView!
    
    @IBOutlet weak var expensesStackView: UIStackView!
    
    @IBOutlet weak var showEyeIconImage: UIImageView!
    
    @IBOutlet weak var fullNameStackview: UIStackView!
    
    @IBOutlet weak var confirmPasswordStackview: UIStackView!
    
    let viewModel = AuthViewModel()
    
    var isPasswordVisible = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
        
        setPlaceholder(fullNameField, text: "Enter your full name")
        setPlaceholder(emailField, text: "Enter your email")
        setPlaceholder(passwordField, text: "Create a password")
        setPlaceholder(confirmPasswordField, text: "Confirm your password")
    }
    
    func setupUI() {
        mainIconView.layer.cornerRadius = 16
        expensesSwitchView.layer.cornerRadius = 14
        expensesStackView.layer.cornerRadius = 14
        expensesSwitchView.backgroundColor = UIColor(named: "topbarContainerViewBottomColor")
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        styleTextField(fullNameField)
        styleTextField(emailField)
        styleTextField(passwordField)
        styleTextField(confirmPasswordField)
        stylePasswordView(confirmPasswordView)
    }
    
    func setPlaceholder(_ textField: UITextField, text: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: UIColor(named: "descriptionLabelColor") ?? .lightGray
            ]
        )
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        viewModel.isSignIn = true
        clearTextFields()
        updateUI()
    }

    @IBAction func signUpTapped(_ sender: Any) {
        viewModel.isSignIn = false
        clearTextFields() 
        updateUI()
    }
    
    func updateUI() {
        
        let isSignIn = viewModel.isSignIn
        
        // Show / Hide fields
        fullNameStackview.isHidden = isSignIn
        confirmPasswordStackview.isHidden = isSignIn
        
        // Button title
        actionButton.setTitle(isSignIn ? "Sign In" : "Create Account", for: .normal)
        
        // Toggle UI
        signInButton.backgroundColor = isSignIn ? .white : .clear
        signUpButton.backgroundColor = isSignIn ? .clear : .white
        
        signInButton.setTitleColor(isSignIn ? .black : .lightGray, for: .normal)
        signUpButton.setTitleColor(isSignIn ? .lightGray : .black, for: .normal)
    }
    
    
    func clearTextFields() {
        fullNameField.text = ""
        emailField.text = ""
        passwordField.text = ""
        confirmPasswordField.text = ""
    }
    
    func styleTextField(_ textField: UITextField) {
        
        // Background (30% opacity)
//        textField.backgroundColor = UIColor(named: "textfieldBgColor")
        textField.backgroundColor = UIColor(hex: "#262626").withAlphaComponent(0.3)
        
        
            textField.textColor = UIColor(named: "headingLabelColor") ?? .white

        
        // Remove default border
        textField.borderStyle = .none
        
        // Add padding (important for UI)
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftView = padding
        textField.leftViewMode = .always
        
        // Add top border
        addTopBorder(to: textField)
    }
    
    func addTopBorder(to view: UIView) {
        
        let border = CALayer()
        border.backgroundColor = UIColor(hex: "#262626").cgColor
        border.frame = CGRect(
            x: 0,
            y: 0,
            width: view.frame.width,
            height: 0.5 // 0.53px ≈ 0.5
        )
        
        view.layer.addSublayer(border)
    }
    
    func stylePasswordView(_ view: UIView) {
        
        // Background (30% opacity)
        view.backgroundColor = UIColor(hex: "#262626").withAlphaComponent(0.3)
        
        // Corner radius (important for UI)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        // Add top border
        addTopViewBorder(to: view)
    }
    
    func addTopViewBorder(to view: UIView) {
        
        // Remove old border
        view.layer.sublayers?.removeAll(where: { $0.name == "topBorder" })
        
        let border = CALayer()
        border.name = "topBorder"
        border.backgroundColor = UIColor(hex: "#262626").cgColor
        border.frame = CGRect(
            x: 0,
            y: 0,
            width: view.frame.width,
            height: 0.5
        )
        
        view.layer.addSublayer(border)
    }
    
    @IBAction func showEyeIconButtonTapped(_ sender: Any) {
        
        isPasswordVisible.toggle()
        
        passwordField.isSecureTextEntry = !isPasswordVisible
        
        // Optional: change icon
        let imageName = isPasswordVisible ? "eyeIcon" : "eye.slash"
        showEyeIconImage.image = UIImage(named: imageName)
//        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    
    @IBAction func actionButtonTapped(_ sender: Any) {
        
        let error = viewModel.validate(
            name: fullNameField.text,
            email: emailField.text,
            password: passwordField.text,
            confirmPassword: confirmPasswordField.text
        )
        
        if let error = error {
            showAlert(message: error)
            return
        }
        
        let email = emailField.text ?? ""
        
        if viewModel.isSignIn {
            
            // 🔥 SIGN IN FLOW
            
            if UserManager.shared.isUserRegistered(email: email) {
                
                AuthManager.shared.login()
                navigateToHome()
                
            } else {
                
                showAlert(message: "User not registered. Please Sign Up first.")
            }
            
        } else {
            
            // 🔥 SIGN UP FLOW
            
            UserManager.shared.saveUser(
                name: fullNameField.text ?? "User",
                email: email
            )
            
            AuthManager.shared.login()
            navigateToHome()
        }
    }
    
    func navigateToHome() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
