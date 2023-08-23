//
//  PartyMemberRecruitingProductViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/12.
//

import UIKit
import Combine

import SnapKit

final class PartyMemberRecruitingProductViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let step1Label: UILabel = {
        let label = UILabel()
        label.textColor = .pointColor1
        label.text = "Step 1"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private let step2Label: UILabel = {
        let label = UILabel()
        label.textColor = .hexE4E7EC
        label.text = "Step 2"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private let step3Label: UILabel = {
        let label = UILabel()
        label.textColor = .hexE4E7EC
        label.text = "Step 3"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private let stepLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let step1View: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor1
        view.layer.cornerRadius = 4
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        return view
    }()
    
    private let step2View: UIView = {
        let view = UIView()
        view.backgroundColor = .hexE4E7EC
        return view
    }()
    
    private let step3View: UIView = {
        let view = UIView()
        view.backgroundColor = .hexE4E7EC
        view.layer.cornerRadius = 4
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let stepViewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        return stackView
    }()
    
    private let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor1
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = partyType.title
        label.textColor = .white
        label.font = .body5
        return label
    }()
    
    private let typeSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "분류를 선택해주세요."
        label.textColor = .hex161A20
        label.font = .subTitle2
        return label
    }()
    
    private let typeSelectStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.clipsToBounds = true
        return stackView
    }()
    
    private let theaterButton: UIButton = {
        let button = UIButton()
        button.setTitle("연극", for: .normal)
        button.titleLabel?.font = .subTitle4
        button.setTitleColor(.white, for: .selected)
        button.setTitleColor(.hexBEC2CA, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        button.layer.borderWidth = 1
        return button
    }()
    
    private let musicalButton: UIButton = {
        let button = UIButton()
        button.setTitle("뮤지컬", for: .normal)
        button.titleLabel?.font = .subTitle4
        button.setTitleColor(.white, for: .selected)
        button.setTitleColor(.hexBEC2CA, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        button.layer.borderWidth = 1
        return button
    }()
    
    private let productSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "작품을 선택해주세요."
        label.textColor = .hex161A20
        label.font = .subTitle2
        return label
    }()
    
    private let essentialLabel: UILabel = {
        let label = UILabel()
        label.text = "필수"
        label.textAlignment = .center
        label.textColor = .pointColor2
        label.layer.borderColor = UIColor.pointColor2?.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 11
        label.font = .body4
        return label
    }()

    private let reservationDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let reservationOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("예매율순", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(.body1, for: .selected)
        button.setTitleColor(.hexBEC2CA, for: .normal)
        return button
    }()
    
    private let dictionaryOrderDotView: UIView = {
        let view = UIView()
        view.backgroundColor = .pointColor2
        view.layer.cornerRadius = 2
        return view
    }()
    
    private let dictionaryOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("가나다순", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(.body1, for: .selected)
        button.setTitleColor(.hexBEC2CA, for: .normal)
        return button
    }()
    
    private let updateTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .caption
        label.text = "8:00 업데이트"
        label.textColor = .hexBEC2CA
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.delegate = self
        return collectionView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .hexBEC2CA
        button.setTitleColor(.hexE4E7EC, for: .normal)
        button.layer.cornerRadius = 12
        button.isUserInteractionEnabled = false
        return button
    }()
    
    // MARK: - Properties
    
    private let partyType: PartyCategoryType
    private let viewModel: PartyMemberRecruitingProductViewModel
    
    enum Section {
        case play
        case musical
    }
    typealias Item = ProductListContentHaveSelected
    
    private var cancellables: Set<AnyCancellable> = []
    private var datasource: UICollectionViewDiffableDataSource<Section, Item>?
    private var snapshot: NSDiffableDataSourceSnapshot<Section, Item>?
    private var selectedItem: ProductListContentHaveSelected?
    
    // MARK: - Lifecycles
    
    init(partyType: PartyCategoryType, viewModel: PartyMemberRecruitingProductViewModel) {
        self.partyType = partyType
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTarget()
        registerCell()
        bind()
        typeButtonTouchUpInside(theaterButton)
        orderSelectButtonTouchUpInside(reservationOrderButton)
        viewModel.requestProductSelectInfo(page: 0, size: 21, genre: .play)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
        configureDatasource()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(
            stepLabelStackView, stepViewStackView, titleView, typeSelectLabel,
            typeSelectStackView, productSelectLabel, essentialLabel, reservationDotView,
            reservationOrderButton, dictionaryOrderDotView, dictionaryOrderButton,
            updateTimeLabel, collectionView, nextButton
        )
        stepLabelStackView.addArrangedSubviews(step1Label, step2Label, step3Label)
        stepViewStackView.addArrangedSubviews(step1View, step2View, step3View)
        titleView.addSubview(titleLabel)
        typeSelectStackView.addArrangedSubviews(theaterButton, musicalButton)
    }
    
    private func configureConstraints() {
        stepLabelStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(22)
        }
        stepViewStackView.snp.makeConstraints {
            $0.top.equalTo(stepLabelStackView.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(8)
        }
        titleView.snp.makeConstraints {
            $0.top.equalTo(stepViewStackView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
        }
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        typeSelectLabel.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(24)
        }
        typeSelectStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.top.equalTo(typeSelectLabel.snp.bottom).offset(10)
            $0.height.equalTo(38)
        }
        productSelectLabel.snp.makeConstraints {
            $0.top.equalTo(typeSelectStackView.snp.bottom).offset(34)
            $0.leading.equalToSuperview().offset(24)
        }
        essentialLabel.snp.makeConstraints {
            $0.centerY.equalTo(productSelectLabel)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.equalTo(40)
            $0.height.equalTo(22)
        }
        
        reservationDotView.snp.makeConstraints {
            $0.height.width.equalTo(4)
            $0.top.equalTo(essentialLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(24)
        }
        
        reservationOrderButton.snp.makeConstraints {
            $0.centerY.equalTo(reservationDotView)
            $0.leading.equalTo(reservationDotView.snp.trailing).offset(4)
        }
        dictionaryOrderDotView.snp.makeConstraints {
            $0.height.width.equalTo(4)
            $0.centerY.equalTo(reservationDotView)
            $0.leading.equalTo(reservationOrderButton.snp.trailing).offset(10)
        }
        
        dictionaryOrderButton.snp.makeConstraints {
            $0.centerY.equalTo(dictionaryOrderDotView)
            $0.leading.equalTo(dictionaryOrderDotView.snp.trailing).offset(4)
        }
        
        updateTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(dictionaryOrderDotView)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(updateTimeLabel.snp.bottom).offset(21)
            $0.bottom.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }
    
    private func configureNavigation() {
        title = "파티원 모집"
        configureBackbarButton()
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 7, bottom: 0, trailing: 7)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.37)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = .init(leading: nil, top: nil, trailing: nil, bottom: .fixed(26))
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 13, bottom: 79, trailing: 13)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }
    
    private func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueCell(
                    type: ProductPosterCell.self,
                    indexPath: indexPath
                ) else { return UICollectionViewCell() }
                cell.setUI(item: item)
                return cell
            })
    }
    
    private func registerCell() {
        collectionView.register(
            ProductPosterCell.self,
            forCellWithReuseIdentifier: ProductPosterCell.identifier
        )
    }
    
    private func addTarget() {
        [theaterButton, musicalButton].forEach {
            $0.addTarget(self, action: #selector(typeButtonTouchUpInside), for: .touchUpInside)
        }
        [reservationOrderButton, dictionaryOrderButton].forEach {
            $0.addTarget(
                self,
                action: #selector(orderSelectButtonTouchUpInside),
                for: .touchUpInside
            )
        }
        nextButton.addTarget(self, action: #selector(nextButtonTouchUpInside), for: .touchUpInside)
    }
    
    private func bind() {
        viewModel.$playList
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.play])
                snapshot.appendItems(value, toSection: .play)
                datasource?.apply(snapshot)
                viewModel.isLoding = false
            }.store(in: &cancellables)
        
        viewModel.$musicalList
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.deleteAllItems()
                snapshot.appendSections([.musical])
                snapshot.appendItems(value, toSection: .musical)
                datasource?.apply(snapshot)
                viewModel.isLoding = false
            }.store(in: &cancellables)

        
        viewModel.isSelectProduct
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isSelected in
                self?.setNextButton(isSelected: isSelected)
            }.store(in: &cancellables)
    }
    
    private func setNextButton(isSelected: Bool) {
        nextButton.backgroundColor = isSelected ? .pointColor2 : .hexE4E7EC
        nextButton.setTitleColor(
            isSelected ? .white : .hexBEC2CA,
            for: .normal
        )
        nextButton.isUserInteractionEnabled = isSelected
    }
    
    private func moveToStep2() {
        guard let selectedItem else { return }
        let step2ViewController = PartyMemberRecruitingDateViewController(
            partyType: partyType,
            viewModel: PartyMemberRecruitingDateViewModel(),
            product: selectedItem
        )
        navigationController?.pushViewController(step2ViewController, animated: true)
    }
    
    // MARK: - Actions
    
    @objc
    private func typeButtonTouchUpInside(_ sender: UIButton) {
        selectedItem = nil
        viewModel.isSelectProduct.send(false)
        [theaterButton, musicalButton].forEach {
            $0.isSelected = sender == $0
            $0.isUserInteractionEnabled = !(sender == $0)
            $0.backgroundColor = sender == $0 ? .pointColor2 : .white
            $0.layer.borderColor = sender == $0 ? UIColor.pointColor2?.cgColor
            : UIColor.hexBEC2CA?.cgColor
        }
        if sender == theaterButton {
            viewModel.requestProductSelectInfo(page: 0, size: 21, genre: .play)
            viewModel.theaterPage = 0
        } else {
            viewModel.requestProductSelectInfo(page: 0, size: 21, genre: .musical)
            viewModel.musicalPage = 0
        }
    }
    
    @objc
    private func orderSelectButtonTouchUpInside(_ sender: UIButton) {
        [reservationOrderButton, dictionaryOrderButton].forEach {
            $0.isSelected = sender == $0
            $0.isUserInteractionEnabled = !(sender == $0)
        }
        reservationDotView.alpha = sender == reservationOrderButton ? 1 : 0
        dictionaryOrderDotView.alpha = sender == dictionaryOrderButton ? 1 : 0
    }
    
    @objc
    private func nextButtonTouchUpInside() {
        moveToStep2()
    }
}

extension PartyMemberRecruitingProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let datasource, let item = datasource.itemIdentifier(for: indexPath) else {
            return
        }
        selectedItem = item
        viewModel.didSelectProduct(item, genre: theaterButton.isSelected ? .play : .musical)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if theaterButton.isSelected {
            if indexPath.row > (viewModel.theaterPage + 1) * 21 - 3 {
                if !viewModel.isLoding {
                    viewModel.isLoding = true
                    viewModel.requestProductSelectInfo(page: viewModel.theaterPage + 1, size: 21, genre: .play)
                    viewModel.theaterPage += 1
                }
            }
        } else {
            if indexPath.row > (viewModel.musicalPage + 1) * 21 - 3 {
                if !viewModel.isLoding {
                    viewModel.isLoding = true
                    viewModel.requestProductSelectInfo(page: viewModel.musicalPage + 1, size: 21, genre: .musical)
                    viewModel.musicalPage += 1
                }
            }
        }
    }
}
