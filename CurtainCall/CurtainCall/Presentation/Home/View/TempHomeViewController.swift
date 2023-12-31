//
//  HomeViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit
import Combine

import SnapKit
import Moya
import CombineMoya
import SwiftKeychainWrapper

final class TempHomeViewController: UIViewController {
    
    // MARK: - UI properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor1
        return view
    }()
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.homeBannerTitle)
        return imageView
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.navigationSearchButton), for: .normal)
        return button
    }()
    
    private let helloLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .subTitle2
        return label
    }()
    
    private let bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor1
        return view
    }()
    
    private lazy var bannerCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createBannerLayout())
        collectionView.register(
            HomeBannerCell.self,
            forCellWithReuseIdentifier: HomeBannerCell.identifier
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .pointColor1
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.numberOfPages = BannerData.list.count
        return pageControl
    }()
    
    private let myStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let myRecruitmentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    private let myRecruitmentHeaderView = UIView()
    private let myRecruitmentLabel: UILabel = {
        let label = UILabel()
        label.text = "📢  My 모집"
        label.font = .heading2
        label.textColor = .title
        return label
    }()
    
    private lazy var myRecruitmentTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(
            MyRecruitmentCell.self,
            forCellReuseIdentifier: MyRecruitmentCell.identifier
        )
        tableView.register(
            MyRecruitmentOtherCell.self,
            forCellReuseIdentifier: MyRecruitmentOtherCell.identifier
        )
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let myParticipationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    private let myParticipationHeaderView = UIView()
    private let myParticipationLabel: UILabel = {
        let label = UILabel()
        label.text = "🔎  My 참여"
        label.font = .heading2
        label.textColor = .title
        return label
    }()
    
    private lazy var myParticipationTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(
            MyRecruitmentCell.self,
            forCellReuseIdentifier: MyRecruitmentCell.identifier
        )
        tableView.register(
            MyRecruitmentOtherCell.self,
            forCellReuseIdentifier: MyRecruitmentOtherCell.identifier
        )
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let liveTalkView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF5F6F8
        return view
    }()
    
    private let liveTalkHeaderView = UIView()
    private let liveTalkLabel: UILabel = {
        let label = UILabel()
        label.text = "💬  커밍순 라이브톡"
        label.font = .heading2
        label.textColor = .title
        return label
    }()
    
    private lazy var liveTalkCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLiveTalkLayout())
        collectionView.register(
            HomeLiveTalkCell.self,
            forCellWithReuseIdentifier: HomeLiveTalkCell.identifier
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        return collectionView
    }()
    
    private let top10View: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let top10HeaderView = UIView()
    private let top10Label: UILabel = {
        let label = UILabel()
        label.text = "🔥  TOP10 인기 작품"
        label.font = .heading2
        label.textColor = .title
        return label
    }()
    
    private lazy var top10CollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createTop10Layout())
        collectionView.register(
            Top10Cell.self,
            forCellWithReuseIdentifier: Top10Cell.identifier
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.delegate = self
        return collectionView
    }()
    
    private let scheduledToOpenProductView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let scheduledToOpenProductHeaderView = UIView()
    private let scheduledToOpenProductLabel: UILabel = {
        let label = UILabel()
        label.text = "🕕  오픈 예정 공연"
        label.font = .heading2
        label.textColor = .title
        return label
    }()
    
    private lazy var scheduledToOpenProductCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createTop10Layout())
        collectionView.register(
            ScheduledToOpenProductCell.self,
            forCellWithReuseIdentifier: ScheduledToOpenProductCell.identifier
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.delegate = self
        return collectionView
    }()
    
    private let scheduledToEndProductView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let scheduledToEndProductHeaderView = UIView()
    private let scheduledToEndProductLabel: UILabel = {
        let label = UILabel()
        label.text = "⏰  마감 임박 공연"
        label.font = .heading2
        label.textColor = .title
        return label
    }()
    
    private lazy var scheduledToEndProductCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createTop10Layout())
        collectionView.register(
            ScheduledToEndProductCell.self,
            forCellWithReuseIdentifier: ScheduledToEndProductCell.identifier
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.delegate = self
        return collectionView
    }()
    
    
    // MARK: - Properties
    
    enum BannerSection {
        case main
    }
    typealias BannerItem = BannerData
    
    enum LiveTalkSection {
        case main
    }
    typealias LiveTalkItem = LiveTalkData
    
    enum Top10Section {
        case main
    }
    typealias Top10Item = Top10ShowContent
    
    enum ScheduledToOpenProductSection {
        case main
    }
    typealias ScheduledToOpenProductItem = OpenShowContent
    
    enum ScheduledToEndProductSection {
        case main
    }
    typealias ScheduledToEndProductItem = EndShowContent
    
    private var bannerDatasource: UICollectionViewDiffableDataSource<BannerSection, BannerItem>?
    private var liveTalkDatasource: UICollectionViewDiffableDataSource<LiveTalkSection, LiveTalkItem>?
    private var top10Datasource: UICollectionViewDiffableDataSource<Top10Section, Top10Item>?
    private var scheduledToOpenProductDatasource: UICollectionViewDiffableDataSource<ScheduledToOpenProductSection, ScheduledToOpenProductItem>?
    private var scheduledToEndProductDatasource: UICollectionViewDiffableDataSource<ScheduledToEndProductSection, ScheduledToEndProductItem>?
    
    private var subcriptions: Set<AnyCancellable> = []
    private let viewModel: HomeViewModel
    private var recruitmentList: [MyRecruitmentContent] = []
    private var participationList: [MyRecruitmentContent] = []
    
    // MARK: - Lifecycles
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pointColor1
        configureUI()
        bind()
