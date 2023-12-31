//
//  TempMainTabBarController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit

import SnapKit
import SwiftKeychainWrapper

final class TempMainTabBarController: UIViewController {
    
    // MARK: - UI properties
    
    private let wholeView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        
        return view
    }()
    
    private let tabStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        
        stackView.layer.applySketchShadow(
            color: .black,
            alpha: 0.25,
            x: 0,
            y: 4,
            blur: 4,
            spread: 0
        )
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private let homeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarHomeDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.tabbarHomeSelected), for: .selected)
        button.imageView?.contentMode = .scaleAspectFill
        button.tag = 0
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private let emptyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarEmpty), for: .normal)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private let productButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarProductDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.tabbarProductSelected), for: .selected)
        button.tag = 1
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private let liveTalkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarLiveTalkSelected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.tabbarLiveTalkDeselected), for: .selected)
        button.tag = 2
        button.adjustsImageWhenHighlighted = false
        return button
    }()

    private let partyMemberButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarPartyMemberDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.tabbarPartyMemberSelected), for: .selected)
        button.tag = 3
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private let myPageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.tabbarMyPageDeselected), for: .normal)
        button.setImage(UIImage(named: ImageNamespace.tabbarMyPageSelected), for: .selected)
        button.tag = 4
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private var viewControllers = [
        UINavigationController(rootViewController: TempHomeViewController(viewModel: HomeViewModel())),
        UINavigationController(rootViewController: ProductViewController(viewModel: ProductViewModel())),
        UINavigationController(rootViewController: LiveTalkViewController()),
        PartyMemberViewController(),
        UINavigationController(rootViewController: MyPageViewController(viewModel: MyPageViewModel()))
    ]
    
    private var tabbarButtons: [UIButton] = []
    
    // MARK: - Properties
    
    private var selectedIndex = 0
    private var previousIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTarget()
        tabbarButtonTapped(tabbarButtons.first ?? UIButton())
        print("User AccessToKen: ", KeychainWrapper.standard.string(forKey: .accessToken) ?? "nil")
        print("User ID: ", KeychainWrapper.standard.integer(forKey: .userID) ?? "nil")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        homeButton.isSelected = true
        tabbarButtons = [
            homeButton, productButton, liveTalkButton, partyMemberButton, myPageButton
        ]
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.addSubviews(wholeView)
        wholeView.addSubviews(tabStackView, liveTalkButton)
        tabStackView.addArrangedSubviews(
            homeButton, productButton, emptyButton, partyMemberButton, myPageButton
        )
    }
    
    private func configureConstraints() {
        wholeView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(122)
        }
        tabStackView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(90)
        }
        liveTalkButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tabStackView.snp.top).offset(-32)
        }
    }
    
    private func addTarget() {
        tabbarButtons.forEach {
            $0.addTarget(self, action: #selector(tabbarButtonTapped), for: .touchUpInside)
        }
    }
    
    // MARK: - Action
    
    @objc
    func tabbarButtonTapped(_ sender: UIButton) {
        if (sender.tag == 3 || sender.tag == 2 || sender.tag == 4) && KeychainWrapper.standard.bool(forKey: .isGuestUser) ?? true {
            let popup = NotLoginPopup()
            popup.modalPresentationStyle = .overFullScreen
            popup.delegate = self
            present(popup, animated: false)
            return
        }
        
        if sender == liveTalkButton {
            liveTalkTapped()
        } else {
            otherTapped()
        }
        
        previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        tabbarButtons[previousIndex].isSelected = false
        
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
        sender.isSelected = true
        
        let vc = viewControllers[selectedIndex]
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first else { return }
        vc.view.frame = window.frame
        vc.didMove(toParent: self)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        self.view.bringSubviewToFront(wholeView)
    }
    
    func liveTalkTapped() {
        homeButton.setImage(UIImage(named: ImageNamespace.tabbarHomeInlive), for: .normal)
        productButton.setImage(UIImage(named: ImageNamespace.tabbarProductInlive), for: .normal)
        partyMemberButton.setImage(UIImage(named: ImageNamespace.tabbarPartyMemberInlive), for: .normal)
        myPageButton.setImage(UIImage(named: ImageNamespace.tabbarMypageInlive), for: .normal)
        emptyButton.setImage(UIImage(named: ImageNamespace.tabbarEmptyInlive), for: .normal)
        tabStackView.backgroundColor = .pointColor1
    }
    
    func otherTapped() {
        homeButton.setImage(UIImage(named: ImageNamespace.tabbarHomeDeselected), for: .normal)
        homeButton.setImage(UIImage(named: ImageNamespace.tabbarHomeSelected), for: .selected)
        productButton.setImage(UIImage(named: ImageNamespace.tabbarProductDeselected), for: .normal)
        productButton.setImage(UIImage(named: ImageNamespace.tabbarProductSelected), for: .selected)
        partyMemberButton.setImage(UIImage(named: ImageNamespace.tabbarPartyMemberDeselected), for: .normal)
        partyMemberButton.setImage(UIImage(named: ImageNamespace.tabbarPartyMemberSelected), for: .selected)
        myPageButton.setImage(UIImage(named: ImageNamespace.tabbarMyPageDeselected), for: .normal)
        myPageButton.setImage(UIImage(named: ImageNamespace.tabbarMyPageSelected), for: .selected)
        emptyButton.setImage(UIImage(named: ImageNamespace.tabbarEmpty), for: .normal)
        tabStackView.backgroundColor = .white
    }
}
extension TempMainTabBarController: NotLoginPopupDelegate {
    func loginButtonTapped() {
        let loginViewController = LoginViewController(viewModel: LoginViewModel())
        changeRootViewController(UINavigationController(rootViewController: loginViewController))
    }
}
