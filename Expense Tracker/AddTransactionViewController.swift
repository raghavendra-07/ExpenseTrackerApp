//
//  AddTransactionViewController.swift
//  Expense Tracker
//
//  Created by Apple on 09/04/26.
//

import Foundation
import UIKit

class AddTransactionViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var expensesStackView: UIStackView!
    
    @IBOutlet weak var expensesSwitchView: UIView!
    
    @IBOutlet weak var expensesButton: UIButton!
    @IBOutlet weak var incomeButton: UIButton!
    
    let viewModel = AddTransactionViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateTransactionType(isExpense: true) // default selected
        
        setPlaceholder(categoryTextField, text: "Enter your Category")
        setPlaceholder(amountTextField, text: "Enter amount here...!")
        setPlaceholder(dateTextField, text: "Fill the date")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        

        styleTextField(categoryTextField)
        styleTextField(dateTextField)

    }
    
    
    // MARK: - UI Setup
    
    func setupUI() {
        amountTextField.delegate = self
        amountTextField.textColor = UIColor(named: "headingLabelColor") ?? .white
        dateTextField.textColor = UIColor(named: "headingLabelColor") ?? .white
        categoryTextField.textColor = UIColor(named: "headingLabelColor") ?? .white
        amountTextField.keyboardType = .numberPad
        expensesSwitchView.layer.cornerRadius = 14
        expensesStackView.layer.cornerRadius = 14
        expensesSwitchView.backgroundColor = UIColor(named: "topbarContainerViewBottomColor")
        // Date Picker
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        dateTextField.inputView = datePicker
        
        // Default date
        updateDateField(date: Date())
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        updateDateField(date: sender.date)
        viewModel.date = sender.date
    }
    
    func updateDateField(date: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateTextField.text = formatter.string(from: date)
    }
    
    
    func setPlaceholder(_ textField: UITextField, text: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: UIColor(named: "descriptionLabelColor") ?? .lightGray
            ]
        )
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
    
    // MARK: - Actions
    
    @IBAction func expensesButtonTapped(_ sender: Any) {
        updateTransactionType(isExpense: true)

    }
    
    @IBAction func incomeButtonTapped(_ sender: Any) {
        updateTransactionType(isExpense: false)

    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        // Bind data
        viewModel.category = categoryTextField.text
        let rawAmount = amountTextField.text?.replacingOccurrences(of: "$", with: "")
        viewModel.amount = rawAmount
//        viewModel.amount = amountTextField.text
        
        // Validate
        if let error = viewModel.validate() {
            showAlert(message: error)
            return
        }
        
        let expense = viewModel.createExpense()
        
        // Send back to Home
        NotificationCenter.default.post(
            name: NSNotification.Name("NewTransactionAdded"),
            object: expense
        )
        
        dismiss(animated: true)
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    func updateTransactionType(isExpense: Bool) {
        
        // Update ViewModel
        viewModel.type = isExpense ? .expense : .income
        
        // UI Update
        if isExpense {
            expensesButton.backgroundColor = .white
            incomeButton.backgroundColor = .clear
            
            expensesButton.setTitleColor(UIColor(named: "expensesTextColorActive"), for: .normal)
            incomeButton.setTitleColor(UIColor(named: "expensesTextColorInActive"), for: .normal)
            
        } else {
            incomeButton.backgroundColor = .white
            expensesButton.backgroundColor = .clear
            
            expensesButton.setTitleColor(UIColor(named: "expensesTextColorInActive"), for: .normal)
            incomeButton.setTitleColor(UIColor(named: "expensesTextColorActive"), for: .normal)
            
            incomeButton.setTitleColor(.black, for: .normal)
            expensesButton.setTitleColor(.lightGray, for: .normal)
        }
    
        
        expensesButton.layer.cornerRadius = expensesButton.frame.height / 2
        incomeButton.layer.cornerRadius = incomeButton.frame.height / 2
    }
    
    // MARK: - Alert
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


extension AddTransactionViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        guard textField == amountTextField else { return true }
        
        let currentText = textField.text ?? ""
        
        // Apply change on ORIGINAL text
        let nsString = currentText as NSString
        let newText = nsString.replacingCharacters(in: range, with: string)
        
        // Remove $
        let cleanText = newText.replacingOccurrences(of: "$", with: "")
        
        // Allow empty
        if cleanText.isEmpty {
            textField.text = ""
            return false
        }
        
        // Allow only numbers
        if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: cleanText)) {
            return false
        }
        
        // Format
        textField.text = "$" + cleanText
        
        return false
    }
}
