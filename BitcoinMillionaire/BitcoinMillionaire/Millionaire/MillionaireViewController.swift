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
    
    var millionairePresenter: MillionairePresenterProtocol
    
    var isBitcoinMillionaire: PassthroughSubject<Bool, Never> = PassthroughSubject()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(withPresenter millionairePresenter: MillionairePresenterProtocol = MillionairePresenter() ) {
        self.millionairePresenter = millionairePresenter
        super.init(nibName: nil, bundle: nil)
        
        self.millionairePresenter.millionaireViewController = self
        
        self.isBitcoinMillionaire.sink { completion in
            // Completion
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
        
        let containerFrame: CGRect = UIScreen.main.bounds.inset(by: UIEdgeInsets(top: 150.0, left: 40.0, bottom: 40.0, right: 40.0))
        containerView = UIView(frame: containerFrame)
        containerView.accessibilityIdentifier = "containerView"
        view.addSubview(containerView)
        
        let labelResult = UILabel()
        labelResult.accessibilityIdentifier = "labelResult"
        labelResult.textAlignment = .center
        labelResult.font = UIFont.preferredFont(forTextStyle: .title1)
        labelResult.adjustsFontForContentSizeCategory = true
        labelResult.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelResult)

        let topConstraintResult = NSLayoutConstraint(item: labelResult, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leftConstraintResult = NSLayoutConstraint(item: labelResult, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let rightConstraintResult = NSLayoutConstraint(item: labelResult, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0.0)
        containerView.addConstraints([topConstraintResult, leftConstraintResult, rightConstraintResult])

        let heightConstraintResult = NSLayoutConstraint(item: labelResult, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,  multiplier: 1.0, constant: 80.0)
        labelResult.addConstraint(heightConstraintResult)

        self.labelResult = labelResult
        
        let imageView = UIImageView(image: UIImage(systemName: "hands.wave") )
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)

        let topConstaintImageView = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: labelResult, attribute: .bottom, multiplier: 1.0, constant: 10.0)
        let leftConstaintImageView = NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 10.0)
        let rightConstaintImageView = NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 10.0)
        containerView.addConstraints([topConstaintImageView, leftConstaintImageView, rightConstaintImageView])

        let heightConstraintImageView = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width,  multiplier: 1.0, constant: 1.0)
        imageView.addConstraint(heightConstraintImageView)
        self.imageView = imageView
        
        let labelCheer = UILabel()
        labelCheer.accessibilityIdentifier = "labelCheer"
        labelCheer.textAlignment = .center
        labelCheer.font = UIFont.preferredFont(forTextStyle: .title3)
        labelCheer.adjustsFontForContentSizeCategory = true
        labelCheer.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelCheer)

        let topConstraintCheer = NSLayoutConstraint(item: labelCheer, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leftConstraintCheer = NSLayoutConstraint(item: labelCheer, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let rightConstraintCheer = NSLayoutConstraint(item: labelCheer, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0.0)
        containerView.addConstraints([topConstraintCheer, leftConstraintCheer, rightConstraintCheer])

        let heightConstraintCheer = NSLayoutConstraint(item: labelCheer, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,  multiplier: 1.0, constant: 80.0)
        labelCheer.addConstraint(heightConstraintCheer)
        
        self.labelCheer = labelCheer
        
        view.setNeedsLayout()
    }
    
}

// MARK: - Private - Update

private extension MillionaireViewController {
    
    func updateView(isMillionaire: Bool) {
        
        if isMillionaire {
            labelResult.text = "YES!"
            let symbolConfig = UIImage.SymbolConfiguration(hierarchicalColor: UIColor.black)
            let symbol = UIImage(systemName: "hand.thumbsup", withConfiguration: symbolConfig)
            imageView.image = symbol
            labelCheer.text = "You're a Bitcoin Millionaire!"
        } else {
            labelResult.text = "NO"
            let symbolConfig = UIImage.SymbolConfiguration(hierarchicalColor: UIColor.black)
            let symbol = UIImage(systemName: "hand.thumbsdown", withConfiguration: symbolConfig)
            imageView.image = symbol
            labelCheer.text = "But you're on your way!"
        }
        
    }
    
}
