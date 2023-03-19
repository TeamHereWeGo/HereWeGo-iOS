//
//  HereWeGoApp.swift
//  HereWeGo
//
//  Created by Kyungsoo Lee on 2022/11/08.
//

import SwiftUI

@main
struct HereWeGoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            LoginButton(provider: "google")
//            LoginView()
        }
    }
}
