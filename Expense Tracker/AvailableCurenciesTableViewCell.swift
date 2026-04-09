//
//  AvailableCurenciesTableViewCell.swift
//  Expense Tracker
//
//  Created by Apple on 09/04/26.
//

import UIKit

class AvailableCurenciesTableViewCell: UITableViewCell {
        
    @IBOutlet weak var currencyCardContainerView: UIView!
    
    @IBOutlet weak var innerCurrencyCardView: UIView!
    
    @IBOutlet weak var currencyTitleLabel: UILabel!
    
    @IBOutlet weak var currencySubtitleLabel: UILabel!
    
    @IBOutlet weak var currencyEnableLabel: UILabel!
    @IBOutlet weak var enableView: UIView!
    @IBOutlet weak var starIconButton: UIButton!

    @IBOutlet weak var currencyLogoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        backgroundColor = .clear

        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        applyGradient()
        applyInnerShadow(to: currencyCardContainerView)
    }

    // MARK: - Setup UI
    private func setupUI() {

        // Outer card
//        cardContainerView.layer.cornerRadius = 12
        currencyCardContainerView.clipsToBounds = false

        currencyCardContainerView.layer.cornerCurve = .continuous
        // Amount pill
        enableView.layer.cornerRadius = 8
        enableView.backgroundColor = UIColor(named: "topbarContainerViewBottomColor")

        // Labels
        currencyTitleLabel.textColor = .white
        currencyTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)

        currencySubtitleLabel.textColor = .lightGray
        currencySubtitleLabel.font = UIFont.systemFont(ofSize: 12)

        currencyEnableLabel.textColor = .white
        currencyEnableLabel.font = UIFont.boldSystemFont(ofSize: 14)

        // Star icon
        starIconButton.tintColor = .lightGray
    }

    // MARK: - Gradient + Shadow
    private func applyGradient() {

        // Remove old gradient (important)
        currencyCardContainerView.layer.sublayers?.removeAll(where: { $0.name == "gradient" })

        let gradient = CAGradientLayer()
        gradient.name = "gradient"
        gradient.frame = currencyCardContainerView.bounds

        gradient.colors = [
            UIColor(named: "ScreenBackgroundColor")?.cgColor,
            UIColor(named: "topbarContainerViewBottomColor")?.cgColor
        ]

        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.cornerRadius = currencyCardContainerView.layer.cornerRadius
        gradient.masksToBounds = true


        currencyCardContainerView.layer.insertSublayer(gradient, at: 0)
    }
    
    
    func applyInnerShadow(to view: UIView) {

        view.layer.sublayers?.removeAll(where: { $0.name == "innerShadow" })

        let cornerRadius: CGFloat = 12

        let shadowLayer = CAShapeLayer()
        shadowLayer.name = "innerShadow"
        shadowLayer.frame = view.bounds

        let outerPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius)
        let innerPath = UIBezierPath(
            roundedRect: view.bounds.insetBy(dx: -20, dy: -20),
            cornerRadius: cornerRadius
        )

        outerPath.append(innerPath)
        shadowLayer.path = outerPath.cgPath
        shadowLayer.fillRule = .evenOdd

        // Light shadow
        shadowLayer.shadowColor = UIColor.white.withAlphaComponent(0.15).cgColor
        shadowLayer.shadowOffset = CGSize(width: 2, height: 2)
        shadowLayer.shadowRadius = 7
        shadowLayer.shadowOpacity = 1

        view.layer.addSublayer(shadowLayer)

        // Dark shadow
        let darkLayer = CAShapeLayer()
        darkLayer.name = "innerShadow"
        darkLayer.frame = view.bounds
        darkLayer.path = outerPath.cgPath
        darkLayer.fillRule = .evenOdd

        darkLayer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        darkLayer.shadowOffset = CGSize(width: -2, height: -2)
        darkLayer.shadowRadius = 7
        darkLayer.shadowOpacity = 1

        view.layer.addSublayer(darkLayer)
    }

    // MARK: - Configure (Dynamic Data)
//    func configure(with expense: Expense) {
//
//        currencyTitleLabel.text = expense.title
//        currencySubtitleLabel.text = expense.subtitle
//        currencyEnableLabel.text = expense.amount
//
//        // 🔥 Special styling for TRAVEL (green glow)
//        if expense.title == "TRAVEL" {
//            applyGreenGlow()
//        } else {
//            removeGlow()
//        }
//    }
    
    func configure(with currency: Currency) {

        currencyTitleLabel.text = currency.code
        currencySubtitleLabel.text = currency.name
        
        currencyEnableLabel.text = currency.isEnabled ? "Enabled" : "Enable"
        
        enableView.backgroundColor = currency.isEnabled
            ? UIColor.systemGreen.withAlphaComponent(0.2)
            : UIColor(named: "topbarContainerViewBottomColor")
    }

    // MARK: - Glow Effects
    private func applyGreenGlow() {
        currencyCardContainerView.layer.shadowColor = UIColor(named: "travelExpensesGradientColor")?.cgColor
        currencyCardContainerView.layer.shadowOpacity = 0.3
        currencyCardContainerView.layer.shadowRadius = 12
        currencyCardContainerView.layer.shadowOffset = .zero
    }

    private func removeGlow() {
        currencyCardContainerView.layer.shadowColor = UIColor.black.cgColor
        currencyCardContainerView.layer.shadowOpacity = 0.3
        currencyCardContainerView.layer.shadowRadius = 8
    }

    
}





