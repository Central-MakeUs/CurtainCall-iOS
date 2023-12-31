//
//  MyPageViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit
import Combine

import SnapKit
import Kingfisher
import SwiftKeychainWrapper

final class MyPageViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let myTitle: UILabel = {
        let label = UILabel()
        label.textColor = .pointColor1
        label.font = .heading1
        label.text = "MY"
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let profileEditButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.myPageProfileEditIcon), for: .normal)
        return button
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle3
        label.textColor = .title
        return label
    }()
    
    private let myView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private let myRecruitmentView = UIView()
    private let myRecruitmentLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .body1
        label.text = "MY 모집"
        return label
    }()
    private let myRecruitmentCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 24)
        label.textColor = .pointColor2
        return label
    }()
    
    private let myRecruitmentButton = UIButton()
    
    private let myParticipationView = UIView()
    private let myParticipationLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle4
        label.textColor = .body1
        label.text = "MY 참여"
        return label
    }()
    private let myParticipationCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 24)
        label.textColor = .pointColor2
        return label
    }()
    private let myParticipationButton = UIButton()

    private let myViewSperator: UIView = {
        let view = UIView()
        view.backgroundColor = .hexBEC2CA
        return view
    }()
    
    private let myWriteView = UIView()
    private let myWriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.myPageWriteIcon)
        return imageView
    }()
    private let myWriteLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .title
        label.text = "내가 쓴 글"
        return label
    }()
    private let myWriteButton = UIButton()
    
    private let saveView = UIView()
    private let saveIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.myPageBorderIcon)
        return imageView
    }()
    private let saveLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .title
        label.text = "저장된 작품 목록"
        return label
    }()
    private let saveButton = UIButton()
    
    private let listSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private let noticeView = UIView()
    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항"
        label.textColor = .hex828996
        label.font = .body1
        return label
    }()
    private let noticeArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.myPageArrowRight)
        return imageView
    }()
    private let noticeButton = UIButton()
    
    private let FAQView = UIView()
    private let FAQLabel: UILabel = {
        let label = UILabel()
        label.text = "자주 묻는 질문"
        label.textColor = .hex828996
        label.font = .body1
        return label
    }()
    private let FAQArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.myPageArrowRight)
        return imageView
    }()
    private let FAQButton = UIButton()
    
    private let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private let footerHeadTitle: UILabel = {
        let label = UILabel()
        label.text = "[커튼콜 고객센터]"
        label.font = .body5
        label.textColor = .hex3B4350
        return label
    }()
    private let emailLabel: UILabel = {
        let attr = NSAttributedString(
            string: "curtaincall.official2023@gmail.com",
            attributes: [
                NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
            ])
        let label = UILabel()
        label.attributedText = attr
        label.font = .body5
        label.textColor = .hex3B4350
        return label
    }()

    private let footerSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = .hexE4E7EC
        return view
    }()
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.text = "작품 정보 출처\n(재)예술경영지원센터 공연예술통합전산망, www.kopis.or.kr)"
        label.font = .caption
        label.textColor = .hex828996
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Properties
    
    private let viewModel: MyPageViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Lifecycles
    
    init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestUserInfo()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            profileImageView, profileEditButton, nicknameLabel, myView, myWriteView, saveView,
            listSeperator, borderView, noticeView, FAQView, footerView, myTitle
        )
        myView.addSubviews(myRecruitmentView, myParticipationView, myViewSperator)
        myRecruitmentView.addSubviews(myRecruitmentLabel, myRecruitmentCountLabel, myRecruitmentButton)
        myParticipationView.addSubviews(myParticipationLabel, myParticipationCountLabel, myParticipationButton)
        myWriteView.addSubviews(myWriteIcon, myWriteLabel, myWriteButton)
        saveView.addSubviews(saveIcon, saveLabel, saveButton)
        noticeView.addSubviews(noticeLabel, noticeArrowImage, noticeButton)
        FAQView.addSubviews(FAQLabel, FAQArrowImage, FAQButton)
        footerView.addSubviews(footerHeadTitle, emailLabel, footerSeperator, sourceLabel)
    }
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        myTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(24)
        }
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(90)
            $0.top.equalToSuperview().offset(70)
            $0.centerX.equalToSuperview()
        }
        profileEditButton.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView).offset(7)
            $0.trailing.equalTo(profileImageView).offset(12)
        }
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
        myView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(90)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(40)
        }
        myRecruitmentView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        myParticipationView.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        myRecruitmentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.centerX.equalToSuperview()
        }
        myParticipationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.centerX.equalToSuperview()
        }
        myRecruitmentCountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-18)
            $0.centerX.equalToSuperview()
        }
        myRecruitmentButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        myParticipationCountLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-18)
            $0.centerX.equalToSuperview()
        }
        myParticipationButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        myViewSperator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(30)
            // TODO: 개발이후
