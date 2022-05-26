//
//  RemoveBitcoinViewController.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation
import SwiftUI
import Combine

class RemoveBitcoinViewController : UIViewController {
    var cancellables : Set<AnyCancellable> = []
    var textFieldText : CurrentValueSubject<String, Never> = .init("")
    var presenter : RemoveBitcoinPresenterProtocol
    
    init(presenter : RemoveBitcoinPresenterProtocol = RemoveBitcoinPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        configureView()
    }
    
    // MARK: - deinit
    
    deinit {
        print("deinit RemoveBitcoinViewController")
    }

}

//MARK:Setup Actions
extension RemoveBitcoinViewController {
    
    @objc func removeBitcoin() {
        print("Remove Bitcoin")
    }
    
}


//MARK: CreateView
extension RemoveBitcoinViewController {
    
    func configureView() {
        self.view = contentStackView
    }
    
    var contentStackView : UIStackView {
        let spacing: CGFloat = 30.0
        let backgroundColor  = UIColor.white
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            bitcoinImageBanner,
            removeBitcoinSection,
            spacer
        ])
        stackView.backgroundColor = backgroundColor
        stackView.spacing = spacing
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }
    
    var titleLabel : UILabel {
        let titleSize: CGFloat = 30.0
        let returnValue = UILabel(frame: .zero)
        returnValue.text = "Remove Bitcoin"
        returnValue.font = UIFont.boldSystemFont(ofSize: titleSize)
        returnValue.textAlignment = .center
        return returnValue
    }
    
    var bitcoinImageBanner : UIStackView {
        let spacing: CGFloat = 10.0
        let returnValue = UIStackView(arrangedSubviews: [
            walletImage,
            arrowImage,
            bitcoinLogoImage
        ])
        returnValue.spacing = spacing
        returnValue.axis = .horizontal
        returnValue.alignment = .center
        returnValue.distribution = .equalSpacing
        return returnValue
    }
    
    var bitcoinLogoImage : UIImageView {
        let iconSize : CGFloat = 80.0
        let color  : UIColor = .orange
        let bitcoinImage = UIImage(systemName: "bitcoinsign.circle.fill")
        let returnValue = UIImageView(image: bitcoinImage)
        returnValue.tintColor = color
        returnValue.contentMode = .scaleAspectFit
        returnValue.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        returnValue.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        return returnValue
    }
    
    
    var arrowImage : UIImageView {
        let iconSize : CGFloat = 40.0

        let color  : UIColor = .black
        let bitcoinImage = UIImage(systemName: "arrow.right")
        let returnValue = UIImageView(image: bitcoinImage)
        returnValue.tintColor = color
        returnValue.contentMode = .scaleAspectFit
        returnValue.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        returnValue.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        return returnValue
    }
    
    var walletImage : UIImageView {
        let iconSize : CGFloat = 60.0
        let color  : UIColor = .brown
        let bitcoinImage = UIImage( named: "Wallet")?.withRenderingMode(.alwaysTemplate)
        let returnValue = UIImageView(image: bitcoinImage)
        
        returnValue.tintColor = color
        returnValue.contentMode = .scaleAspectFit
        returnValue.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        returnValue.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        return returnValue
    }
    
    
    var removeBitcoinSection : UIStackView {
        let spacing: CGFloat = 10.0
        let returnValue = UIStackView(arrangedSubviews: [
            enterAmountLabel,
            amountTextField,
            removeButton
        ])
        returnValue.spacing = spacing
        returnValue.axis = .vertical
        returnValue.alignment = .center
        returnValue.distribution = .equalSpacing
        return returnValue
    }
    
    var enterAmountLabel : UILabel {
        let titleSize: CGFloat = 16.0
        let returnValue = UILabel(frame: .zero)
        returnValue.text = "Enter the amount of Bitcoin\nto remove to your Wallet"
        returnValue.numberOfLines = .zero
        returnValue.font = UIFont.systemFont(ofSize: titleSize)
        returnValue.textAlignment = .center
        return returnValue
    }
    
    var amountTextField : BorderedTextField {
        let height: CGFloat = 40.0
        let width: CGFloat = 300.0
        let borderWidth: CGFloat = 2.0
        let returnValue = BorderedTextField()
        //constraints
        returnValue.heightAnchor.constraint(equalToConstant: height).isActive = true
        returnValue.widthAnchor.constraint(equalToConstant: width).isActive = true
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: returnValue)
            .receive(on: RunLoop.main)
            .map({ $0.object as! UITextField})
            .sink { textField in
                self.textFieldText.send(textField.text ?? "")
            }
            .store(in: &cancellables)
        
        //border
        returnValue.layer.borderColor = UIColor.black.cgColor
        returnValue.layer.borderWidth = borderWidth
        
        return returnValue
    }
    
    
    var removeButton : UIButton {
        
        let height: CGFloat = 40.0
        let width: CGFloat = 300.0
        let borderWidth: CGFloat = 2.0
        let foregroundColor = UIColor.white
        let foregroundColorDisabled = UIColor(white: 0.9, alpha: 1.0)
        let backgroundColor = UIColor(named: "RemoveBitcoinRemoveButtonBackground")
        
        let returnValue = UIButton(type: .custom)
        returnValue.setTitle("Remove", for: .normal)
        
        //constraints
        returnValue.heightAnchor.constraint(equalToConstant: height).isActive = true
        returnValue.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        
        //style
        returnValue.setTitleColor(foregroundColor, for: .normal)
        returnValue.setTitleColor(foregroundColorDisabled, for: .disabled)
        returnValue.backgroundColor = backgroundColor
        
        //border
        
        returnValue.layer.borderColor = UIColor.black.cgColor
        returnValue.layer.borderWidth = borderWidth
        
        //set action
        returnValue.removeTarget(self, action: #selector(self.removeBitcoin), for: .touchUpInside)
        self.textFieldText.sink { text in
            var isEnabled : Bool = false
            if let floatValue = Float(text), floatValue > 0 {
                isEnabled = true
            }
            returnValue.isEnabled = isEnabled
        }
        .store(in: &cancellables)
        
        return returnValue
    }
    
    var spacer : UIView {
        return UIView()
    }
     
}
 


struct RemoveBitcoinView : UIViewControllerRepresentable {
    typealias UIViewControllerType = RemoveBitcoinViewController
    func makeUIViewController(context: Context) -> RemoveBitcoinViewController {
        return RemoveBitcoinViewController()
    }
    func updateUIViewController(_ uiViewController: RemoveBitcoinViewController, context: Context) { }
}


struct RemoveBitcoinViewController_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            RemoveBitcoinView()
        }
    }
}

