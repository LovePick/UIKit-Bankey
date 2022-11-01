//
//  LoginView.swift
//  Bankey
//
//  Created by Supapon Pucknavin on 1/11/2565 BE.
//

import Foundation
import UIKit


class LoginView: UIView {
    
    
    // MARK: - VIEW
    let vStackView = UIStackView()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let dividerView = UIView()
    
    
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - FUNCTION
extension LoginView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 8
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.placeholder = "Username"
        usernameTextField.delegate = self
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        
    
        
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
    }
    func layout() {
        
        vStackView.addArrangedSubview(usernameTextField)
        vStackView.addArrangedSubview(dividerView)
        vStackView.addArrangedSubview(passwordTextField)
        self.addSubview(vStackView)
   
        
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            vStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: vStackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: vStackView.bottomAnchor, multiplier: 1)
        ])
        
        
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
}

// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
}
