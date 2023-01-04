//
//  AuthViewController.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 16.12.2022.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    public var completion: ((Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self // to detect once page redirects to url etc.
        view.addSubview(webView)
        
        guard let url = AuthManager.shared.signInURL else {
            return
        }
        webView.load(URLRequest(url: url))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    // Tells the delegate that navigation from the main frame has started
    // The web view calls this method after it receives provisional approval to process a navigation request, but before it receives a response to that request.
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        // if url has a parameter for code we want it out
        // Exchange the code that spotify gives us after the user gives us permission for access token
        let components = URLComponents(string: url.absoluteString)
        guard let code = components?.queryItems?.first(where: { $0.name == "code" })?.value else {
            return
        }
        webView.isHidden = true
        
        print("Code: \(code)")
        AuthManager.shared.exchangeCodeForAccessToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completion?(success)
            }
        }
    }
}
