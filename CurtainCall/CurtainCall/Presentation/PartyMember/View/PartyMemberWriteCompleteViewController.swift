//
//  PartyMemberWriteCompleteViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/17.
//

import UIKit

final class PartyMemberWriteCompleteViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let wholeView = UIView()
    private let checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberCompleteSymbol)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "파티원 모집글이 게시되었습니다."
        label.font = .subTitle1
        label.textColor = .body1
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = """
                     해당 게시물은 파티원 모집과
                     마이페이지에서 확인할 수 있습니다.
                     """
        label.font = .body2
        label.textColor = .hex828996
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.text = "게시물 확인하기"
        label.textAlignment = .center
        label.font = .body2
        label.textColor = .hex828996
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.hex828996?.cgColor
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("홈으로 이동", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .pointColor2
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTarget()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(wholeView, nextButton)
        wholeView.addSubviews(
            checkImageView, titleLabel, subTitleLabel, badgeLabel
        )
    }
    
    private func configureConstraints() {
        wholeView.snp.makeConstraints {
            $0.height.equalTo(230)
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
        }
        checkImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(checkImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
        }
        badgeLabel.snp.makeConstraints {
            $0.width.equalTo(136)
            $0.height.equalTo(39)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }
    
    private func addTarget() {
        nextButton.addTarget(
            self,
            action: #selector(nextButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    @objc
    private func nextButtonTouchUpInside() {
        changeRootViewController(TempMainTabBarController())
        print("!!!")
    }
    
}
