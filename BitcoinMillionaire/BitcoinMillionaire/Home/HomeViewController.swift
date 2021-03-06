//
//  HomeViewController.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import UIKit
import Combine
import ReSwift

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
    var noticeLabel: UILabel!
    var activityLoader: UIAlertController?
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Lifecycle methods
    
    init(presenter: HomePresenterProtocol)  {
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

        mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        
        mainStore.unsubscribe(self)
    }
    
    // MARK: Custom methods
    
    private func setupBindings() {
        // TODO: Replace binding with Redux Store subscription
        //
        if let presenter = presenter as? HomePresenter {
            subscriptions =
            [presenter.$latestPrice
                .sink(receiveValue: { price in
                    if let activityLoader = self.activityLoader {
                        self.stopLoader(loader: activityLoader)
                    }
                    if let price = price {
                        let numberFormatter = NumberFormatter()
                        numberFormatter.numberStyle = .decimal
                        if let formattedNumber = numberFormatter.string(from: NSNumber(value: price)) {
                            self.latestPriceLabel.text  =  "Latest Price: $\(formattedNumber)"
                        }
                    }
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
        activityLoader = loader(message: "Please wait...")
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
        
        //Notice label
        createNoticeLabel()
        
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
            latestPriceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
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
            bitcoinContainerView.heightAnchor.constraint(equalToConstant: 250)
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
            millionaireButton.bottomAnchor.constraint(equalTo: noticeLabel.topAnchor, constant: -10),
            millionaireButton.heightAnchor.constraint(equalToConstant: 63.3),
            millionaireButton.leadingAnchor.constraint(equalTo: bitcoinContainerView.leadingAnchor),
            millionaireButton.trailingAnchor.constraint(equalTo: bitcoinContainerView.trailingAnchor)
        ])
    }
    
    func createNoticeLabel() {
        noticeLabel = UILabel()
        noticeLabel.accessibilityIdentifier = "noticeLabel"
        noticeLabel.textAlignment = .center
        self.noticeLabel.text  =  ""
        noticeLabel.numberOfLines = 2
        noticeLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        noticeLabel.adjustsFontForContentSizeCategory = true
        noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noticeLabel)
        
        NSLayoutConstraint.activate([
            noticeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            noticeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            noticeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            noticeLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension HomeViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = State
    
    func newState(state: State) {
        noticeLabel?.text = state.message
        
        let bitcoinString = String(state.bitcoinState.bitcoin)
        numberOfCoinsLabel.text = "Bitcoin: \(bitcoinString)"
    }
    
}
