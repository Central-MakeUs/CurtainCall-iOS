//
//  PartyTalkChatReceiveCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/07.
//

import UIKit

import Kingfisher

final class PartyTalkChatReceiveCell: UITableViewCell {
    
    // MARK: UI Property
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 21
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .body4
        label.textColor = .title
        return label
    }()
    
    private let messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        view.layer.cornerRadius = 12
//        view.clipsToBounds = true
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        label.numberOfLines = 0
        return label
    }()
    
    private let dateButton: UIButton = {
        let button = UIButton()
        button.setTitle("오전 11:04 | 신고", for: .normal)
        button.titleLabel?.font = .caption
        button.setTitleColor(.hex828996, for: .normal)
        return button
    }()
    
    // MARK: Property
    
    weak var delegate: LiveTalkChatCellDelegate?
    
    // MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        configureUI()
        dateButton.addTarget(self, action: #selector(reportButtonTapped), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        backgroundColor = .white
        addSubviews(profileImageView, nicknameLabel, messageView, dateButton)
        messageView.addSubview(messageLabel)
    }
    
    private func configureConstraints() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(24)
            $0.size.equalTo(42)
        }
        nicknameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
        }
        messageView.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(12)
            $0.height.greaterThanOrEqualTo(35)
            $0.bottom.equalToSuperview().inset(10)
        }
        messageLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(6)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        dateButton.snp.makeConstraints {
            $0.bottom.equalTo(messageView).offset(5)
            $0.leading.equalTo(messageView.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualToSuperview().inset(12)
        }
    }
    
    func draw(data: TalkMessageData) {
        nicknameLabel.text = data.nickname
        messageLabel.text = data.message
        if let imageURL = data.imageURL {
            profileImageView.kf.setImage(with: imageURL)
        } else {
            profileImageView.image = UIImage(named: ImageNamespace.defaultProfile)
        }
        print("@@@data: \(data)")
    }
    
    @objc
    private func reportButtonTapped() {
        delegate?.didTappedReportButton()
    }
}


