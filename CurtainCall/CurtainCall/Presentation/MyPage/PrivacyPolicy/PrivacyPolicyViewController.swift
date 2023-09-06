//
//  PrivacyPolicyViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/26.
//

import UIKit
import WebKit

final class PrivacyPolicyViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let webView = WKWebView()
    
    // MARK: - Lifecycles
    
    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let url = URL(string: "https://ssarivibebe.github.io/curtaincall/%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4%EC%B2%98%EB%A6%AC%EB%B0%A9%EC%B9%A801.html") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        configureBackbarButton(.pop)
        title = "개인정보 처리방침"
    }

}
