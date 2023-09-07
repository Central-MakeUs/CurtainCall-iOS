//
//  PartyTalkChatSendCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/07.
//

import UIKit

final class PartyTalkChatSendCell: UITableViewCell {
    
    // MARK: UI Property
    
    private let messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 12
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
        button.titleLabel?.font = .caption
        button.setTitleColor(.hex828996, for: .normal)
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
        backgroundColor = .white
        addSubviews(messageView, dateButton)
        messageView.addSubview(messageLabel)
    }
    
    private func configureConstraints() {
        messageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.greaterThanOrEqualTo(35)
            $0.bottom.equalToSuperview().inset(10)
        }
        messageLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(6)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        dateButton.snp.makeConstraints {
            $0.bottom.equalTo(messageView).offset(5)
            $0.trailing.equalTo(messageView.snp.leading).offset(-8)
            $0.leading.greaterThanOrEqualToSuperview().offset(12)
        }
    }
    
    func draw(data: TalkMessageData) {
        messageLabel.text = data.message
        dateButton.setTitle(data.createAt.convertToChatTimeToKorean(), for: .normal)
    }
}


