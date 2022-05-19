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
    
    var presenter: HomePresenter?

    //MARK: Lifecycle methods
    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Bitcoin Millionaire"
        view.backgroundColor = .systemBackground
    }
    
    //MARK: Custom methods
    
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
        latestPriceLabel.textAlignment = .center
        latestPriceLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        latestPriceLabel.adjustsFontForContentSizeCategory = true

        latestPriceLabel.text = "Latest Price: $\(latestPrice ?? 0.0)"
        latestPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(latestPriceLabel)
        
        NSLayoutConstraint.activate([
            latestPriceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
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
        numberOfCoinsLabel.textAlignment = .center
        numberOfCoinsLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        numberOfCoinsLabel.adjustsFontForContentSizeCategory = true
        numberOfCoinsLabel.text = "Bitcoins: \(numberOfCoins ?? 0.0)"
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
        let addBitCoinButton = ButtonUtility.createButton(title: "Add BitCoin")
        addBitCoinButton.addTarget(self, action: #selector(addBitCoin), for: .touchUpInside)

        let sellBitCoinButton = ButtonUtility.createButton(title: "Sell Bitcoin")
        sellBitCoinButton.addTarget(self, action: #selector(sellBitCoin), for: .touchUpInside)
        
        let checkPriceButton = ButtonUtility.createButton(title: "Check Latest Price")
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
    
    //MARK: Actions performed by buttons
    @objc func addBitCoin() {
       print("Add BitCoin")
    }
    
    @objc func sellBitCoin() {
        print("Sell BitCoin")
    }
    
    @objc func checkPrice() {
        print("Check BitCoin Price")
    }
    
    @objc func checkForMillionaire() {
        print("Check if i am millionaire")
    }
}
