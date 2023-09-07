//
//  PartyTalkViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/09/07.
//

import UIKit

import UIKit

import StreamChat
import SwiftKeychainWrapper

final class PartyTalkViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.navigationBackButton), for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "\(item.title) (\(item.curMemberNum)/\(item.maxMemberNum))"
        label.font = .subTitle3
        label.textColor = .title
        return label
    }()
    
    private lazy var showDateLabel: UILabel = {
        let label = UILabel()
        let showAt = item.showAt?.convertAPIDateToDate() ?? Date()
        let showAtString = showAt.convertToChatDateToKorean()
        label.text = "일시 | \(showAtString)"
        label.font = .body3
        label.textColor = .hex828996
        return label
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexE4E7EC
        return view
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.chatSendButtonWhite), for: .normal)
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
        textView.textColor = .body1
        textView.font = .body2
        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        textView.delegate = self
        textView.backgroundColor = .clear
        return textView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            PartyTalkChatReceiveCell.self,
            forCellReuseIdentifier: PartyTalkChatReceiveCell.identifier
        )
        tableView.register(
            PartyTalkChatSendCell.self,
            forCellReuseIdentifier: PartyTalkChatSendCell.identifier
        )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let emptyView = UIView()
    
    //    private let channelController = ChatClient.shared.channelController(for: ChannelManager.superChannelId)
    //
    // MARK: - Properties
    
    private let channelController: ChatChannelController
    private var eventsController: EventsController!
    private var messageData: [TalkMessageData] = []
    private let item: MyRecruitmentContent
    var isFirst = true
    
    // MARK: - Lifecycles
    
    init(item: MyRecruitmentContent, channelController: ChatChannelController) {
        self.item = item
        self.channelController = channelController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        channelController.delegate = self
        eventsController = ChatClient.shared.eventsController()
        addTargets()
        hideKeyboardTableViewTappedArround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToBottom()
        //        let indexPath = IndexPath(row: TalkMessageData.list.count - 1, section: 0)
        //        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
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
        view.backgroundColor = .hexE4E7EC
        view.addSubviews(topView, bottomView, tableView, emptyView)
        topView.addSubviews(backButton, titleLabel, showDateLabel)
        bottomView.addSubviews(sendButton, chatView)
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
        sendButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
            $0.size.equalTo(40)
        }
        chatView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(40)
            $0.height.lessThanOrEqualTo((chatTextView.font?.lineHeight ?? 0) * 4 + 20)
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalTo(sendButton.snp.leading).offset(-10)
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
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
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
    
    func hideKeyboardTableViewTappedArround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func sendButtonTapped() {
        guard let text = chatTextView.text, text != Constants.MESSAGE_PLACEHODER else { return }
        channelController.createNewMessage(text: text) { result in
            switch result {
            case .success(let messageId):
                print("## message:", messageId)
            case .failure(let error):
                print("## message Error", error.localizedDescription)
            }
        }

        chatTextView.text = ""
    }
}

extension PartyTalkViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = messageData[indexPath.row]
        if data.chatType == .receive {
            guard let cell = tableView.dequeueCell(type: PartyTalkChatReceiveCell.self, indexPath: indexPath) else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.draw(data: data)
            return cell
        } else {
            guard let cell = tableView.dequeueCell(type: PartyTalkChatSendCell.self, indexPath: indexPath) else {
                return UITableViewCell()
            }
            cell.draw(data: data)
            return cell
        }
    }
    
    func scrollToBottom()  {
        let point = CGPoint(x: 0, y: self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.frame.height)
        if point.y >= 0{
            self.tableView.setContentOffset(point, animated: true)
        }
    }
}

extension PartyTalkViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PartyTalkViewController: UITextViewDelegate {
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

extension PartyTalkViewController: LiveTalkChatCellDelegate {
    func didTappedReportButton() {
        // TODO: 신고 기능 추가
        let reportViewController = ReportViewController(viewModel: ReportViewModel(id: 1, type: .party))
        navigationController?.pushViewController(reportViewController, animated: true)
    }
}

extension PartyTalkViewController: ChatChannelControllerDelegate {
    func channelController(_ channelController: ChatChannelController, didUpdateChannel channel: EntityChange<ChatChannel>) {
        
    }
    
    func channelController(_ channelController: ChatChannelController, didUpdateMessages changes: [ListChange<ChatMessage>]) {
        let item = changes.map { $0.item }
        let userId = KeychainWrapper.standard.integer(forKey: .userID) ?? 0
        let message = item.map { TalkMessageData(
            chatType: $0.author.id == "\(userId)" ? .send : .receive,
            nickname: $0.author.name ?? "no name",
            message: $0.text,
            createAt: $0.createdAt,
            imageURL: $0.author.imageURL
        )
        }.sorted { $0.createAt < $1.createAt }
        
        var removeDuplicatedMessage: [TalkMessageData] = []
        var prev = TalkMessageData(
            chatType: .receive,
            nickname: UUID().uuidString,
            message: "",
            createAt: Date() + Double.random(in: 1...10000),
            imageURL: nil
        )
        message.forEach {
            if $0.message != prev.message && $0.createAt != prev.createAt {
                removeDuplicatedMessage.append($0)
            }
            prev = $0
        }
        
        if isFirst {
            isFirst = false
            messageData = removeDuplicatedMessage
            eventsController.delegate = self
            tableView.reloadData()
//            let indexPath = IndexPath(row: min(messageData.count - 1, 0), section: 0)
//            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
}
extension PartyTalkViewController: EventsControllerDelegate {
    func eventsController(_ controller: EventsController, didReceiveEvent event: Event) {
        if isFirst { return }
        switch event {
        case let event as MessageNewEvent:
            let userId = KeychainWrapper.standard.integer(forKey: .userID) ?? 0
            if isFirst { return }
            messageData.append(
                TalkMessageData(
                    chatType: event.user.id == "\(userId)" ? .send : .receive,
                    nickname: event.user.name ?? "no name",
                    message: event.message.text,
                    createAt: event.createdAt,
                    imageURL: event.user.imageURL
                )
            )
            tableView.reloadData()
            scrollToBottom()
        default:
            return
        }
    }
}

