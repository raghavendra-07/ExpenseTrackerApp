//
//  HomeViewController.swift
//  Expense Tracker
//
//  Created by Apple on 08/04/26.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var mainContainerView: UIView!
    
    @IBOutlet weak var topbarContainerView: UIView!
    
    @IBOutlet weak var mainIconView: UIView!
    
    @IBOutlet weak var notificationView: UIView!
    
    @IBOutlet weak var notificationCountLabel: UILabel!
    
    @IBOutlet weak var searchViewButton: UIButton!
    
    @IBOutlet weak var notificationIconButton: UIButton!
    
    @IBOutlet weak var userGreetingsView: UIStackView!
    
    @IBOutlet weak var cardContainerView: UIView!
    
    @IBOutlet weak var weeklyButton: UIButton!
    
    @IBOutlet weak var expensesStackView: UIStackView!
    
    @IBOutlet weak var monthlyButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var expensesSwitchView: UIView!
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    let viewModel = ExpenseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = UserManager.shared.getUserName()
        greetingLabel.text = "Hey, \(name)"
        
        setupUI()
        setupCard()
        setupTableView()
        updateToggleUI(isWeekly: true)
        viewModel.loadData(type: .weekly)
        
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(handleNewTransaction(_:)),
                name: NSNotification.Name("NewTransactionAdded"),
                object: nil
            )
    }
    
    @objc func handleNewTransaction(_ notification: Notification) {
        
//        if let newExpense = notification.object as? Expense {
//            
//            viewModel.addExpense(newExpense)
//            tableView.reloadData()
//        }
        
        if let newExpense = notification.object as? Expense {
               
               // 1. Add to ViewModel
               viewModel.addExpense(newExpense)
               
               //  2. Reload WEEKLY data 
               viewModel.loadData(type: .weekly)
               
               //  3. Update UI
               updateToggleUI(isWeekly: true)
               tableView.reloadData()
           }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let name = UserManager.shared.getUserName()
        greetingLabel.text = "Hey, \(name)"
        updateCard()
    }
    
    
    func setupUI() {
        mainIconView.layer.cornerRadius = 10
        notificationView.layer.cornerRadius = 8
        expensesSwitchView.layer.cornerRadius = 14
        expensesStackView.layer.cornerRadius = 14
        expensesSwitchView.backgroundColor = UIColor(named: "topbarContainerViewBottomColor")
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        tableView.register(UINib(nibName: "ExpensesTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpensesTableViewCell")
    }
    
    func setupCard() {
        let cardView = FinanceCardView()

        cardContainerView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: cardContainerView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: cardContainerView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: cardContainerView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: cardContainerView.bottomAnchor)
        ])

        let name = UserManager.shared.getUserName()
        
        cardView.configure(
            bank: "ADRBank",
            number: "8763 1111 2222 0329",
            name: name.uppercased(),
            expiry: "10/28"
        )
    }
    
    func updateCard() {
        
        guard let cardView = cardContainerView.subviews.first as? FinanceCardView else { return }
        
        let name = UserManager.shared.getUserName()
        
        cardView.configure(
            bank: "ADRBank",
            number: "8763 1111 2222 0329",
            name: name.uppercased(),
            expiry: "10/28"
        )
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        addBottomBorder(to: topbarContainerView)
    }
    
    @IBAction func weeklyButtonTapped(_ sender: Any) {
        updateToggleUI(isWeekly: true)
    }
    
    @IBAction func monthlyButtonTapped(_ sender: Any) {
        updateToggleUI(isWeekly: false)
    }
    
    func updateToggleUI(isWeekly: Bool) {
        
        if isWeekly {
            weeklyButton.backgroundColor = .white
            monthlyButton.backgroundColor = .clear
            
            weeklyButton.setTitleColor(UIColor(named: "expensesTextColorActive"), for: .normal)
            monthlyButton.setTitleColor(UIColor(named: "expensesTextColorInActive"), for: .normal)
            
            // LOAD WEEKLY DATA
            viewModel.loadData(type: .weekly)
            
        } else {
            monthlyButton.backgroundColor = .white
            weeklyButton.backgroundColor = .clear
            
            weeklyButton.setTitleColor(UIColor(named: "expensesTextColorInActive"), for: .normal)
            monthlyButton.setTitleColor(UIColor(named: "expensesTextColorActive"), for: .normal)
            
            // LOAD MONTHLY DATA
            viewModel.loadData(type: .monthly)
        }
        
        weeklyButton.layer.cornerRadius = weeklyButton.frame.height / 2
        monthlyButton.layer.cornerRadius = monthlyButton.frame.height / 2

        // RELOAD TABLE
        tableView.reloadData()
    }
 
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddTransactionViewController")
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpensesTableViewCell", for: indexPath) as! ExpensesTableViewCell

        let expense = viewModel.expense(at: indexPath.row)
        cell.configure(with: expense)

        cell.backgroundColor = .clear
        cell.selectionStyle = .none

        return cell
    }
}
