//
//  AuthManager.swift
//  Instagram
//
//  Created by Prashant Humney on 06/03/21.
//  Copyright © 2021 Prashant Humney. All rights reserved.
//

import  FirebaseAuth
import Foundation

public class AuthManager {
  static let shared = AuthManager()
  
  public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
    DatabaseManager.shared.canCreateUser(email: email, username: username, password: password) { canCreate in
      if canCreate {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          guard authResult != nil, error == nil else {
            completion(false)
            return
          }
          DatabaseManager.shared.insertNewUser(email: email, username: username) { inserted in
            if inserted {
              completion(true)
            } else {
              completion(false)
            }
          }
        }
      } else {
        completion(false)
      }
    }
  }
  
  public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
    if let email = email {
      Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        guard authResult != nil, error == nil else {
          completion(false)
          return
        }
        completion(true)
      }
    }
    else if let user = username {
      print("Sign In with user..!!! \(user)")
    }
  }
  
  public func logOut(completion: (Bool) -> Void) {
    do {
      try Auth.auth().signOut()
      completion(true)
    } catch {
      completion(false)
      print("error")
    }
  }
}
