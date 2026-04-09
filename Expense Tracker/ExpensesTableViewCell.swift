//
//  ExpensesTableViewCell.swift
//  Expense Tracker
//
//  Created by Apple on 08/04/26.
//

import UIKit

class ExpensesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var innerCardContainerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var starIconButton: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        backgroundColor = .clear

        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        applyGradient()
        applyInnerShadow(to: cardContainerView)
    }

    // MARK: - Setup UI
    private func setupUI() {

        // Outer card
//        cardContainerView.layer.cornerRadius = 12
        cardContainerView.clipsToBounds = false

        cardContainerView.layer.cornerCurve = .continuous
        // Amount pill
        amountView.layer.cornerRadius = 8
        amountView.backgroundColor = UIColor(named: "topbarContainerViewBottomColor")

        // Labels
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)

        subtitleLabel.textColor = .lightGray
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)

        amountLabel.textColor = .white
        amountLabel.font = UIFont.boldSystemFont(ofSize: 14)

        // Star icon
        starIconButton.tintColor = .lightGray
    }

    // MARK: - Gradient + Shadow
    private func applyGradient() {

        // Remove old gradient (important)
        cardContainerView.layer.sublayers?.removeAll(where: { $0.name == "gradient" })

        let gradient = CAGradientLayer()
        gradient.name = "gradient"
        gradient.frame = cardContainerView.bounds

        gradient.colors = [
            UIColor(named: "ScreenBackgroundColor")?.cgColor,
            UIColor(named: "topbarContainerViewBottomColor")?.cgColor
        ]

        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.cornerRadius = cardContainerView.layer.cornerRadius
        gradient.masksToBounds = true


        cardContainerView.layer.insertSublayer(gradient, at: 0)
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
    func configure(with expense: Expense) {

        titleLabel.text = expense.title
        subtitleLabel.text = expense.subtitle
        amountLabel.text = expense.amount

        // 🔥 Special styling for TRAVEL (green glow)
        if expense.title == "TRAVEL" {
            applyGreenGlow()
        } else {
            removeGlow()
        }
    }

    // MARK: - Glow Effects
    private func applyGreenGlow() {
        cardContainerView.layer.shadowColor = UIColor(named: "travelExpensesGradientColor")?.cgColor
        cardContainerView.layer.shadowOpacity = 0.3
        cardContainerView.layer.shadowRadius = 12
        cardContainerView.layer.shadowOffset = .zero
    }

    private func removeGlow() {
        cardContainerView.layer.shadowColor = UIColor.black.cgColor
        cardContainerView.layer.shadowOpacity = 0.3
        cardContainerView.layer.shadowRadius = 8
    }

    
}


extension UIColor {
    convenience init(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hex = hex.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)

        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue: CGFloat(rgb & 0xFF) / 255,
            alpha: 1
        )
    }
}
