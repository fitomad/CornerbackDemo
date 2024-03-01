//
//  ViewController+WebView.swift
//  CornerbackDemo
//
//  Created by Adolfo Vera Blasco on 1/3/24.
//

import Foundation
import WebKit

import Cornerback

extension ViewController: WKNavigationDelegate {
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
		switch navigationState {
			case .applyingConstraints:
				applyConstrains(to: navigationAction.request)
				navigationState.toogle()
		
				return .cancel
			case .ready:
				navigationState.toogle()
				
				return .allow
		}
	}
	
	private func applyConstrains(to request: URLRequest) {
		var ruledRequest = request
		Cornerback.shared.applyRulesFor(request: &ruledRequest)
		webView.load(ruledRequest)
	}
}

extension ViewController {
	enum NavigationState {
		case applyingConstraints
		case ready
		
		mutating func toogle() {
			switch self {
				case .applyingConstraints:
					self = .ready
				case .ready:
					self = .applyingConstraints
			}
		}
	}
}
