//
//  PartyMemberDetailViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/10.
//

import UIKit

final class PartyMemberDetailViewController: UIViewController {
    
    // MARK: - UI properties
    
    // MARK: - Properties
    
    private let type: PartyType
    
    // MARK: - Lifecycles
    
    init(type: PartyType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        view.backgroundColor = UIColor(rgb: 0xF5F6F8)
    }
    
    private func configureConstraints() {
        
    }
    
    private func configureNavigation() {
        title = type.title
        let leftBarbuttonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backBarbuttonTapped)
        )
        let searchBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: nil
        )
        leftBarbuttonItem.tintColor = .black
        searchBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarbuttonItem
        navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
    // MARK: - Actions
    
    @objc
    private func backBarbuttonTapped() {
        dismiss(animated: true)
    }
}
