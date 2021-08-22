//
//  AuthViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 17.08.2021.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView! {
        
        // WKWebView принимает navigationDelegate
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // вызываем метод oauthAuthorizationToVK
        authorizetionToVK()
    }
    
    func authorizetionToVK() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7822904"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"), // права
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"), // дает возможность всегда подтверждать что мы заходим на страницу
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }
    
    //MARK: - WKNavigationDelegate
    
    // метод которы перехватывает ответы от webView
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        if  let token = params["access_token"], let userId = params["user_id"] {
            print("TOKEN = ", token as Any)
            
            // положили token в Session
            Session.shared.token = token
            Session.shared.userId = userId
            
            showMainTabBar()
        }
        
        decisionHandler(.cancel)
    }
    
    func showMainTabBar() {
        
        performSegue(withIdentifier: "showFriendsSegue", sender: nil)
    }
    
}

extension AuthViewController: WKNavigationDelegate {
    
}
