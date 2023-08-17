//
//  MyPageEditViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/14.
//

import UIKit

import SnapKit

final class MyPageEditViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "dummy_profile1")
        return imageView
    }()
    
    private let profileEditButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.myPageProfileEditingIcon), for: .normal)
        return button
    }()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .hexF5F6F8
        textField.font = .body1
        textField.textColor = .hex828996
        textField.addLeftPadding(width: 20)
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let setCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .body4
        button.backgroundColor = .pointColor2
        return button
    }()
    
    private let completeButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("변경 완료", for: .normal)
        return button
    }()
    
   
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
        view.addSubviews(
            profileImageView, profileEditButton, nicknameTextField, setCheckButton, completeButton
        )
        
    }
    
    private func configureConstraints() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(90)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(67)
            $0.centerX.equalToSuperview()
        }
        profileEditButton.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView).offset(7)
            $0.trailing.equalTo(profileImageView).offset(12)
        }
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(59)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }
        setCheckButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(32)
            $0.width.equalTo(91)
        }
        completeButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    private func configureNavigation() {
        title = "내정보 수정"
        navigationController?.navigationBar.prefersLargeTitles = false
        configureBackbarButton(.dismiss)
    }
}

