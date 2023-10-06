//
//  AppDelegate.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/3.
//

import UIKit
import CoreTelephony
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        switch CTCellularData().cellularDataRestrictionDidUpdateNotifier {
//            case .notRestricted:
//            //无限制(允许无线局域网与蜂窝数据时)
//            case .restricted:
//            //受限的(仅允许无线局域网时、权限关闭时)
//            case .restrictedStateUnknown:
//            //受限状态未知的
//        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

