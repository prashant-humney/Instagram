//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Prashant Humney on 06/03/21.
//  Copyright © 2021 Prashant Humney. All rights reserved.
//

import UIKit

struct SettingCellModel {
  let title: String
  let handler: (() -> Void)
}

class SettingsViewController: UIViewController {

  struct Constants {
    static let cellId = "cell"
  }
  let tableView: UITableView = {
    let view = UITableView(frame: .zero, style: .grouped)
    view.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellId)
    return view
  }()
  
  private var data = [[SettingCellModel]]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureModels()
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
  
  private func configureModels() {
    let section = [SettingCellModel(title: "Log Out") { [weak self] in
      self?.didTapLogout()
      
      }]
    data.append(section)
  }
  
  private func didTapLogout() {
    AuthManager.shared.logOut { result in
      DispatchQueue.main.async {
        if result {
          let vc = LoginViewController()
          vc.modalPresentationStyle = .fullScreen
          present(vc, animated: true) {
            self.navigationController?.popToRootViewController(animated: false)
            self.tabBarController?.selectedIndex = 0
          }
        } else {
          
        }
      }
    }
  }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath)
    cell.textLabel?.text = data[indexPath.section][indexPath.row].title
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let model = data[indexPath.section][indexPath.row]
    model.handler()
  }
}
