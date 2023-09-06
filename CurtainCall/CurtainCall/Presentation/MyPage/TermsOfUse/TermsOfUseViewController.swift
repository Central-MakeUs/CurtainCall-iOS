//
//  TermsOfUseViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/26.
//

import UIKit
import WebKit

final class TermsOfUseViewController: UIViewController {
    
    private let webView = WKWebView()
    
    // MARK: - Lifecycles
    
    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        if let url = URL(string: "https://ssarivibebe.github.io/curtaincall/%EC%84%9C%EB%B9%84%EC%8A%A4%20%EC%9D%B4%EC%9A%A9%EC%95%BD%EA%B4%8001.html") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        configureBackbarButton(.pop)
        title = "서비스 이용약관"
    }
    
}
