//
//  PartyMemberRecruitingDetailViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/23.
//

import UIKit
import Combine

import Moya
import CombineMoya
import SwiftKeychainWrapper
import StreamChat

final class PartyMemberRecruitingDetailViewController: UIViewController {
    
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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
    
    private let detailTitleView = UIView()
    private let detailTitleSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailTitleSymbol)
        return imageView
    }()
    private let detailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "작품명"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
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
        label.text = "공연 일자"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductDateLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let detailTimeView = UIView()
    private let detailTimeSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailTimeSymbol)
        return imageView
    }()
    private let detailTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "공연 시간"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let detailLocationView = UIView()
    private let detailLocationSymbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.partymemberDetailLocationSymbol)
        return imageView
    }()
    private let detailLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.text = "공연 장소"
        label.textColor = .hex5A6271
        return label
    }()
    private let detailProductLocationLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .body1
        return label
    }()
    
    private let partyInButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("참여하기", for: .normal)
        button.setNextButton(isSelected: true)
        return button
    }()
    
    private let dotLineViews = [
        DotLineView(), DotLineView(), DotLineView(), DotLineView()
    ]
    
    // MARK: - Properties
    
    private let partyType: PartyCategoryType
    private let id: Int
    private var subscriptions: Set<AnyCancellable> = []
    private let provider = MoyaProvider<PartyAPI>()
    private var item: PartyDetailResponse?
    private var isMyPartyIn: Bool = false
    
    // MARK: - Lifecycles
    
    init(id: Int, partyType: PartyCategoryType) {
        self.id = id
        self.partyType = partyType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LodingIndicator.showLoading()
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
            detailTitleView,
            detailStateView,
            detailDateView,
            detailTimeView,
            detailLocationView
        )
        detailTitleView.addSubviews(
            detailTitleSymbolImageView, detailTitleLabel, detailProductLabel
        )
        detailStateView.addSubviews(
            detailStateSymbolImageView, detailStateLabel, detailCountLabel
        )
        detailDateView.addSubviews(
            detailDateSymbolImageView, detailDateLabel, detailProductDateLabel
        )
        detailTimeView.addSubviews(
            detailTimeSymbolImageView, detailTimeLabel, detailProductTimeLabel
        )
        detailLocationView.addSubviews(
            detailLocationSymbolImageView, detailLocationLabel, detailProductLocationLabel
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
        detailTitleView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailTitleSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        detailTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(detailTitleSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
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
        detailTimeView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailTimeSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        detailTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(detailTimeSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductTimeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
        }
        detailLocationView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        detailLocationSymbolImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            
        }
        detailLocationLabel.snp.makeConstraints {
            $0.leading.equalTo(detailLocationSymbolImageView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        detailProductLocationLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(121)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
//        dotLineViews.forEach {
//            $0.snp.makeConstraints { make in
//                make.horizontalEdges.equalToSuperview()
//                make.height.equalTo(1)
//            }
//        }
       
    }
    
    private func configureNavigation() {
        configureBackbarButton()
        title = partyType.title
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
        detailProductLabel.text = partyInfo.showName
        detailCountLabel.text = "\(partyInfo.curMemberNum)/\(partyInfo.maxMemberNum)"
        detailProductDateLabel.text = partyInfo.showAt?.convertAPIDateToDateString()
        detailProductTimeLabel.text = partyInfo.showAt?.convertAPIDateToDateTime()
        detailProductLocationLabel.text = partyInfo.facilityName
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
                    draw(partyInfo: data)
                    item = data
                    let currentUserId = KeychainWrapper.standard.integer(forKey: .userID) ?? 0
                    
                    if data.creatorId != currentUserId {
                        configureReportButton()
                        isMyParty()
                        partyInButton.setTitle("참여하기", for: .normal)
                        isMyPartyIn = false
                    } else {
                        configureDeleteButton()
                        partyInButton.setTitle("TALK 만들기", for: .normal)
                        partyInButton.setNextButton(isSelected: true)
                        isMyPartyIn = true
                        
//                        partyInButton.setNextButton(isSelected: false)
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
//                    self?.partyInButton.setNextButton(isSelected: !isMyParty.participated)
                    if isMyParty.participated {
                        self?.partyInButton.setTitle("TALK 입장하기", for: .normal)
                        self?.partyInButton.setNextButton(isSelected: true)
                        self?.isMyPartyIn = true
                    }
//                    self?.isMyPartyIn = isMyParty.participated
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
                content: item.content,
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
    
    
}

extension PartyMemberRecruitingDetailViewController {
    func moveToDelete() {
        let popupViewController = MyPageDeletePopup()
        popupViewController.delegate = self
        popupViewController.modalPresentationStyle = .overFullScreen
        present(popupViewController, animated: false)
    }
}

extension PartyMemberRecruitingDetailViewController: DeletePopDelegate {
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

extension PartyMemberRecruitingDetailViewController: PartyInPopupDelegate {
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