//            $0.height.equalTo(0)
//            $0.width.equalTo(1)
        }
        myWriteView.snp.makeConstraints {
            // TODO: 개발이후
//            $0.height.equalTo(0)
            $0.height.equalTo(85)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(myView.snp.bottom).offset(20)
        }
        myWriteIcon.snp.makeConstraints {
            // TODO: 개발이후
//            $0.height.equalTo(0)
            $0.leading.equalToSuperview().offset(2)
            $0.centerY.equalToSuperview()
        }
        myWriteLabel.snp.makeConstraints {
            // TODO: 개발이후
//            $0.height.equalTo(0)
            $0.leading.equalTo(myWriteIcon.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }
        
        myWriteButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        listSeperator.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
            $0.top.equalTo(myWriteView.snp.bottom)
        }
        
        saveView.snp.makeConstraints {
            // TODO: 개발이후
//            $0.height.equalTo(0)
            $0.height.equalTo(85)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(listSeperator.snp.bottom)
        }
        saveIcon.snp.makeConstraints {
            // TODO: 개발이후
//            $0.height.equalTo(0)
            
            $0.leading.equalToSuperview().offset(2)
            $0.centerY.equalToSuperview()
        }
        saveLabel.snp.makeConstraints {
            // TODO: 개발이후
//            $0.height.equalTo(0)
            
            $0.leading.equalTo(myWriteIcon.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        borderView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(saveView.snp.bottom)
            $0.height.equalTo(10)
        }
        
        noticeView.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
    
        noticeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
        noticeArrowImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        FAQView.snp.makeConstraints {
            $0.top.equalTo(noticeView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            
            // TODO: 개발이후
//            $0.height.equalTo(0)
            $0.height.equalTo(50)
        }
    
        FAQLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
            
            // TODO: 개발이후
//            $0.height.equalTo(0)
        }
        FAQArrowImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            
            // TODO: 개발이후
//            $0.height.equalTo(0)
        }
        footerView.snp.makeConstraints {
            $0.top.equalTo(FAQView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        footerHeadTitle.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(26)
            $0.top.equalToSuperview().offset(24)
        }
        emailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(26)
            $0.top.equalTo(footerHeadTitle.snp.bottom).offset(4)
        }
        
        footerSeperator.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(1)
            $0.top.equalTo(emailLabel.snp.bottom).offset(20)
        }
        sourceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(26)
            $0.top.equalTo(footerSeperator.snp.bottom).offset(18)
            $0.bottom.equalToSuperview().inset(50)
        }
        noticeButton.snp.makeConstraints { $0.edges.equalToSuperview() }
        FAQButton.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    private func configureNavigation() {
        let settingImage = UIImage(named: ImageNamespace.myPageNavigationSettingIcon)
        let settingBarbuttonItem = UIBarButtonItem(
            image: settingImage,
            style: .plain,
            target: self,
            action: #selector(settingButtonTouchUpInside)
        )
        navigationItem.rightBarButtonItem = settingBarbuttonItem
        navigationItem.rightBarButtonItem?.tintColor = .hex828996
        
    }
    
    private func addTargets() {
        profileEditButton.addTarget(
            self,
            action: #selector(editButtonTouchUpInside),
            for: .touchUpInside
        )
        myRecruitmentButton.addTarget(
            self,
            action: #selector(myRecruitmentButtonTouchUpInside),
            for: .touchUpInside
        )
        myParticipationButton.addTarget(
            self,
            action: #selector(myParticipationButtonTouchUpInside),
            for: .touchUpInside
        )
        noticeButton.addTarget(
            self,
            action: #selector(noticeButtonTouchUpInside),
            for: .touchUpInside
        )
        FAQButton.addTarget(
            self,
            action: #selector(FAQButtonTouchUpInside),
            for: .touchUpInside
        )
        myWriteButton.addTarget(
            self,
            action: #selector(myWriteButtonTouchUpInside),
            for: .touchUpInside
        )
        saveButton.addTarget(
            self,
            action: #selector(myFavoriteButtonTouchUpInside),
            for: .touchUpInside
        )
    }
    
    private func bind() {
        viewModel.userInfoSubject
            .sink { [weak self] response in
                guard let self else { return }
                draw(userInfo: response)
            }.store(in: &subscriptions)
    }
    
    private func draw(userInfo: MyPageDetailResponse) {
        if let imageURL = userInfo.imageUrl,
            let url = URL(string: imageURL) {
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(named: ImageNamespace.defaultProfile)
        }
        nicknameLabel.text = userInfo.nickname
        myParticipationCountLabel.text = "\(userInfo.participationNum)"
        myRecruitmentCountLabel.text = "\(userInfo.recruitingNum)"
    }
    
    @objc
    private func settingButtonTouchUpInside() {
        let settingViewControlelr = UINavigationController(rootViewController: SettingViewController())
        settingViewControlelr.modalPresentationStyle = .fullScreen
        present(settingViewControlelr, animated: true)
    }
    
    @objc
    private func editButtonTouchUpInside() {
        let editViewController = UINavigationController(
            rootViewController: MyPageEditViewController(
                viewModel: MyPageEditViewModel(),
                profileImage: profileImageView.image,
                nickname: nicknameLabel.text ?? ""
            )
        )
        editViewController.modalPresentationStyle = .fullScreen
        present(editViewController, animated: true)
    }
    
    @objc
    private func myRecruitmentButtonTouchUpInside() {
        let viewModel = MyRecruitmentViewModel()
        let recruitmentViewController = UINavigationController(
            rootViewController: MyRecruitmentViewController(viewModel: viewModel)
        )
        recruitmentViewController.modalPresentationStyle = .fullScreen
        present(recruitmentViewController, animated: true)
    }
    
    @objc
    private func myParticipationButtonTouchUpInside() {
        let viewModel = MyParticipationViewModel()
        let participationViewController = UINavigationController(
            rootViewController: MyParticipationViewController(viewModel: viewModel)
        )
        participationViewController.modalPresentationStyle = .fullScreen
        present(participationViewController, animated: true)
    }
    
    @objc
    private func noticeButtonTouchUpInside() {
        navigationController?.navigationBar.prefersLargeTitles = false
        let noticeViewController = NoticeViewController(viewModel: NoticeViewModel())
        navigationController?.pushViewController(noticeViewController, animated: true)
    }
    
    @objc
    private func myWriteButtonTouchUpInside() {
        guard let userId = KeychainWrapper.standard.integer(forKey: .userID) else {
            return
        }
        let myWriteView = UINavigationController(rootViewController: MyWriteViewController())
        myWriteView.modalPresentationStyle = .overFullScreen
        present(myWriteView, animated: true)
    }
    
    @objc
    private func myFavoriteButtonTouchUpInside() {
        guard let userId = KeychainWrapper.standard.integer(forKey: .userID) else {
            return
        }
        let viewModel = MyFavoriteViewModel(id: userId)
        let myFavoriteView = UINavigationController(rootViewController: MyFavoriteViewController(viewModel: viewModel))
        myFavoriteView.modalPresentationStyle = .overFullScreen
        present(myFavoriteView, animated: true)
    }
    
    @objc
    private func FAQButtonTouchUpInside() {
        let FAQViewController = UINavigationController(rootViewController: FAQViewController())
        FAQViewController.modalPresentationStyle = .overFullScreen
        present(FAQViewController, animated: true)
    }
}
