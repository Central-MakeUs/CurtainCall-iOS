//
//  LiveTalkViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit
import Combine

import SnapKit
import StreamChat
import Moya
import CombineMoya

final class LiveTalkViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "라이브톡"
        label.font = .heading1
        label.textColor = .white
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "공연 시간 기준 2시간 전후에만 채팅이 가능해요!"
        label.font = .body3
        label.textColor = .white
        return label
    }()
    
    private let emptyView: UIView = {
        let view = UIView()
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.emptyLiveTalkMarks)
        let label = UILabel()
        label.text = "지금은 진행 중인 라이브톡이 없어요!"
        label.font = .body1
        label.textColor = .hexF5F6F8
        view.addSubviews(imageView, label)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        return view
    }()
//    private let playCategoryButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("진행중", for: .normal)
//        button.backgroundColor = UIColor(rgb: 0x525D77)
//        button.setTitleColor(.pointColor1, for: .normal)
//        button.layer.cornerRadius = 12
//        button.titleLabel?.font = .body1
//        return button
//    }()
//
//    private let playedCategoryButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("진행 완료", for: .normal)
//        button.backgroundColor = UIColor(rgb: 0x525D77)
//        button.setTitleColor(.pointColor1, for: .normal)
//        button.layer.cornerRadius = 12
//        button.titleLabel?.font = .body1
//        return button
//    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .pointColor1
        collectionView.register(LiveTalkCell.self, forCellWithReuseIdentifier: LiveTalkCell.identifier)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 110, right: 0)
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Properties
    
    enum Section {
        case main
    }
    typealias Item = LiveTalkShowContent
    
    private var datasoruce: UICollectionViewDiffableDataSource<Section, Item>?
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
//        categoryButtonTapped(playCategoryButton)
        hideKeyboardWhenTappedArround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestLiveTalkShow(page: 0, size: 99)
        configureDatasource()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureDatasource()
//        configureSnapshot()
//        addTargets()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .pointColor1
        view.addSubviews(emptyView, titleLabel, descriptionLabel, collectionView) //playCategoryButton,playedCategoryButton, collectionView)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
            $0.leading.equalToSuperview().offset(24)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(24)
        }
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
//        playCategoryButton.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
//            $0.leading.equalToSuperview().offset(24)
//            $0.height.equalTo(35)
//            $0.width.equalTo(73)
//        }
//        playedCategoryButton.snp.makeConstraints {
//            $0.top.equalTo(playCategoryButton)
//            $0.leading.equalTo(playCategoryButton.snp.trailing).offset(8)
//            $0.height.equalTo(35)
//            $0.width.equalTo(91)
//        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
//    private func addTargets() {
//        [playCategoryButton, playedCategoryButton]
//            .forEach { $0.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)}
//    }
    
    private func requestLiveTalkShow(page: Int, size: Int) {
        let provider = MoyaProvider<LiveTalkService>()
//        let date = Date() - (60 * 60 * 2)
        let date = Date() - (60 * 60 * 12) // 임시
        provider.requestPublisher(.show(page: page, size: size, baseDateTime: date.convertToAPIString()))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    self.emptyView.isHidden = false
                    self.collectionView.isHidden = true
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(LiveTalkShowResponse.self) {
                    if data.content.isEmpty {
                        emptyView.isHidden = false
                        self.collectionView.isHidden = true
                    } else {
                        emptyView.isHidden = true
                        self.collectionView.isHidden = false
                        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                        snapshot.appendSections([.main])
                        snapshot.appendItems(data.content, toSection: .main)
                        datasoruce?.apply(snapshot)
                        
                    }
                } else {
                    emptyView.isHidden = false
                    self.collectionView.isHidden = true
                }
            }.store(in: &subscriptions)

    }
    
//    @objc
//    private func categoryButtonTapped(_ sender: UIButton) {
//        sender.isSelected = true
//        if sender == playCategoryButton {
//            playedCategoryButton.isSelected = false
//        } else {
//            playCategoryButton.isSelected = false
//        }
//        [playedCategoryButton, playCategoryButton].forEach {
//            configureCategoryButton($0)
//        }
//    }
    
    private func configureCategoryButton(_ button: UIButton) {
        button.backgroundColor = button.isSelected ? .pointColor2 : UIColor(rgb: 0x525D77)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/2),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 6, bottom: 0, trailing: 6)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(280)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.edgeSpacing = .init(leading: nil, top: nil, trailing: .fixed(12), bottom: nil)
//        group.interItemSpacing = .fixed(12)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 18, bottom: 0, trailing: 18)
        section.interGroupSpacing = 20
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDatasource() {
        datasoruce = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueCell(
                    type: LiveTalkCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                cell.draw(item: item)
                return cell
            })
    }
}

extension LiveTalkViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let datasoruce, let item = datasoruce.itemIdentifier(for: indexPath) else {
            return
        }
        let channelId = ChannelId(type: .messaging, id: "\(item.id)-\(item.showAt)")
        
        let channelController = ChatClient.shared.channelController(for: channelId)
        channelController.synchronize { error in
            if let error {
                print("### 채널 에러", error.localizedDescription)
            }
        }
        let chatViewController = UINavigationController(
            rootViewController: LiveTalkChatViewController(item: item,
                channelController: channelController
            )
        )
        chatViewController.modalPresentationStyle = .overFullScreen
        present(chatViewController, animated: true)
        
    }
    
}
