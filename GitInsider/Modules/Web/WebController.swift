//
//  WebController.swift
//  GitInsider
//
//  Created by Alphan Ogün on 23.11.2023.
//

import UIKit
import WebKit

class WebController: UIViewController {
    //MARK: - Properties
    
    var viewModel: WebViewModel
    
    let url: URL
    
    private lazy var webView: WKWebView = {
        let webview = WKWebView(frame: view.bounds)
        webview.navigationDelegate = self
        return webview
    }()
    
    //MARK: - Lifecycle
    
    init(url: URL, viewModel: WebViewModel = WebViewModel()) {
        self.url = url
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("DEBUG: \(self) deinitialized.")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }
}

extension WebController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        if let url = navigationAction.request.url, url.absoluteString.contains(gitHubRedirectUri) {
            viewModel.handleCallback(fromUrl: url)
        }
        return .allow
    }
}