//        if !(KeychainWrapper.standard.bool(forKey: .isGuestUser) ?? false) {
//            viewModel.requestToken()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        LodingIndicator.showLoading()
        viewModel.requestUserInfo()
        viewModel.requestOpen()
        viewModel.requestTop10()
        viewModel.requestEnd()
        viewModel.requestMyParticipation()
        viewModel.requestMyRecuritment()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureBannerDatasource()
        confgureBannerSnapshot()
        configureTop10Datasource()
        configureScheduledToOpenProductDatasource()
        configureScheduledToEndProductDatasource()
        
    }
    
    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            navigationView, helloLabel, bannerView, myStackView,
            liveTalkView, top10View, scheduledToOpenProductView, scheduledToEndProductView
        )
        bannerView.addSubviews(bannerCollectionView, pageControl)
        navigationView.addSubviews(titleImageView, searchButton)
        myStackView.addArrangedSubviews(myRecruitmentView, myParticipationView)
        
        myRecruitmentView.addSubviews(myRecruitmentHeaderView, myRecruitmentTableView)
        myRecruitmentHeaderView.addSubview(myRecruitmentLabel)
        
        myParticipationView.addSubviews(myParticipationHeaderView, myParticipationTableView)
        myParticipationHeaderView.addSubview(myParticipationLabel)
        
        liveTalkView.addSubviews(liveTalkHeaderView, liveTalkCollectionView)
        liveTalkHeaderView.addSubview(liveTalkLabel)
        
        top10View.addSubviews(top10HeaderView, top10CollectionView)
        top10HeaderView.addSubview(top10Label)
        
        scheduledToOpenProductView.addSubviews(
            scheduledToOpenProductHeaderView, scheduledToOpenProductCollectionView)
        scheduledToOpenProductHeaderView.addSubview(scheduledToOpenProductLabel)
        
        scheduledToEndProductView.addSubviews(
            scheduledToEndProductHeaderView, scheduledToEndProductCollectionView)
        scheduledToEndProductHeaderView.addSubview(scheduledToEndProductLabel)
        
    }
    
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { $0.edges.equalTo(view.safeAreaLayoutGuide) }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
//            $0.height.equalTo(2000)
        }
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        titleImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(24)
        }
        // TODO: 추후 개발
