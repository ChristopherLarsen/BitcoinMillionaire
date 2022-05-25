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
    
    init(withPresenter millionairePresenter: MillionairePresenterProtocol = MillionairePresenter() ) {
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
        
        millionairePresenter.checkIfUserIsBitcoinMillionaire()
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
        
        let containerFrame: CGRect = UIScreen.main.bounds.inset(by: UIEdgeInsets(top: 120.0, left: 40.0, bottom: 40.0, right: 40.0))
        containerView = UIView(frame: containerFrame)
        containerView.accessibilityIdentifier = "containerView"
        containerView.backgroundColor = .lightGray
        view.addSubview(containerView)
        
        let labelResult = UILabel()
        labelResult.accessibilityIdentifier = "labelResult"
        labelResult.textAlignment = .center
        labelResult.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        labelResult.adjustsFontForContentSizeCategory = true
        labelResult.translatesAutoresizingMaskIntoConstraints = false
        labelResult.backgroundColor = .brown
        containerView.addSubview(labelResult)

        let topConstaint = NSLayoutConstraint(item: labelResult, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leftConstaint = NSLayoutConstraint(item: labelResult, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let rightConstaint = NSLayoutConstraint(item: labelResult, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0.0)
        containerView.addConstraints([topConstaint, leftConstaint, rightConstaint])

        let heightConstaint = NSLayoutConstraint(item: labelResult, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,  multiplier: 1.0, constant: 80.0)
        labelResult.addConstraint(heightConstaint)

        self.labelResult = labelResult
        
//        NSLayoutConstraint.activate([
//            labelResult.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0),
//            labelResult.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0.0),
//            labelResult.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0.0),
//            labelResult.heightAnchor.constraint(equalToConstant: 40)
//        ])

//        imageView = UIImageView(image: UIImage(systemName: "hands.wave") )
//        imageView.backgroundColor = .orange
//        containerView.addSubview(imageView)
//
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: labelResult.bottomAnchor, constant: 0.0),
//            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0.0),
//            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0.0)
//        ])

//        guard let imageView: UIImageView = imageView else {
//            return
//        }
        
//        let proportionalWidthConstraint = NSLayoutConstraint(item: imageView,
//                                                             attribute: .width,
//                                                             relatedBy: .equal,
//                                                             toItem: imageView,
//                                                             attribute: .height,
//                                                             multiplier: 1.0,
//                                                             constant: 1.0)
//
//        imageView.addConstraint(proportionalWidthConstraint)
    
//        labelCheer = UILabel()
//        labelCheer.accessibilityIdentifier = "labelCheer"
//        labelCheer.textAlignment = .center
//        labelCheer.font = UIFont.preferredFont(forTextStyle: .title3)
//        labelCheer.adjustsFontForContentSizeCategory = true
//        labelCheer.translatesAutoresizingMaskIntoConstraints = false
//        labelCheer.backgroundColor = .blue
//        containerView.addSubview(labelCheer)
//
//        NSLayoutConstraint.activate([
//            labelCheer.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0.0),
//            labelCheer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0.0),
//            labelCheer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0.0),
//            labelCheer.heightAnchor.constraint(equalToConstant: 40)
//        ])
//
//        buttonDone = ButtonUtility.createButton(title: "")
//        containerView.addSubview(buttonDone)
//
//        NSLayoutConstraint.activate([
//            buttonDone.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0.0),
//            buttonDone.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0.0),
//            buttonDone.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0.0),
//            buttonDone.heightAnchor.constraint(equalToConstant: 40)
//        ])

        view.setNeedsLayout()
    }
    
    func setupBindings() {
        // TODO: setupBindings
    }
    
}

// MARK: - Private - Update

private extension MillionaireViewController {
    
    func updateView(isMillionaire: Bool) {
        
        if isMillionaire {
            labelResult.text = "YES!"
            imageView.image = UIImage(systemName: "hands.thumbsup")
            labelCheer.text = "You're a Bitcoin Millionaire!"
        } else {
            labelResult.text = "NO"
            imageView.image = UIImage(systemName: "hands.thumbsdown")
            labelCheer.text = "Keep buying bitcoin, you're on your way!"
        }
        
    }
    
}
