//
//  AddBitcoinViewController.swift
//  BitcoinMillionaire
//
//  Created by Karan Bhasin on 18/05/22.
//

import Foundation
import SwiftUI
import Combine

class AddBitcoinViewController : UIViewController {
    var cancellables : Set<AnyCancellable> = []
    var textFieldText : CurrentValueSubject<String, Never> = .init("")
    
    override func loadView() {
        configureView()
    }
    
}

//MARK:Setup Actions
extension AddBitcoinViewController {
    
    @objc func addBitcoin() {
        print("Add Bitcoin")
    }
    
}


//MARK: CreateView
extension AddBitcoinViewController {
    
    func configureView() {
        self.view = contentStackView
    }
    
    var contentStackView : UIStackView {
        let spacing: CGFloat = 30.0
        let backgroundColor  = UIColor.white
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            bitcoinImageBanner,
            addBitcoinSection,
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
        returnValue.text = "Add Bitcoin"
        returnValue.font = UIFont.boldSystemFont(ofSize: titleSize)
        returnValue.textAlignment = .center
        return returnValue
    }
    
    var bitcoinImageBanner : UIStackView {
        let spacing: CGFloat = 10.0
        let returnValue = UIStackView(arrangedSubviews: [
            bitcoinLogoImage,
            arrowImage,
            walletImage
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
    
    
    var addBitcoinSection : UIStackView {
        let spacing: CGFloat = 10.0
        let returnValue = UIStackView(arrangedSubviews: [
            enterAmountLabel,
            amountTextField,
            addButton
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
        returnValue.text = "Enter the amount of Bitcoin\nto add to your Wallet"
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
    
    var addButton : UIButton {
        
        let height: CGFloat = 40.0
        let width: CGFloat = 300.0
        let borderWidth: CGFloat = 2.0
        let foregroundColor = UIColor.white
        let foregroundColorDisabled = UIColor(white: 0.9, alpha: 1.0)
        let backgroundColor = UIColor(named: "AddBitcoinAddButtonBackground")
        
        let returnValue = UIButton(type: .custom)
        returnValue.setTitle("Add", for: .normal)
        
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
        returnValue.addTarget(self, action: #selector(self.addBitcoin), for: .touchUpInside)
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
 


struct AddBitcoinView : UIViewControllerRepresentable {
    typealias UIViewControllerType = AddBitcoinViewController
    func makeUIViewController(context: Context) -> AddBitcoinViewController {
        return AddBitcoinViewController()
    }
    func updateUIViewController(_ uiViewController: AddBitcoinViewController, context: Context) { }
}


struct AddBitcoinViewController_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            AddBitcoinView()
        }
    }
}