//        searchButton.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.trailing.equalToSuperview().inset(24)
//        }
        helloLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(26)
        }
        bannerView.snp.makeConstraints {
            $0.top.equalTo(helloLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
        }
        bannerCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(180)
        }
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(bannerCollectionView.snp.bottom).offset(11)
            $0.bottom.equalToSuperview().inset(16)
        }
        myStackView.snp.makeConstraints {
            $0.top.equalTo(bannerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            // TODO: 추가
            // $0.bottom.equalToSuperview().inset(24)
        }
        myRecruitmentHeaderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(71)
        }
        myRecruitmentLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().offset(24)
        }
        myRecruitmentTableView.snp.makeConstraints {
            $0.top.equalTo(myRecruitmentHeaderView.snp.bottom)
            $0.height.equalTo(HomeMyProductData.list.count * 137 + 10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
        
        myParticipationHeaderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(71)
        }
        myParticipationLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().offset(24)
        }
        myParticipationTableView.snp.makeConstraints {
            $0.top.equalTo(myParticipationHeaderView.snp.bottom)
            $0.height.equalTo(HomeMyProductData.list.count * 137 + 10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
        
//        liveTalkView.snp.makeConstraints {
//            $0.top.equalTo(myStackView.snp.bottom)
//            $0.horizontalEdges.equalToSuperview()
//
//        }
//
//        liveTalkHeaderView.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.horizontalEdges.equalToSuperview()
//            $0.height.equalTo(58)
//
//        }
//        liveTalkLabel.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(24)
//            $0.bottom.equalToSuperview().inset(10)
//        }
//
//        liveTalkCollectionView.snp.makeConstraints {
//            $0.top.equalTo(liveTalkHeaderView.snp.bottom)
//            $0.leading.equalToSuperview()
//            $0.trailing.equalToSuperview()
//            $0.height.equalTo(159)
//            $0.bottom.equalToSuperview()
//        }
        
        top10View.snp.makeConstraints {
            $0.top.equalTo(myStackView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        top10HeaderView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(58)
            
        }
        top10Label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        top10CollectionView.snp.makeConstraints {
            $0.top.equalTo(top10HeaderView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(220)
            $0.bottom.equalToSuperview()
        }
        
        scheduledToOpenProductView.snp.makeConstraints {
            $0.top.equalTo(top10View.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        scheduledToOpenProductHeaderView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(98)

        }
        scheduledToOpenProductLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(10)
        }

        scheduledToOpenProductCollectionView.snp.makeConstraints {
            $0.top.equalTo(scheduledToOpenProductHeaderView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(220)
            $0.bottom.equalToSuperview()
        }
        
        scheduledToEndProductView.snp.makeConstraints {
            $0.top.equalTo(scheduledToOpenProductView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        scheduledToEndProductHeaderView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(98)

        }
        scheduledToEndProductLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().inset(10)
        }

        scheduledToEndProductCollectionView.snp.makeConstraints {
            $0.top.equalTo(scheduledToEndProductHeaderView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(220)
            $0.bottom.equalToSuperview().inset(100)
        }
    }
    
    private func bind() {
        viewModel.userInfoSubject
            .sink { [weak self] response in
                self?.helloLabel.text = "안녕하세요. \(response.nickname)님:)"
            }.store(in: &subcriptions)
        
        viewModel.$openShowList
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                var snapshot = NSDiffableDataSourceSnapshot<ScheduledToOpenProductSection, ScheduledToOpenProductItem>()
                snapshot.appendSections([.main])
                snapshot.appendItems(response, toSection: .main)
                self?.scheduledToOpenProductDatasource?.apply(snapshot)
            }.store(in: &subcriptions)
        
        viewModel.$endShowList
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                var snapshot = NSDiffableDataSourceSnapshot<ScheduledToEndProductSection, ScheduledToEndProductItem>()
                snapshot.appendSections([.main])
                snapshot.appendItems(response, toSection: .main)
                self?.scheduledToEndProductDatasource?.apply(snapshot)
            }.store(in: &subcriptions)
        
        viewModel.$top10ShowList
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Top10Section, Top10Item>()
                snapshot.appendSections([.main])
                snapshot.appendItems(response, toSection: .main)
                top10Datasource?.apply(snapshot)
            }.store(in: &subcriptions)
        viewModel.recruitmentList
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if response.isEmpty {
                    myRecruitmentView.isHidden = true
                } else {
                    print("##MY 모집", response)
                    myRecruitmentView.isHidden = false
                    recruitmentList = response
                    myRecruitmentTableView.snp.updateConstraints({ make in
                        make.height.equalTo(response.count * 137 + 10)
                    })
                    
                }
                myRecruitmentTableView.reloadData()
            }.store(in: &subcriptions)
        
        viewModel.participationList
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                
                if response.isEmpty {
                    myParticipationView.isHidden = true
                } else {
                    print("##MY참여", response)
                    participationList = response
                    myParticipationView.isHidden = false
                    myParticipationTableView.snp.updateConstraints({ make in
                        make.height.equalTo(response.count * 137 + 10)
                    })
                }
                myParticipationTableView.reloadData()
            }.store(in: &subcriptions)

        viewModel.$requestCount
            .sink { [weak self] count in
                if count >= 6 {
                    LodingIndicator.hideLoading()
                    self?.viewModel.requestCount = 0
                }
            }.store(in: &subcriptions)
    }
    
    

}

