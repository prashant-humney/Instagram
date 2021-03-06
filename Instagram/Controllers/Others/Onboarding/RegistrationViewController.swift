//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Prashant Humney on 06/03/21.
//  Copyright © 2021 Prashant Humney. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

  struct Constants {
    static let cornerRadius: CGFloat = 8.0
  }
  
  private let usernameTextField: UITextField = {
    let field = UITextField()
    field.placeholder = "Username.."
    field.returnKeyType = .next
    field.leftViewMode = .always
    field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    field.layer.masksToBounds = true
    field.layer.cornerRadius = Constants.cornerRadius
    field.backgroundColor = UIColor.secondarySystemBackground
    field.layer.borderWidth = 1.0
    field.layer.borderColor = UIColor.secondaryLabel.cgColor
    return field
  }()
  
  private let emailTextField: UITextField = {
    let field = UITextField()
    field.placeholder = "Email Address.."
    field.returnKeyType = .next
    field.leftViewMode = .always
    field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    field.layer.masksToBounds = true
    field.layer.cornerRadius = Constants.cornerRadius
    field.backgroundColor = UIColor.secondarySystemBackground
    field.layer.borderWidth = 1.0
    field.layer.borderColor = UIColor.secondaryLabel.cgColor
    return field
  }()
  
  private let passwordTextField: UITextField = {
    let field = UITextField()
    field.placeholder = "Password..."
    field.isSecureTextEntry = true
    field.returnKeyType = .continue
    field.leftViewMode = .always
    field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    field.layer.masksToBounds = true
    field.layer.cornerRadius = Constants.cornerRadius
    field.backgroundColor = UIColor.secondarySystemBackground
    field.layer.borderWidth = 1.0
    field.layer.borderColor = UIColor.secondaryLabel.cgColor
    return field
  }()
  
  private let registerButton: UIButton = {
    let button = UIButton()
    button.setTitle("Sign Up", for: .normal)
    button.layer.masksToBounds = true
    button.layer.cornerRadius = Constants.cornerRadius
    button.backgroundColor = .systemGreen
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    view.addSubview(usernameTextField)
    view.addSubview(emailTextField)
    view.addSubview(passwordTextField)
    view.addSubview(registerButton)
    emailTextField.delegate = self
    usernameTextField.delegate = self
    passwordTextField.delegate = self
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    usernameTextField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 100, width: view.width - 40, height: 52)
    emailTextField.frame = CGRect(x: 20, y: usernameTextField.bottom + 10, width: view.width - 40, height: 52)
    passwordTextField.frame = CGRect(x: 20, y: emailTextField.bottom + 10, width: view.width - 40, height: 52)
    registerButton.frame = CGRect(x: 20, y: passwordTextField.bottom + 10, width: view.width - 40, height: 52)
  }
  
  @objc private func didTapRegister() {
    emailTextField.resignFirstResponder()
    usernameTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
    
    guard let email = emailTextField.text, !email.isEmpty, let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty  else { return }
    
    AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registered in
      DispatchQueue.main.async {
        if registered {
          
        } else {
          
        }
      }
    }
  }
}

extension RegistrationViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == usernameTextField {
      emailTextField.becomeFirstResponder()
    } else if textField == emailTextField {
      passwordTextField.becomeFirstResponder()
    } else {
      didTapRegister()
    }
    return true
  }
}
