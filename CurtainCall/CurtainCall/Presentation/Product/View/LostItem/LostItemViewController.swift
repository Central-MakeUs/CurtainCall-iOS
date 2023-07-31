//
//  LostItemViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/31.
//

import UIKit

final class LostItemViewController: UIViewController {
    
    // MARK: - UI properties
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
    }
    
    private func configureConstraints() {
        
    }
    
    private func configureNavigation() {
        title = "분실물 찾기"
        let searchBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: nil
        )
        searchBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = searchBarButtonItem
        configureBackbarButton()
    }
    
}