extension TempHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == bannerCollectionView {
            switch indexPath.row {
            case 0:
                let guideDictViewController = GuideDictViewController()
                navigationController?.pushViewController(guideDictViewController, animated: true)
            case 1:
                let guideTickettingViewController = GuideTicketingViewController()
                navigationController?.pushViewController(guideTickettingViewController, animated: true)
                return
            case 2:
                //            let saleViewController = GuideSaleViewController()
                let storyboard = UIStoryboard(name: "GuideSale", bundle: Bundle.main)
                guard let saleViewController = storyboard.instantiateViewController(
                    withIdentifier: "GuideSaleViewController"
                ) as? GuideSaleViewController else {
                    return
                }
                navigationController?.pushViewController(saleViewController, animated: true)
                return
            default:
                fatalError("잘못된 컬렉션뷰")
            }
            return
        }
        
        if collectionView == scheduledToOpenProductCollectionView {
            guard let item = scheduledToOpenProductDatasource?.itemIdentifier(for: indexPath) else { return }
            let detailViewController = UINavigationController(
                rootViewController: ProductDetailMainViewController(id: item.id)
            )
            detailViewController.modalPresentationStyle = .overFullScreen
            present(detailViewController, animated: true)
            return
        }
        
        if collectionView == top10CollectionView {
            guard let item = top10Datasource?.itemIdentifier(for: indexPath) else { return }
            let detailViewController = UINavigationController(
                rootViewController: ProductDetailMainViewController(id: item.id)
            )
            detailViewController.modalPresentationStyle = .overFullScreen
            present(detailViewController, animated: true)
            return
        }
        
        if collectionView == scheduledToEndProductCollectionView {
            guard let item = scheduledToEndProductDatasource?.itemIdentifier(for: indexPath) else { return }
            let detailViewController = UINavigationController(
                rootViewController: ProductDetailMainViewController(id: item.id)
            )
            detailViewController.modalPresentationStyle = .overFullScreen
            present(detailViewController, animated: true)
            return
            
        }
    }
}

extension TempHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == myRecruitmentTableView {
            return recruitmentList.count
        } else {
            return participationList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueCell(
//            type: MyRecruitmentCell.self,
//            indexPath: indexPath
//        ) else { return UITableViewCell() }
//
        
        if tableView == myRecruitmentTableView {
            let item = recruitmentList[indexPath.row]
            if item.category == "ETC" {
                guard let cell = tableView.dequeueCell(type: MyRecruitmentOtherCell.self, indexPath: indexPath) else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.draw(item: item)
                return cell
            } else {
                guard let cell = tableView.dequeueCell(
                    type: MyRecruitmentCell.self,
                    indexPath: indexPath
                ) else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.draw(item: item)
                return cell
            }
        } else {
            let item = participationList[indexPath.row]
            if item.category == "ETC" {
                guard let cell = tableView.dequeueCell(type: MyRecruitmentOtherCell.self, indexPath: indexPath) else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                cell.draw(item: item)
                return cell
            } else {
                guard let cell = tableView.dequeueCell(
                    type: MyRecruitmentCell.self,
                    indexPath: indexPath
                ) else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.draw(item: item)
                return cell
            }
        }
        
    }
}

