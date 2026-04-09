//
//  ProfileViewController.swift
//  Expense Tracker
//
//  Created by Apple on 09/04/26.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
  
    @IBOutlet weak var mainContainerView: UIView!
    
    @IBOutlet weak var topbarContainerView: UIView!
    
    @IBOutlet weak var mainIconView: UIView!
    
    @IBOutlet weak var innerIconView: UIView!
    
    @IBOutlet weak var notificationView: UIView!
    
    @IBOutlet weak var notificationCountLabel: UILabel!
    
    @IBOutlet weak var searchViewButton: UIButton!
    
    @IBOutlet weak var notificationIconButton: UIButton!
    
    @IBOutlet weak var previewButton: UIButton!
    
    @IBOutlet weak var expensesStackView: UIStackView!
    
    @IBOutlet weak var editButton: UIButton!
        
    @IBOutlet weak var expensesSwitchView: UIView!
    
    @IBOutlet weak var previewDetailsView: UIView!
    
    @IBOutlet weak var editDetailsView: UIView!
    
    @IBOutlet weak var totalSpendingsLabel: UILabel!
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var balanceMoneyLabel: UILabel!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var showEyeIconImage: UIImageView!
    
    @IBOutlet weak var passwordView: UIView!
    
    let viewModel = ProfileViewModel()
    
    var isPasswordVisible = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let name = UserManager.shared.getUserName()
        let email = UserManager.shared.getUserEmail()

        userNameLabel.text = name
        setEmail(email: email)
        
        updateProfileUI(isPreview: true)
        
        setTotalSpending(amount: "$2000")
//        setEmail(email: "alex@gmail.com")
        setBalance(amount: "$20000")
        
        setPlaceholder(fullNameTextField, text: "Enter your full name")
        setPlaceholder(emailTextField, text: "Enter your email")
        setPlaceholder(passwordTextField, text: "Create a password")
        setPlaceholder(confirmPasswordTextField, text: "Confirm your password")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addBottomBorder(to: topbarContainerView)

        styleTextField(fullNameTextField)
        styleTextField(emailTextField)
        styleTextField(passwordTextField)
        styleTextField(confirmPasswordTextField)
        stylePasswordView(passwordView)
    }
    
    
    func setupUI() {
        mainIconView.layer.cornerRadius = 10
        innerIconView.layer.cornerRadius = 10
        notificationView.layer.cornerRadius = 8
        expensesSwitchView.layer.cornerRadius = 14
        expensesStackView.layer.cornerRadius = 14
        expensesSwitchView.backgroundColor = UIColor(named: "topbarContainerViewBottomColor")
    }
    
    func addBottomBorder(to view: UIView) {
        let border = CALayer()
        border.backgroundColor = UIColor(named: "topbarContainerViewBottomColor")?.cgColor
        border.frame = CGRect(
            x: 0,
            y: view.frame.height - 0.5,
            width: view.frame.width,
            height: 0.5
        )
        view.layer.addSublayer(border)
    }
    
    func setTotalSpending(amount: String) {
        
        let titleText = "Total spendings: "
        let valueText = amount
        
        let fullText = titleText + valueText
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Title color
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor(named: "descriptionLabelColor") ?? .lightGray,
            range: NSRange(location: 0, length: titleText.count)
        )
        
        // Value color
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor(named: "headingLabelColor") ?? .white,
            range: NSRange(location: titleText.count, length: valueText.count)
        )
        
        totalSpendingsLabel.attributedText = attributedString
    }
    
    func setEmail(email: String) {
        
        let title = "Email: "
        let value = email
        
        let text = title + value
        let attr = NSMutableAttributedString(string: text)
        
        attr.addAttribute(.foregroundColor,
                          value: UIColor(named: "descriptionLabelColor") ?? .lightGray,
                          range: NSRange(location: 0, length: title.count))
        
        attr.addAttribute(.foregroundColor,
                          value: UIColor(named: "headingLabelColor") ?? .white,
                          range: NSRange(location: title.count, length: value.count))
        
        userEmailLabel.attributedText = attr
    }
    
    func setBalance(amount: String) {
        
        let title = "Balance: "
        let value = amount
        
        let text = title + value
        let attr = NSMutableAttributedString(string: text)
        
        attr.addAttribute(.foregroundColor,
                          value: UIColor(named: "descriptionLabelColor") ?? .lightGray,
                          range: NSRange(location: 0, length: title.count))
        
        attr.addAttribute(.foregroundColor,
                          value: UIColor(named: "headingLabelColor") ?? .white,
                          range: NSRange(location: title.count, length: value.count))
        
        balanceMoneyLabel.attributedText = attr
    }
    
    
    func styleTextField(_ textField: UITextField) {
        
        // Background (30% opacity)
//        textField.backgroundColor = UIColor(named: "textfieldBgColor")
        textField.backgroundColor = UIColor(hex: "#262626").withAlphaComponent(0.3)
        
        // Remove default border
        textField.borderStyle = .none
        
        // Add padding (important for UI)
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftView = padding
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 10
        
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
    
    func setPlaceholder(_ textField: UITextField, text: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: UIColor(named: "descriptionLabelColor") ?? .lightGray
            ]
        )
    }
    
    @IBAction func previewButtonTapped(_ sender: Any) {
        updateProfileUI(isPreview: true)
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        updateProfileUI(isPreview: false)
        DispatchQueue.main.async {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func updateDetailsButtonTapped(_ sender: Any) {
        
        let error = viewModel.validate(
            name: fullNameTextField.text,
            email: emailTextField.text,
            password: passwordTextField.text,
            confirmPassword: confirmPasswordTextField.text
        )
        
        if let error = error {
            showAlert(message: error)
            return
        }
        
        // ✅ Update data
        viewModel.updateUser(
            name: fullNameTextField.text ?? "",
            email: emailTextField.text ?? ""
        )
        
        // ✅ Update UI from ViewModel
        if let user = viewModel.user {
            setEmail(email: user.email)
            setTotalSpending(amount: user.spending)
            setBalance(amount: user.balance)
            userNameLabel.text = user.name
        }
        
        // 🔥 CLEAR FIELDS (IMPORTANT)
        clearTextFields()
        
        // Switch to preview
        updateProfileUI(isPreview: true)
    }
    
    func clearTextFields() {
        fullNameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
    }
    
    
    func updateProfileUI(isPreview: Bool) {
        
        previewDetailsView.isHidden = !isPreview
        editDetailsView.isHidden = isPreview

        previewButton.backgroundColor = isPreview ? .white : .clear
        editButton.backgroundColor = isPreview ? .clear : .white

        previewButton.setTitleColor(
            UIColor(named: isPreview ? "expensesTextColorActive" : "expensesTextColorInActive") ?? .black,
            for: .normal
        )

        editButton.setTitleColor(
            UIColor(named: isPreview ? "expensesTextColorInActive" : "expensesTextColorActive") ?? .lightGray,
            for: .normal
        )

        // 🔥 FIX (IMPORTANT)
        view.layoutIfNeeded()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    @IBAction func showEyeIconButtonTapped(_ sender: Any) {
        
        isPasswordVisible.toggle()
        
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        
        // Optional: change icon
        let imageName = isPasswordVisible ? "eyeIcon" : "eye.slash"
        showEyeIconImage.image = UIImage(named: imageName)
//        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
}
