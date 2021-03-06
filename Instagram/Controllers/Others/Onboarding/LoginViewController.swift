//
//  LoginViewController.swift
//  Instagram
//
//  Created by Prashant Humney on 06/03/21.
//  Copyright © 2021 Prashant Humney. All rights reserved.
//

import UIKit
import SafariServices
import FirebaseAuth

class LoginViewController: UIViewController {

  struct Constants {
    static let cornerRadius: CGFloat = 8.0
  }
  
  private let usernameTextField: UITextField = {
    let field = UITextField()
    field.placeholder = "Username or email..."
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
  
  private let loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("Log In", for: .normal)
    button.layer.masksToBounds = true
    button.layer.cornerRadius = Constants.cornerRadius
    button.backgroundColor = .systemBlue
    button.setTitleColor(.white, for: .normal)
    return button
  }()
  
  private let headerView: UIView = {
    let header = UIView()
    header.clipsToBounds = true
    let backgroundView = UIImageView.init(image: UIImage(named: "gradient"))
    header.addSubview(backgroundView)
    return header
  }()
  
  private let termsButton: UIButton = {
    let button = UIButton()
    button.setTitle("Terms and Services", for: .normal)
    button.setTitleColor(UIColor.secondaryLabel, for: .normal)
    return button
  }()
  
  private let privacyButton: UIButton = {
    let button = UIButton()
    button.setTitle("Privacy Policy", for: .normal)
    button.setTitleColor(UIColor.secondaryLabel, for: .normal)
    return button
  }()
  
  private let createAccountButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.label, for: .normal)
    button.setTitle("New User? Create an account", for: .normal)
    return button
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    addSubviews()
    usernameTextField.delegate = self
    passwordTextField.delegate = self
    loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    createAccountButton.addTarget(self, action: #selector(didTapAccountButton), for: .touchUpInside)
    termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
    privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    headerView.frame = CGRect(x: 0,
                              y: 0,
                              width: view.width,
                              height: view.height/3.0)
    configureHeaderView()
    
    usernameTextField.frame = CGRect(x: 25.0,
                                     y: headerView.bottom + 40,
                                     width: view.width - 50.0,
                                     height: 52.0)
    
    passwordTextField.frame = CGRect(x: 25.0,
                                     y: usernameTextField.bottom + 10,
                                     width: view.width - 50.0,
                                     height: 52.0)
    
    loginButton.frame = CGRect(x: 25.0,
                               y: passwordTextField.bottom + 10,
                               width: view.width - 50.0,
                               height: 52.0)
    
    createAccountButton.frame = CGRect(x: 25.0,
                                       y: loginButton.bottom + 10,
                                       width: view.width - 50.0,
                                       height: 52.0)
    
    termsButton.frame = CGRect(x: 10.0,
                               y: view.height - view.safeAreaInsets.bottom - 100,
                               width: view.width - 20.0,
                               height: 50.0)
    
    privacyButton.frame = CGRect(x: 10.0,
    y: view.height - view.safeAreaInsets.bottom - 50,
    width: view.width - 20.0,
    height: 50.0)
  }
  
  private func configureHeaderView() {
    guard headerView.subviews.count == 1 else { return }
    
    guard let backgroundView = headerView.subviews.first else { return }
    backgroundView.frame = headerView.bounds
    
    let imageView = UIImageView(image: UIImage(named: "logoText"))
    headerView.addSubview(imageView)
    imageView.contentMode = .scaleAspectFit
    imageView.frame = CGRect(x: headerView.width/4, y: view.safeAreaInsets.top, width: headerView.width/2, height: headerView.height - view.safeAreaInsets.top)
  }
  
  // USE CMD + SHIFT + A to toggle between light and dark mode..!!
  private func addSubviews() {
    view.addSubview(usernameTextField)
    view.addSubview(passwordTextField)
    view.addSubview(loginButton)
    view.addSubview(termsButton)
    view.addSubview(privacyButton)
    view.addSubview(headerView)
    view.addSubview(createAccountButton)
  }
  
  @objc private func didTapLoginButton() {
    passwordTextField.resignFirstResponder()
    usernameTextField.resignFirstResponder()
    
    guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
    
    var user: String?
    var email: String?
    
    if username.contains("@"), username.contains(".") {
      email = username
    } else {
      user = username
    }
    
    AuthManager.shared.loginUser(username: user, email: email, password: password) { success in
      DispatchQueue.main.async {
        if success {
         //user successfully logged in
          self.dismiss(animated: true)
        } else {
          let alertVC = UIAlertController(title: "Log In Error", message: "We are unable to log in", preferredStyle: .alert)
          alertVC.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
          self.present(alertVC, animated: true)
        }
      }
    }
  }
  
  @objc private func didTapTermsButton() {
    guard let url = URL.init(string: "https://www.instagram.com/about/legal/terms/before-january-19-2013/") else {
      return
    }
    let vc = SFSafariViewController(url: url)
    present(vc, animated: true)
  }
  
  @objc private func didTapPrivacyButton() {
    guard let url = URL.init(string: "https://help.instagram.com/519522125107875") else {
      return
    }
    let vc = SFSafariViewController(url: url)
    present(vc, animated: false)
  }
  
  @objc private func didTapAccountButton() {
    let vc = RegistrationViewController()
    vc.title = "Create Account"
    present(UINavigationController(rootViewController: vc), animated: true)
  }
}

extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == usernameTextField {
      passwordTextField.becomeFirstResponder()
    } else if textField == passwordTextField {
      didTapLoginButton()
    }
    return true
  }
}
