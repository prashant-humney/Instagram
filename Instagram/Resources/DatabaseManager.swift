//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Prashant Humney on 06/03/21.
//  Copyright © 2021 Prashant Humney. All rights reserved.
//

import FirebaseDatabase

public class DatabaseManager {
  static let shared = DatabaseManager()
  private let database = Database.database().reference()
  
  public func canCreateUser(email: String, username: String, password: String, completion: @escaping (Bool) -> Void) {
    completion(true)
  }
  
  public func insertNewUser(email: String, username: String, completion: @escaping (Bool) -> Void) {
    database.child(email.safeDatabaseKeys()).setValue(["username": username]) { error,_ in
      if error == nil {
        completion(true)
      } else {
        completion(false) 
      }
    }
  }
}
