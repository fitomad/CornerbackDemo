//
//  AppDelegate.swift
//  CornerbackDemo
//
//  Created by Adolfo Vera Blasco on 1/3/24.
//

import UIKit
import Cornerback

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		applyRequestConstraints()
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

// MARK: - Cornerback

extension AppDelegate {
	private var resourceConstraints: [Constraint] {
		[
			Domain(named: "localhost"),
			Resource(path: "/cornerback")
		]
	}
	
	private var domainConstrains: [Constraint] {
		[
			Domain(named: "localhost")
		]
	}
	
	func applyRequestConstraints() {
		let cornerback = Cornerback.shared
		
		cornerback.newRuleWith(constraints: resourceConstraints) { urlRequest in
			print("🏈 \(urlRequest)")
			urlRequest.setValue("Cornerback v1.0.3", forHTTPHeaderField: "X-Globant")
		}

		cornerback.newRuleWith(constraints: domainConstrains) { urlRequest in
			print("🏠 \(urlRequest)")
			urlRequest.setValue("UK OneApp", forHTTPHeaderField: "X-Secret-Project")
		}
	}
}

