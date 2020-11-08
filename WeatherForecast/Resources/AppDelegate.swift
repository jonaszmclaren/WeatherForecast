//
//  AppDelegate.swift
//  WeatherForecast
//
//  Created by Jonasz Baron on 04/11/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    var rootRouter: RootRouter?
    var window: UIWindow?

    // MARK: - Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootVC = WFNavigationController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()

        rootRouter = RootRouter(rootViewController: rootVC)
        rootRouter?.start()

        return true
    }
}
