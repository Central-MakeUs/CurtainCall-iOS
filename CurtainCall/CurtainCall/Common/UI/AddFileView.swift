//
//  AddFileView.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/06.
//

import UIKit

final class AddFileView: UIView {
   
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        return stackView
    }()
    
    private let selectView = UIView()
    private let selectButton = UIButton()
    private let selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemSelectImage)
        return imageView
    }()
    private let selectImageLabel: UILabel = {
        let label = UILabel()
        label.text = "이미지 선택"
        label.font = .body4
        label.textColor = .hex161A20
        return label
    }()
    
    private let photoView = UIView()
    private let photoButton = UIButton()
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.lostItemPhoto)
        return imageView
    }()
    private let photoImageLabel: UILabel = {
        let label = UILabel()
        label.text = "사진 촬영"
        label.font = .body4
        label.textColor = .hex161A20
        return label
    }()

    weak var delegate: AddFileViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubviews(selectView, photoView)
        selectView.addSubviews(selectButton, selectImageView, selectImageLabel)
        photoView.addSubviews(photoButton, photoImageView, photoImageLabel)
    }
    
    private func configureConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(30)
            $0.horizontalEdges.equalToSuperview().inset(50)
        }
        selectButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        selectImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.size.equalTo(48)
            $0.centerX.equalToSuperview()
        }
        selectImageLabel.snp.makeConstraints {
            $0.top.equalTo(selectImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        photoButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        photoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.size.equalTo(48)
            $0.centerX.equalToSuperview()
        }
        photoImageLabel.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func addTargets() {
        selectButton.addTarget(
            self,
            action: #selector(selectImageButtonTouchUpInside),
            for: .touchUpInside
        )
        photoButton.addTarget(
            self,
            action: #selector(photoButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    @objc
    private func selectImageButtonTouchUpInside() {
        delegate?.didTapSelectImage()
    }
    
    @objc
    private func photoButtonTouchUpInside() {
        delegate?.didTapPhoto()
    }
}

protocol AddFileViewDelegate: AnyObject {
    func didTapSelectImage()
    func didTapPhoto()
}
