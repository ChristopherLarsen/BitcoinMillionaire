//
//  MillionaireView.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-24.
//

import Foundation
import UIKit
import Combine

// MARK: - MillionaireViewControllerProtocol

protocol MillionaireViewControllerProtocol {
    var isBitcoinMillionaire: PassthroughSubject<Bool, Never> { get set }
}

// MARK: - MillionaireViewController

class MillionaireViewController : UIViewController, MillionaireViewControllerProtocol {
    
    var containerView: UIView!
    var labelResult: UILabel!
    var imageView: UIImageView!
    var labelCheer: UILabel!
    var buttonDone: UIButton!
    
    var millionairePresenter: MillionairePresenterProtocol
    
    var isBitcoinMillionaire: PassthroughSubject<Bool, Never> = PassthroughSubject()
    
    var cancellables: Set<AnyCancellable> = []
    
    init(withPresenter millionairePresenter: MillionairePresenterProtocol) {
        self.millionairePresenter = millionairePresenter
        super.init(nibName: nil, bundle: nil)
        
        self.millionairePresenter.millionaireViewController = self
        
        self.isBitcoinMillionaire.sink { completion in
            print("TODO")
        } receiveValue: { [weak self] isMillionaire in
            guard let self = self else {
                return
            }
            self.updateView(isMillionaire: isMillionaire)
        }.store(in: &cancellables)

    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUserInterface()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Bitcoin Millionaire"
        view.backgroundColor = .systemBackground
    }
    
}

// MARK: - Private

private extension MillionaireViewController {
    
    func setUpUserInterface() {
        
        let containerFrame: CGRect = UIScreen.main.bounds.inset(by: UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0))
        containerView = UIView(frame: containerFrame)
        view.addSubview(containerView)
        
        labelResult = UILabel()
        labelResult.accessibilityIdentifier = "labelResult"
        labelResult.textAlignment = .center
        labelResult.font = UIFont.preferredFont(forTextStyle: .title3)
        labelResult.adjustsFontForContentSizeCategory = true
        labelResult.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelResult)

        NSLayoutConstraint.activate([
            labelResult.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            labelResult.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            labelResult.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            labelResult.heightAnchor.constraint(equalToConstant: 40)
        ])

        imageView = UIImageView(image: nil)
        containerView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0)
        ])

        guard let imageView: UIImageView = imageView else {
            return
        }
        
        let proportionalWidthConstraint = NSLayoutConstraint(item: imageView,
                                                             attribute: .width,
                                                             relatedBy: .equal,
                                                             toItem: imageView,
                                                             attribute: .height,
                                                             multiplier: 1.0,
                                                             constant: 1.0)
        
        imageView.addConstraint(proportionalWidthConstraint)
    
        labelCheer = UILabel()
        labelCheer.accessibilityIdentifier = "labelCheer"
        labelCheer.textAlignment = .center
        labelCheer.font = UIFont.preferredFont(forTextStyle: .title3)
        labelCheer.adjustsFontForContentSizeCategory = true
        labelCheer.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelCheer)

        NSLayoutConstraint.activate([
            labelCheer.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0.0),
            labelCheer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            labelCheer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            labelCheer.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        buttonDone = ButtonUtility.createButton(title: "")
        containerView.addSubview(buttonDone)

        NSLayoutConstraint.activate([
            buttonDone.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
            buttonDone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            buttonDone.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            buttonDone.heightAnchor.constraint(equalToConstant: 40)
        ])

    }
    
    func setupBindings() {
        // TODO: setupBindings
    }
    
}

// MARK: - Private - Update

private extension MillionaireViewController {
    
    func updateView(isMillionaire: Bool) {
        // TODO:
    }
    
}
