//
//  LiveTalkChatReceiveCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/06.
//

import UIKit

final class LiveTalkChatReceiveCell: UITableViewCell {
    
    // MARK: UI Property
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 21
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "dummy_profile1")
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .body4
        label.textColor = .white
        return label
    }()
    
    private let messageView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x525D77)
        view.layer.cornerRadius = 12
//        view.clipsToBounds = true
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let dateButton: UIButton = {
        let button = UIButton()
        button.setTitle("오전 11:04 | 신고", for: .normal)
        button.titleLabel?.font = .caption
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    
    // MARK: Property
    
    // MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureUI()
        
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
        backgroundColor = .pointColor1
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
    }
}

