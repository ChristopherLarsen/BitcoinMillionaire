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
//        setUpUserInterface()
//        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Bitcoin Millionaire"
        view.backgroundColor = .systemBackground
    }
    
}
