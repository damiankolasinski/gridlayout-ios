//
//  AppDelegate.swift
//  GridLayoutExample
//
//  Created by Damian Kolasiński on 22/02/2020.
//  Copyright © 2020 Damian Kolasiński. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindowAndInitialController()
        return true
    }
    
    private func setupWindowAndInitialController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = buildCategoriesController()
        window!.makeKeyAndVisible()
    }
    
    private func buildCategoriesController() -> UIViewController {
        let interactor = CategoriesInteractor()
        let controller = CategoriesViewController(
            interactor: interactor
        )
        return controller
    }
}
