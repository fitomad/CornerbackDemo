//
//  ViewController.swift
//  CornerbackDemo
//
//  Created by Adolfo Vera Blasco on 1/3/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {
	@IBOutlet unowned var performRequestButton: UIButton!
	@IBOutlet unowned var performNavigationButton: UIButton!
	@IBOutlet unowned var webView: WKWebView!
	
	var navigationState = NavigationState.applyingConstraints
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		webView.navigationDelegate = self
	}
}

// MARK: - Actions

extension ViewController {
	@IBAction func handlePerformRequestButtonTap() {
		guard let resourceURL = URL(string: Constants.resourceURI) else {
			print("🚨 Malformed URL buddy...")
			return
		}
		
		Task {
			do {
				let (data, _) = try await URLSession.shared.data(from: resourceURL)
				
				if let content = String(data: data, encoding: .utf8) {
					print(content)
				}
			} catch {
				print("🚨 Check server status dude...")
			}
		}
	}
	
	@IBAction func handlePerformNavigationButtonTap() {
		guard let domainURL = URL(string: Constants.domainURI) else {
			print("🚨 Malformed URL buddy...")
			return
		}
		
		let domainRequest = URLRequest(url: domainURL)
		webView.load(domainRequest)
	}
}

extension ViewController {
	enum Constants {
		static let resourceURI = "http://localhost:3000/cornerback"
		static let domainURI = "http://localhost:3000"
	}
}

