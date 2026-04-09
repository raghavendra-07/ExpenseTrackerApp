//
//  FinanceCardView.swift
//  Expense Tracker
//
//  Created by Apple on 08/04/26.
//

import UIKit

//class FinanceCardView: UIView {
//
//    private let bankLabel = UILabel()
//    private let numberLabel = UILabel()
//    private let nameLabel = UILabel()
//    private let expiryLabel = UILabel()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupUI()
//    }
//
//    private func setupUI() {
//        layer.cornerRadius = 20
//        clipsToBounds = true
//
//        setupGradient()
//        setupLabels()
//        setupLayout()
//    }
//
//    private func setupGradient() {
//        let gradient = CAGradientLayer()
//        gradient.name = "cardGradient"
//        gradient.colors = [
//            UIColor(red: 236/255, green: 205/255, blue: 165/255, alpha: 1).cgColor,
//            UIColor(red: 92/255, green: 200/255, blue: 164/255, alpha: 1).cgColor
//        ]
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 1, y: 1)
//
//        layer.insertSublayer(gradient, at: 0)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        layer.sublayers?.first(where: { $0.name == "cardGradient" })?.frame = bounds
//    }
//
//    private func setupLabels() {
//        bankLabel.textColor = .white
//        bankLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
//
//        numberLabel.textColor = .white
//        numberLabel.font = UIFont.boldSystemFont(ofSize: 18)
//
//        nameLabel.textColor = .white
//        nameLabel.font = UIFont.systemFont(ofSize: 12)
//
//        expiryLabel.textColor = .white
//        expiryLabel.font = UIFont.systemFont(ofSize: 12)
//    }
//
//    private func setupLayout() {
//
//        let bottomStack = UIStackView(arrangedSubviews: [nameLabel, expiryLabel])
//        bottomStack.axis = .horizontal
//        bottomStack.distribution = .equalSpacing
//
//        let mainStack = UIStackView(arrangedSubviews: [
//            bankLabel,
//            UIView(),
//            numberLabel,
//            UIView(),
//            bottomStack
//        ])
//
//        mainStack.axis = .vertical
//        mainStack.spacing = 8
//
//        addSubview(mainStack)
//        mainStack.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
//            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
//        ])
//    }
//
//    // 🔥 Dynamic data
//    func configure(bank: String, number: String, name: String, expiry: String) {
//        bankLabel.text = bank
//        numberLabel.text = number
//        nameLabel.text = "Card Holder Name\n\(name)"
//        expiryLabel.text = "Expired Date\n\(expiry)"
//
//        nameLabel.numberOfLines = 2
//        expiryLabel.numberOfLines = 2
//    }
//}


//import UIKit

class FinanceCardView: UIView {

    private let bankLabel = UILabel()
    private let numberLabel = UILabel()
    private let nameLabel = UILabel()
    private let expiryLabel = UILabel()
    private let topRightIcon = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        layer.cornerRadius = 20
        clipsToBounds = true

        setupGradient()
        setupViews()
        setupLayout()
    }

    // MARK: - Gradient
    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.name = "cardGradient"
        gradient.colors = [
            UIColor(red: 236/255, green: 205/255, blue: 165/255, alpha: 1).cgColor,
            UIColor(red: 92/255, green: 200/255, blue: 164/255, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)

        layer.insertSublayer(gradient, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.first(where: { $0.name == "cardGradient" })?.frame = bounds
    }

    // MARK: - Views Setup
    private func setupViews() {

        // Bank Label
        bankLabel.textColor = .white
        bankLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)

        // Card Number
        numberLabel.textColor = .white
        numberLabel.font = UIFont.boldSystemFont(ofSize: 20)
        numberLabel.textAlignment = .center

        // Name
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.numberOfLines = 2

        // Expiry
        expiryLabel.textColor = .white
        expiryLabel.font = UIFont.systemFont(ofSize: 12)
        expiryLabel.numberOfLines = 2
        expiryLabel.textAlignment = .right

        // Icon
        topRightIcon.image = UIImage(named: "cardLogo") // replace with asset if needed
        topRightIcon.tintColor = .white
        topRightIcon.contentMode = .scaleAspectFit
    }

    // MARK: - Layout
    private func setupLayout() {

        // Top Row (Bank + Icon)
        let topRow = UIStackView(arrangedSubviews: [bankLabel, UIView(), topRightIcon])
        topRow.axis = .horizontal
        topRow.alignment = .center

        topRightIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topRightIcon.widthAnchor.constraint(equalToConstant: 24),
            topRightIcon.heightAnchor.constraint(equalToConstant: 24)
        ])

        // Center container (for perfect centering)
//        let centerContainer = UIView()
//        centerContainer.addSubview(numberLabel)
//
//        numberLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            numberLabel.centerXAnchor.constraint(equalTo: centerContainer.centerXAnchor),
//            numberLabel.centerYAnchor.constraint(equalTo: centerContainer.centerYAnchor)
//        ])
        
        addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        // Bottom Row (Name + Expiry)
        let bottomStack = UIStackView(arrangedSubviews: [nameLabel, expiryLabel])
        bottomStack.axis = .horizontal
        bottomStack.distribution = .equalSpacing

        // Main Stack
        let mainStack = UIStackView(arrangedSubviews: [
            topRow,
            UIView(),
//            centerContainer,
//            UIView(),
            bottomStack
        ])

        mainStack.axis = .vertical
        mainStack.spacing = 8

        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Configure (Dynamic Data)
    func configure(bank: String, number: String, name: String, expiry: String) {
        bankLabel.text = bank
        numberLabel.text = number
        nameLabel.text = "Card Holder Name\n\(name)"
        expiryLabel.text = "Expired Date\n\(expiry)"
    }
}
