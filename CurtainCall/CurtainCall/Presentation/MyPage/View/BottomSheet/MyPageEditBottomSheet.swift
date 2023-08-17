//
//  MyPageEditBottomSheet.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import UIKit

protocol EditBottomSheetDelegate: AnyObject {
    func moveToEdit()
    func moveToDelete()
}

final class MyPageEditBottomSheet: UIViewController {
    
    // MARK: - UI properties
    
    private let editView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let editImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.bottomEditIcon)
        return imageView
    }()
    
    private let editLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .title
        label.text = "수정"
        return label
    }()
    
    private let editButton = UIButton()
    
    private let removeView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let removeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.bottomRemoveIcon)
        return imageView
    }()
    
    private let removeLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .title
        label.text = "삭제"
        return label
    }()
    
    private let removeButton = UIButton()
    
    // MARK: - Properties
    
    weak var delegate: EditBottomSheetDelegate?
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.addSubviews(editView, removeView)
        editView.addSubviews(editImageView, editLabel, editButton)
        removeView.addSubviews(removeImageView, removeLabel, removeButton)
    }
    
    private func configureConstraints() {
        editView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(56)
            $0.height.equalTo(55)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        removeView.snp.makeConstraints {
            $0.top.equalTo(editView.snp.bottom).offset(12)
            $0.height.equalTo(55)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        editImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        editLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(editImageView.snp.trailing).offset(8)
        }
        editButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        removeImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        removeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(removeImageView.snp.trailing).offset(8)
        }
        removeButton.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    @objc
    private func editButtonTapped() {
        dismiss(animated: true)
        delegate?.moveToEdit()
    }
    
    @objc
    private func removeButtonTapped() {
        dismiss(animated: true)
        delegate?.moveToDelete()
    }
    
}
