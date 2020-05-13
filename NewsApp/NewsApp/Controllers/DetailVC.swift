//
//  DetailVC.swift
//  NewsApp
//
//  Created by Mondale on 5/13/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import UIKit
import WebKit

class DetailVC: UIViewController {
    
    var url:String? = nil
    var webView = WKWebView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureWebView()
        getWebPage(url: url!)
        
    }
    
    private func configureWebView(){
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }

    
    private func getWebPage(url:String){
        var comps = URLComponents(string: url)!
        comps.scheme = "https"
        let https = comps.string!
        print(https)
        let toURL = URL(string: https)
        let request = URLRequest(url: toURL!)
        webView.load(request)
        
    }
}
