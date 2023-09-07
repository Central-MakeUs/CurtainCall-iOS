//
//  PartyMemberRecruitingOtherDetailViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/25.
//

import UIKit

import Combine

import Moya
import CombineMoya
import SwiftKeychainWrapper
import StreamChat

final class PartyMemberRecruitingOtherDetailViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 26
        return imageView
    }()
    
    private let profileLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .title
        return label
    }()
    
    private let writeDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body5
        label.textColor = .hexBEC2CA
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .body1
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .hex5A6271
        label.numberOfLines = 0
        return label
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .pointColor1
        label.text = "상세 정보"
        return label
    }()
    
    private let detailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let detailStateView = UIView()
    private let detailStateSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailCountStateSymbol)
        return imageView
    }()
    private let detailStateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "참여 상태"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailCountLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let grayBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private let detailDateView = UIView()
    private let detailDateSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailDateSymbol)
        return imageView
    }()
    private let detailDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "날짜"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let partyInButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("참여하기", for: .normal)
        return button
    }()
    
    private let dotLineViews = DotLineView()
    
    // MARK: - Properties
    
    private let id: Int
    private var subscriptions: Set<AnyCancellable> = []
    private let provider = MoyaProvider<PartyAPI>()
    private var item: PartyDetailResponse?
    private var isMyPartyIn: Bool = false
    
    // MARK: - Lifecycles
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        requestDetail()
        partyInButton.addTarget(
            self,
            action: #selector(partyInButtonTouchUpInside),
            for: .touchUpInside
        )
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(scrollView, partyInButton)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(headerView, grayBorderView, detailView)
        headerView.addSubviews(profileImageView, profileLabelStackView, titleLabel, contentLabel)
        profileLabelStackView.addArrangedSubviews(nickNameLabel, writeDateLabel)
        detailView.addSubviews(detailLabel, detailStackView)
        detailStackView.addArrangedSubviews(
            detailDateView,
            detailStateView
        )
        detailStateView.addSubviews(
            detailStateSymbolImageView, detailStateLabel, detailCountLabel
        )
        detailDateView.addSubviews(
            detailDateSymbolImageView, detailDateLabel, detailProductDateLabel
        )
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(partyInButton.snp.top).inset(30)
        }
        partyInButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        headerView.snp.makeConstraints { $0.top.leading.trailing.equalToSuperview() }
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(31)
            $0.size.equalTo(52)
        }
        profileLabelStackView.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
        }
        contentLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.bottom.equalToSuperview().inset(38)
        }
        grayBorderView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        detailView.snp.makeConstraints {
            $0.top.equalTo(grayBorderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        detailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        detailStackView.snp.makeConstraints {
            $0.top.equalTo(detailLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-20)

        }
        
        detailStateView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailStateSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        detailStateLabel.snp.makeConstraints {
            $0.leading.equalTo(detailStateSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
        detailDateView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailDateSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        detailDateLabel.snp.makeConstraints {
            $0.leading.equalTo(detailDateSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductDateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
       
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = "기타"
    }
    
    private func draw(partyInfo: PartyDetailResponse) {
        if let urlString = partyInfo.creatorImageUrl, let url = URL(string: urlString) {
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(named: ImageNamespace.defaultProfile)
        }
        nickNameLabel.text = partyInfo.creatorNickname
        titleLabel.text = partyInfo.title
        writeDateLabel.text = partyInfo.createdAt.convertAPIDateToDateString()
        contentLabel.text = partyInfo.content

        detailCountLabel.text = "\(partyInfo.curMemberNum)/\(partyInfo.maxMemberNum)"
        detailProductDateLabel.text = partyInfo.showAt?.convertAPIDateToDateString() ?? "날짜 미정"
    }
    
    private func requestDetail() {
        provider.requestPublisher(.detail(id: id))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    LodingIndicator.hideLoading()
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(PartyDetailResponse.self) {
                    item = data
                    draw(partyInfo: data)
                    let currentUserId = KeychainWrapper.standard.integer(forKey: .userID) ?? 0
                    isMyParty()
                    if data.creatorId != currentUserId {
                        configureReportButton()
                    } else {
                        configureDeleteButton()

                    }
                    
                }
                LodingIndicator.hideLoading()
                        
            }.store(in: &subscriptions)
    }
    private func isMyParty() {
        provider.requestPublisher(.isMyParty(id: [id]))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    LodingIndicator.hideLoading()
                    return
                }
            } receiveValue: { [weak self] response in
                if let data = try? response.map(IsMyPartyResponse.self),
                   let isMyParty = data.content.first {
                    if !isMyParty.participated {
                        self?.partyInButton.setTitle("TALK 만들기", for: .normal)
                        self?.partyInButton.setNextButton(isSelected: true)
                    }
                    self?.isMyPartyIn = !isMyParty.participated
                }
                    
                LodingIndicator.hideLoading()
            }.store(in: &subscriptions)

    }
    
    @objc
    private func partyInButtonTouchUpInside() {
        if isMyPartyIn {
            guard let item else { return }
            let convertItem = MyRecruitmentContent(
                id: item.id,
                title: item.title,
                curMemberNum: item.curMemberNum,
                maxMemberNum: item.maxMemberNum,
                showAt: item.showAt,
                createdAt: item.createdAt,
                category: item.category ?? "",
                creatorId: item.creatorId,
                creatorNickname: item.creatorNickname,
                creatorImageUrl: item.creatorImageUrl,
                showId: item.showId,
                showName: item.showName,
                showPoster: "",
                facilityId: item.facilityId,
                facilityName: item.facilityName
            )
            
            let channelId = ChannelId(type: .messaging, id: "PARTY-\(item.id)")
            let channelController = ChatClient.shared.channelController(for: channelId)
            channelController.synchronize { error in
                if let error {
                    print("### 채널 에러", error.localizedDescription)
                }
            }
            let talkViewController = PartyTalkViewController(item: convertItem, channelController: channelController)
            navigationController?.pushViewController(talkViewController, animated: true)
        } else {
            let popup = PartyInPopup()
            popup.modalPresentationStyle = .overFullScreen
            popup.delegate = self
            present(popup, animated: false)
        }
    }
    
    
    @objc
    private func reportButtonTouchUpInside() {
        let reportViewController = ReportViewController(viewModel: ReportViewModel(id: id, type: .party))
        navigationController?.pushViewController(reportViewController, animated: true)
    }
    
    private func configureReportButton() {
        let reportButton = UIBarButtonItem(
            title: nil,
            image: UIImage(named: ImageNamespace.navigationReportButton),
            target: self,
            action: #selector(reportButtonTouchUpInside)
        )
        navigationItem.rightBarButtonItem = reportButton
        navigationItem.rightBarButtonItem?.tintColor = .hex828996
    }
    
    private func configureDeleteButton() {
        let deleteButton = UIBarButtonItem(
            title: "삭제",
            image: nil,
            target: self,
            action: #selector(deleteButtonTouchUpInside)
        )
        navigationItem.rightBarButtonItem = deleteButton
        navigationItem.rightBarButtonItem?.tintColor = .hex828996
    }
    
    @objc
    private func deleteButtonTouchUpInside() {
        moveToDelete()
    }
}

extension PartyMemberRecruitingOtherDetailViewController {
    func moveToDelete() {
        let popupViewController = MyPageDeletePopup()
        popupViewController.delegate = self
        popupViewController.modalPresentationStyle = .overFullScreen
        present(popupViewController, animated: false)
    }
}

extension PartyMemberRecruitingOtherDetailViewController: DeletePopDelegate {
    func deleteButtonTapped() {
        provider.requestPublisher(.delete(id: id))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                if response.statusCode == 200 {
                    self?.navigationController?.popViewController(animated: true)
                }
            }.store(in: &subscriptions)

    }
}

extension PartyMemberRecruitingOtherDetailViewController: PartyInPopupDelegate {
    func partyInButtonTapped() {
        provider.requestPublisher(.participation(id: id))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if response.statusCode == 200 {
                    LodingIndicator.showLoading()
                    self.isMyParty()
                } else {
                    // TODO: Network Error
                }
            }.store(in: &subscriptions)

    }
}