extension TempHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == myRecruitmentTableView {
            let id = recruitmentList[indexPath.row].id
            let category = recruitmentList[indexPath.row].category
            if category != "ETC" {
                navigationController?.pushViewController(MyPageDetailViewController(id: id, editType: .recruitment), animated: true)
            } else {
                navigationController?.pushViewController(MyPageDetailOtherViewController(id: id, editType: .recruitment), animated: true)
            }
        } else {
            let id = participationList[indexPath.row].id
            let category = participationList[indexPath.row].category
            if category != "ETC" {
                navigationController?.pushViewController(MyPageDetailViewController(id: id, editType: .participate), animated: true)
            } else {
                navigationController?.pushViewController(MyPageDetailOtherViewController(id: id, editType: .participate), animated: true)
            }
        }
    }
}

// MARK: Layout

extension TempHomeViewController {
    private func createBannerLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(180)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }
    
    private func configureBannerDatasource() {
        bannerDatasource = UICollectionViewDiffableDataSource<BannerSection, BannerItem>(
            collectionView: bannerCollectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                guard let cell = collectionView.dequeueCell(
                    type: HomeBannerCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                print(itemIdentifier)
                cell.drawCell(data: itemIdentifier)
                return cell
            }
        )
    }
    
    private func confgureBannerSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<BannerSection, BannerItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(BannerData.list, toSection: .main)
        bannerDatasource?.apply(snapshot)
    }
    
    private func createLiveTalkLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(127),
            heightDimension: .estimated(150)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(127),
            heightDimension: .estimated(150)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }
    
    private func configureLiveTalkDatasource() {
        liveTalkDatasource = UICollectionViewDiffableDataSource<LiveTalkSection, LiveTalkItem>(
            collectionView: liveTalkCollectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                guard let cell = collectionView.dequeueCell(
                    type: HomeLiveTalkCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                print(itemIdentifier)
                cell.drawCell(data: itemIdentifier)
                return cell
            }
        )
    }
    
    private func confgureLiveTalkSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<LiveTalkSection, LiveTalkItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(LiveTalkData.list, toSection: .main)
        liveTalkDatasource?.apply(snapshot)
    }
    
    private func createTop10Layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(120),
            heightDimension: .absolute(218)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(120),
            heightDimension: .absolute(218)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }
    
    private func configureTop10Datasource() {
        top10Datasource = UICollectionViewDiffableDataSource<Top10Section, Top10Item>(
            collectionView: top10CollectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                guard let cell = collectionView.dequeueCell(
                    type: Top10Cell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                print(itemIdentifier)
                cell.drawCell(data: itemIdentifier, index: indexPath.row + 1)
                return cell
            }
        )
    }
    
    private func configureScheduledToOpenProductDatasource() {
        scheduledToOpenProductDatasource = UICollectionViewDiffableDataSource<ScheduledToOpenProductSection, ScheduledToOpenProductItem>(
            collectionView: scheduledToOpenProductCollectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                guard let cell = collectionView.dequeueCell(
                    type: ScheduledToOpenProductCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                print(itemIdentifier)
                cell.drawCell(data: itemIdentifier)
                return cell
            }
        )
    }
    
    private func configureScheduledToEndProductDatasource() {
        scheduledToEndProductDatasource = UICollectionViewDiffableDataSource<ScheduledToEndProductSection, ScheduledToEndProductItem>(
            collectionView: scheduledToEndProductCollectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                guard let cell = collectionView.dequeueCell(
                    type: ScheduledToEndProductCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                print(itemIdentifier)
                cell.drawCell(data: itemIdentifier)
                return cell
            }
        )
    }
}

extension TempHomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bannerCollectionView {
            let page = Int((scrollView.contentOffset.x / scrollView.frame.width).rounded(.up))
            pageControl.currentPage = page
        }
        
        if scrollView == self.scrollView {
            if scrollView.contentOffset.y > 338 {
                view.backgroundColor = .white
            } else {
                view.backgroundColor = .pointColor1
            }
        }
    }
    
}
