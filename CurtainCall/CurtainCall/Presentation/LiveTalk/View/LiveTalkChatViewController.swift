//
//  LiveTalkChatViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/06.
//

import UIKit

import StreamChat

final class LiveTalkChatViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.05)
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.navigationBackButtonWhite), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "드림하이 (82/100)"
        label.font = .subTitle3
        label.textColor = .white
        return label
    }()
    
    private let showDateLabel: UILabel = {
        let label = UILabel()
        label.text = "일시 | 2023.06.24 (수) 오후 7:30"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    private let bottomView = UIView()
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.chatAddButton), for: .normal)
        return button
    }()
    
    private let chatView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var chatTextView: UITextView = {
        let textView = UITextView()
        textView.text = Constants.MESSAGE_PLACEHODER
        textView.textColor = .pointColor1
        textView.font = .body3
        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        textView.delegate = self
        textView.keyboardAppearance = .dark
        return textView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            LiveTalkChatReceiveCell.self,
            forCellReuseIdentifier: LiveTalkChatReceiveCell.identifier
        )
        tableView.register(
            LiveTalkChatSendCell.self,
            forCellReuseIdentifier: LiveTalkChatSendCell.identifier
        )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .pointColor1
        return tableView
    }()
    
    private let emptyView = UIView()
    
    private let channelController = ChatClient.shared.channelController(for: ChannelManager.superChannelId)
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        channelController.delegate = self
        addTargets()
        hideKeyboardWhenTappedArround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(row: TalkMessageData.list.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .pointColor1
        view.addSubviews(topView, bottomView, tableView, emptyView)
        topView.addSubviews(backButton, titleLabel, showDateLabel)
        bottomView.addSubviews(addButton, chatView)
        chatView.addSubview(chatTextView)
    }
    
    private func configureConstraints() {
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(124)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(bottomView.snp.top)
        }
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(51)
            $0.leading.equalToSuperview().offset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(54)
            $0.leading.equalTo(backButton.snp.trailing).offset(16)
            $0.trailing.lessThanOrEqualToSuperview().offset(24)
        }
        showDateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(7)
            $0.leading.equalTo(titleLabel)
            $0.trailing.lessThanOrEqualToSuperview().inset(24)
        }
        bottomView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(emptyView.snp.top).offset(10)
        }
        addButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
        chatView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(40)
            $0.height.lessThanOrEqualTo((chatTextView.font?.lineHeight ?? 0) * 4 + 20)
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalTo(addButton.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(24)
        }
        chatTextView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        emptyView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(0)
        }
    }
    
    private func addTargets() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func keyboardUp(notification: NSNotification) {
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            emptyView.snp.updateConstraints {
                $0.height.equalTo(keyboardRectangle.height)
            }
        }
    }
    
    @objc
    private func keyboardDown() {
        emptyView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
    }
}

extension LiveTalkChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TalkMessageData.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = TalkMessageData.list[indexPath.row]
        if data.chatType == .receive {
            guard let cell = tableView.dequeueCell(type: LiveTalkChatReceiveCell.self, indexPath: indexPath) else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.draw(data: data)
            return cell
        } else {
            guard let cell = tableView.dequeueCell(type: LiveTalkChatSendCell.self, indexPath: indexPath) else {
                return UITableViewCell()
            }
            cell.draw(data: data)
            return cell
        }
    }
    
    
}

extension LiveTalkChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension LiveTalkChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == Constants.MESSAGE_PLACEHODER {
            // 버튼 처리
        }
        textView.isScrollEnabled = textView.numberOfLine() > 3
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Constants.MESSAGE_PLACEHODER {
            textView.text = nil
            return
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = Constants.MESSAGE_PLACEHODER
            return
        }
        
    }
}

extension LiveTalkChatViewController: LiveTalkChatCellDelegate {
    func didTappedReportButton() {
        // TODO: 신고 기능 추가
        let reportViewController = ReportViewController(viewModel: ReportViewModel(id: 1, type: .party))
        navigationController?.pushViewController(reportViewController, animated: true)
    }
}

extension LiveTalkChatViewController: ChatChannelControllerDelegate {
    func channelController(_ channelController: ChatChannelController, didUpdateChannel channel: EntityChange<ChatChannel>) {
        print("## updateChannel: \(channel)")
    }
    
    func channelController(_ channelController: ChatChannelController, didUpdateMessages changes: [ListChange<ChatMessage>]) {
        print("## update Event: \(changes.map { $0.item })")
    }
}
