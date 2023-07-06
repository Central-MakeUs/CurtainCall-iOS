//
//  TermsOfServiceViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/05.
//

import UIKit

final class TermsOfServiceViewController: UIViewController {
    
    // MARK: - UI properties
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "약관 동의"
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        
    }
    
    private func configureConstraints() {
        
    }
    
}
