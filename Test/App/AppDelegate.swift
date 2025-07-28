//
//  AppDelegate.swift
//  Test
//
//  Created by Shakhzod Azamatjonov on 28/07/25.
//

import UIKit
import YandexMapsMobile

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize Yandex Maps with API key
        if let apiKey = Bundle.main.object(forInfoDictionaryKey: "YandexMapsAPIKey") as? String {
            YMKMapKit.setApiKey(apiKey)
        } else {
            // For development purposes, you can use a placeholder key
            // Replace this with your actual Yandex Maps API key
            YMKMapKit.setApiKey("522fb9ba-acc3-4c2a-ad64-371448cace44")
        }
        
        // Configure UI Appearance
        configureAppearance()
        
        return true
    }
    
    // MARK: - UI Configuration
    private func configureAppearance() {
        // Configure Navigation Bar appearance with corner radius
        configureNavigationBarAppearance()
        
        // Configure Tab Bar appearance with corner radius
        configureTabBarAppearance()
    }
    
    private func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = .clear
        
        // Apply to all navigation bars
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        // Configure to extend under safe area
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().clipsToBounds = true
        
        // Ensure navigation bar extends under status bar
        UINavigationBar.appearance().prefersLargeTitles = false
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = .clear
        
        // Apply to all tab bars
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        // Configure corner radius using layer properties
        UITabBar.appearance().clipsToBounds = true
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
