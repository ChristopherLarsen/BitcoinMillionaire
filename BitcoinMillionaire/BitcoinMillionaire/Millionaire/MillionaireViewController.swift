//
//  MillionaireView.swift
//  BitcoinMillionaire
//
//  Created by Christopher Larsen on 2022-05-24.
//

import Foundation
import UIKit


// MARK: - MillionaireViewControllerProtocol

protocol MillionaireViewControllerProtocol {
    
}

// MARK: - MillionaireViewController

class MillionaireViewController : UIViewController, MillionaireViewControllerProtocol {
    
    var containerView: UIView!
    var labelResult: UILabel!
    var imageView: UIImageView!
    var labelCheer: UILabel!
    var buttonDone: UIButton!
    
    var millionairePresenter: MillionairePresenterProtocol
    
    init(withPresenter millionairePresenter: MillionairePresenterProtocol) {
        self.millionairePresenter = millionairePresenter
        super.init(nibName: nil, bundle: nil)
        self.millionairePresenter.millionaireViewController = self
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
        // TODO: 
    }
    
}
