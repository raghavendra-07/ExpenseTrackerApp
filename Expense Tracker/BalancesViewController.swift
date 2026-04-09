//
//  BalancesViewController.swift
//  Expense Tracker
//
//  Created by Apple on 09/04/26.
//

import Foundation
import UIKit


class BalancesViewController: UIViewController {
    
    @IBOutlet weak var creditScoreView: UIView!
    @IBOutlet weak var checkCibilButton: UIButton!
    
    @IBOutlet weak var mainContainerView: UIView!
    
    @IBOutlet weak var topbarContainerView: UIView!
    
    @IBOutlet weak var mainIconView: UIView!
        
    @IBOutlet weak var notificationView: UIView!
    
    @IBOutlet weak var notificationCountLabel: UILabel!
    
    @IBOutlet weak var searchViewButton: UIButton!
    
    @IBOutlet weak var notificationIconButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let scoreLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    let viewModel = CurrenciesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLabels()
        updateLastCheckedUI()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addBottomBorder(to: topbarContainerView)
        setupArc()
    }
    
    
    func setupUI() {
        mainIconView.layer.cornerRadius = 10
        notificationView.layer.cornerRadius = 8
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        tableView.register(UINib(nibName: "AvailableCurenciesTableViewCell", bundle: nil), forCellReuseIdentifier: "AvailableCurenciesTableViewCell")
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
    
    
    func updateLastCheckedUI() {
        
        if let lastDate = UserDefaults.standard.object(forKey: "lastCibilCheck") as? Date {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM"
            
            subtitleLabel.text = "Last Check on \(formatter.string(from: lastDate))"
        }
    }
    
    @IBAction func checkCibilTapped(_ sender: UIButton) {
//        generateRandomScore()
        
        if canCheckCibil() {
            generateRandomScore()
            saveLastCheckDate()
            
            subtitleLabel.text = "Updated just now"
            
        } else {
            showAlert()
        }

    }
    
    func canCheckCibil() -> Bool {
        
        guard let lastDate = UserDefaults.standard.object(forKey: "lastCibilCheck") as? Date else {
            return true // First time
        }
        //MARK: Actual cibil calculate for one month
        //        let daysPassed = Calendar.current.dateComponents([.day], from: lastDate, to: Date()).day ?? 0
        //
        //        return daysPassed >= 30
        
        let secondsPassed = Date().timeIntervalSince(lastDate)
        
        return secondsPassed >= 5 //  2 seconds for demo
    }
    
    func saveLastCheckDate() {
        UserDefaults.standard.set(Date(), forKey: "lastCibilCheck")
    }
    
    func generateRandomScore() {
        
        let newScore = Int.random(in: 500...900)
        animateScoreChange(to: newScore)
    }
    
    
    func animateScoreChange(to newValue: Int) {
        
        let currentValue = Int(scoreLabel.text ?? "0") ?? 0
        let duration: Double = 1.0
        let steps = 30
        
        let increment = Double(newValue - currentValue) / Double(steps)
        
        var current = Double(currentValue)
        var stepCount = 0
        
        Timer.scheduledTimer(withTimeInterval: duration / Double(steps), repeats: true) { timer in
            
            stepCount += 1
            current += increment
            
            self.scoreLabel.text = "\(Int(current))"
            
            if stepCount >= steps {
                self.scoreLabel.text = "\(newValue)"
                timer.invalidate()
            }
        }
    }
}

// MARK: - ARC DRAWING
extension BalancesViewController {
    
    func setupArc() {
        
        // Remove old layers (important)
        creditScoreView.layer.sublayers?.removeAll(where: { $0.name == "arcLayer" })
        
        let center = CGPoint(
            x: creditScoreView.bounds.width / 2,
            y: creditScoreView.bounds.height / 2
        )
        
        let radius: CGFloat = 100
        let lineWidth: CGFloat = 18
        
        let arcs = [
            (CGFloat.pi, CGFloat.pi * 1.3, UIColor.systemTeal),
            (CGFloat.pi * 1.3, CGFloat.pi * 1.5, UIColor.systemPink),
            (CGFloat.pi * 1.5, CGFloat.pi * 1.7, UIColor.systemBlue),
            (CGFloat.pi * 1.7, CGFloat.pi * 2, UIColor.systemYellow)
        ]
        
        for arc in arcs {
            let path = UIBezierPath(
                arcCenter: center,
                radius: radius,
                startAngle: arc.0,
                endAngle: arc.1,
                clockwise: true
            )
            
            let layer = CAShapeLayer()
            layer.name = "arcLayer"
            layer.path = path.cgPath
            layer.strokeColor = arc.2.cgColor
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = lineWidth
            layer.lineCap = .round
            
            creditScoreView.layer.addSublayer(layer)
        }
    }
}

// MARK: - CENTER LABELS
extension BalancesViewController {
    
    func setupLabels() {
        
        // Score Label (660)
        scoreLabel.text = "660"
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 36)
        scoreLabel.textAlignment = .center
        
        // Title
        titleLabel.text = "Your Credit Score is average"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        
        // Subtitle
        subtitleLabel.text = "Last Check on 21 Apr"
        subtitleLabel.textColor = .lightGray
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [
            scoreLabel,
            titleLabel,
            subtitleLabel
        ])
        
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        
        creditScoreView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: creditScoreView.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: creditScoreView.centerYAnchor)
        ])
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "Limit Reached",
//            message: "You can check your credit score once every 30 days.",
            message: "You can check your credit score once every 5 seconds.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
}


extension BalancesViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfRows()
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "AvailableCurenciesTableViewCell",
            for: indexPath
        ) as! AvailableCurenciesTableViewCell
        
        let currency = viewModel.currency(at: indexPath.row)
//        let currency = viewModel.currency(at: indexPath.section) // 🔥 section NOT row
        cell.configure(with: currency)
        
        return cell
    }
}
