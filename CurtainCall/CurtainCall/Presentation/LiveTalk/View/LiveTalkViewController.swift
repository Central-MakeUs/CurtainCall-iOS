//
//  LiveTalkViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/07.
//

import UIKit

import SnapKit
import StreamChat

final class LiveTalkViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "라이브톡"
        label.font = .heading1
        label.textColor = .white
        return label
    }()
    
    private let playCategoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("진행중", for: .normal)
        button.backgroundColor = UIColor(rgb: 0x525D77)
        button.setTitleColor(.pointColor1, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .body1
        return button
    }()
    
    private let playedCategoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("진행 완료", for: .normal)
        button.backgroundColor = UIColor(rgb: 0x525D77)
        button.setTitleColor(.pointColor1, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .body1
        return button
    }()
    
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
    
    private var datasoruce: UICollectionViewDiffableDataSource<Section, String>?
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        categoryButtonTapped(playCategoryButton)
        hideKeyboardWhenTappedArround()
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureDatasource()
        configureSnapshot()
        addTargets()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .pointColor1
        view.addSubviews(titleLabel, playCategoryButton,playedCategoryButton, collectionView)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(6)
            $0.leading.equalToSuperview().offset(24)
        }
        playCategoryButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(24)
            $0.height.equalTo(35)
            $0.width.equalTo(73)
        }
        playedCategoryButton.snp.makeConstraints {
            $0.top.equalTo(playCategoryButton)
            $0.leading.equalTo(playCategoryButton.snp.trailing).offset(8)
            $0.height.equalTo(35)
            $0.width.equalTo(91)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(playCategoryButton.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func addTargets() {
        [playCategoryButton, playedCategoryButton]
            .forEach { $0.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)}
    }
    
    @objc
    private func categoryButtonTapped(_ sender: UIButton) {
        sender.isSelected = true
        if sender == playCategoryButton {
            playedCategoryButton.isSelected = false
        } else {
            playCategoryButton.isSelected = false
        }
        [playedCategoryButton, playCategoryButton].forEach {
            configureCategoryButton($0)
        }
    }
    
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
        datasoruce = UICollectionViewDiffableDataSource<Section, String>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueCell(
                    type: LiveTalkCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                return cell
            })
    }
    
    private func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(["1", "2", "3", "4", "5", "6"])
        datasoruce?.apply(snapshot)
    }
}

extension LiveTalkViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let channelController = ChatClient.shared.channelController(for: ChannelManager.superChannelId)
        channelController.synchronize { error in
            if let error {
                print("### 채널 에러", error.localizedDescription)
            }
        }
        let chatViewController = UINavigationController(
            rootViewController: LiveTalkChatViewController(
                channelController: channelController
            )
        )
        chatViewController.modalPresentationStyle = .overFullScreen
        present(chatViewController, animated: true)
        
    }
}
