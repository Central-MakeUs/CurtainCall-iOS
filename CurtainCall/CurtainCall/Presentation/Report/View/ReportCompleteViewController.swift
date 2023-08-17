//
//  ReportCompleteViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/17.
//

import UIKit

final class ReportCompleteViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let completeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberCompleteSymbol)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x1A1A1A)
        label.font = .subTitle1
        label.text = "신고가 접수되었어요"
        return label
    }()
    
    private let completeButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("완료", for: .normal)
        button.setNextButton(isSelected: true)
        return button
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        completeButton.addTarget(self, action: #selector(completeButtonTouchUpInside), for: .touchUpInside)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.addSubviews(completeImageView, titleLabel, completeButton)
        completeImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().inset(5)
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(completeImageView.snp.bottom).offset(10)
        }
        completeButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
        }
    }
    
    @objc
    private func completeButtonTouchUpInside() {
        dismiss(animated: true)
    }
}
