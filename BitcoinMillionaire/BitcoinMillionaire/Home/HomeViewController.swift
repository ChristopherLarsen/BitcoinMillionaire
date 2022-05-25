//
//  HomeViewController.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    //MARK: Variables & Constants
    
    var latestPriceLabel: UILabel!
    var latestPrice: Double?
    var numberOfCoinsLabel: UILabel!
    var numberOfCoins: Double?
    var bitcoinContainerView: UIView!
    var buttonStack: UIStackView!
    var millionaireButton: UIButton!
    var presenter: HomePresenterProtocol?
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Lifecycle methods
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserInterface()
        setupBindings()
        presenter?.checkNumberOfCoinsAvailable()
        presenter?.checkLatestBitcoinPrice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Bitcoin Millionaire"
        view.backgroundColor = .systemBackground
    }
    
    //MARK: Custom methods
    
    private func setupBindings() {
        if let presenter = presenter as? HomePresenter {
            subscriptions =
            [presenter.$latestPrice
                .sink(receiveValue: { price in
                    self.latestPriceLabel.text  =  String(format: "Latest Price: $%.2f", price ?? 0.0)
                }),
             presenter.$bitcoinsAvailable
                .sink(receiveValue: { coins in
                    self.numberOfCoinsLabel.text = "Bitcoins: \(self.numberOfCoins ?? 0.0)"
                })]
        }
    }
    
    //MARK: Actions performed by buttons
    @objc func addBitcoin() { 
        presenter?.addBitcoin()
    }
    
    @objc func sellBitCoin() {
        presenter?.sellBitcoin()
    }
    
    @objc func checkPrice() {
        presenter?.checkLatestBitcoinPriceOnline()
    }
    
    @objc func checkForMillionaire() {
        presenter?.checkIfIAmAMillionaire()
    }
    
}

// Setup User Interface
extension HomeViewController {
    /// Method to setup user interface
    func setUpUserInterface() {
        //latest price label
        createLatestPriceLabel()
        
        //Bitcoin View
        createBitcoinView()
        
        //Add Button Stack
        createButtonsStack()
        
        //Check millionair button
        createCheckMillionaireButton()
    }
    
    
    /// Method to create latest price labels
    func createLatestPriceLabel() {
        latestPriceLabel = UILabel()
        latestPriceLabel.accessibilityIdentifier = "latestPriceLabel"
        latestPriceLabel.textAlignment = .center
        self.latestPriceLabel.text  =  "Latest Price: $0.0"
        latestPriceLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        latestPriceLabel.adjustsFontForContentSizeCategory = true
        latestPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(latestPriceLabel)
        
        NSLayoutConstraint.activate([
            latestPriceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            latestPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            latestPriceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            latestPriceLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    /// Method to create Bitcoin View
    func createBitcoinView() {
        //Outer Container
        bitcoinContainerView = UIView()
        bitcoinContainerView.layer.borderWidth = 2.0
        bitcoinContainerView.layer.borderColor = UIColor.lightGray.cgColor
        bitcoinContainerView.layer.accessibilityLabel = "bitcoinContainerView"
        bitcoinContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bitcoinContainerView)
        
        NSLayoutConstraint.activate([
            bitcoinContainerView.topAnchor.constraint(equalTo: latestPriceLabel.bottomAnchor, constant: 15),
            bitcoinContainerView.leadingAnchor.constraint(equalTo: latestPriceLabel.leadingAnchor),
            bitcoinContainerView.trailingAnchor.constraint(equalTo: latestPriceLabel.trailingAnchor),
            bitcoinContainerView.heightAnchor.constraint(equalToConstant: 280)
        ])
        
        //Bitcoin Image
        let bitcoinImageView = UIImageView()
        bitcoinImageView.image = UIImage(named: "Bitcoin")
        bitcoinImageView.accessibilityIdentifier = "bitcoinImageView"
        bitcoinContainerView.layer.cornerRadius = 5.0
        bitcoinImageView.translatesAutoresizingMaskIntoConstraints = false
        bitcoinContainerView.addSubview(bitcoinImageView)
        
        NSLayoutConstraint.activate([
            bitcoinImageView.centerXAnchor.constraint(equalTo: bitcoinContainerView.centerXAnchor),
            bitcoinImageView.centerYAnchor.constraint(equalTo: bitcoinContainerView.centerYAnchor),
            bitcoinImageView.widthAnchor.constraint(equalToConstant: 100),
            bitcoinImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        //Coins number label
        numberOfCoinsLabel = UILabel()
        numberOfCoinsLabel.accessibilityIdentifier = "numberOfCoinsLabel"
        numberOfCoinsLabel.textAlignment = .center
        self.numberOfCoinsLabel.text = "Bitcoins: 0.0"
        numberOfCoinsLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        numberOfCoinsLabel.adjustsFontForContentSizeCategory = true
        numberOfCoinsLabel.translatesAutoresizingMaskIntoConstraints = false
        bitcoinContainerView.addSubview(numberOfCoinsLabel)
        
        NSLayoutConstraint.activate([
            numberOfCoinsLabel.topAnchor.constraint(equalTo: bitcoinImageView.bottomAnchor, constant: 20),
            numberOfCoinsLabel.leadingAnchor.constraint(equalTo: bitcoinContainerView.leadingAnchor, constant: 30),
            numberOfCoinsLabel.trailingAnchor.constraint(equalTo: bitcoinContainerView.trailingAnchor, constant: -30),
            numberOfCoinsLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    /// Method to create action button stacks
    func createButtonsStack() {
        let addBitCoinButton = ButtonUtility.createButton(title: "Add Bitcoin")
        addBitCoinButton.accessibilityIdentifier = "addBitCoinButton"
        addBitCoinButton.addTarget(self, action: #selector(addBitcoin), for: .touchUpInside)
        
        let sellBitCoinButton = ButtonUtility.createButton(title: "Sell Bitcoin")
        sellBitCoinButton.accessibilityIdentifier = "sellBitCoinButton"
        sellBitCoinButton.addTarget(self, action: #selector(sellBitCoin), for: .touchUpInside)
        
        let checkPriceButton = ButtonUtility.createButton(title: "Check Latest Price")
        checkPriceButton.accessibilityIdentifier = "checkPriceButton"
        checkPriceButton.addTarget(self, action: #selector(checkPrice), for: .touchUpInside)
        
        buttonStack = UIStackView(arrangedSubviews: [addBitCoinButton, sellBitCoinButton, checkPriceButton])
        buttonStack.axis = .vertical
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 5
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            buttonStack.topAnchor.constraint(equalTo: bitcoinContainerView.bottomAnchor, constant: 20),
            buttonStack.leadingAnchor.constraint(equalTo: bitcoinContainerView.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: bitcoinContainerView.trailingAnchor),
            buttonStack.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    
    /// Method to create Check Millionair button
    func createCheckMillionaireButton() {
        millionaireButton = ButtonUtility.createButton(title: "Am I a Millionaire?", backgroundColor: .systemGreen)
        millionaireButton.accessibilityIdentifier = "millionaireButton"
        millionaireButton.addTarget(self, action: #selector(checkForMillionaire), for: .touchUpInside)
        view.addSubview(millionaireButton)
        millionaireButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            millionaireButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            millionaireButton.heightAnchor.constraint(equalToConstant: 63.3),
            millionaireButton.leadingAnchor.constraint(equalTo: bitcoinContainerView.leadingAnchor),
            millionaireButton.trailingAnchor.constraint(equalTo: bitcoinContainerView.trailingAnchor)
        ])
    }
}
