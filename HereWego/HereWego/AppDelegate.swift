//
//  AppDelegate.swift
//  GoogleSignInWithoutFirebase
//
//  Created by Kyungsoo Lee on 2023/01/12.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      var handled = GIDSignIn.sharedInstance.handle(url) // Bool type
      if handled {
        return true
      }
      // Handle other custom URL types.

      // If not handled by this app, return false.
        
      return false
    }
    
}


