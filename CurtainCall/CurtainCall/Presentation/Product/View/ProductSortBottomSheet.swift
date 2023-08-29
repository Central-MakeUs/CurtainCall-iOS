//
//  ProductSortBottomSheet.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import UIKit

enum ProductSortType {
    case star
    case end
    case dict
    
    var title: String {
        switch self {
        case .star: return "별점순"
        case .end: return "종료 임박순"
        case .dict: return "가나다순"
        }
    }
    
    var APIName: String {
        switch self {
        case .star: return "reviewGradeAvg,desc"
        case .end: return "endDate"
        case .dict: return "name"
        }
    }
}

protocol ProductSortBottomSheetDelegate: AnyObject {
    func sort(type: ProductSortType)
}


final class ProductSortBottomSheet: UIViewController {
    
    // MARK: - UI properties
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let starView = UIView()
    private let starLabel: UILabel = {
        let label = UILabel()
        label.text = "별점순"
        label.font = .body1
        return label
    }()
    private let starButton = UIButton()
    
    private let endView = UIView()
    private let endLabel: UILabel = {
        let label = UILabel()
        label.text = "종료 임박순"
        label.font = .body1
        return label
    }()
    private let endButton = UIButton()
    
    private let dictView = UIView()
    private let dictLabel: UILabel = {
        let label = UILabel()
        label.text = "가나다순"
        label.font = .body1
        return label
    }()
    private let dictButton = UIButton()
    
    // MARK: - Properties
    weak var delegate: ProductSortBottomSheetDelegate?
    private let type: ProductSortType
    
    // MARK: - Lifecycles
    
    init(type: ProductSortType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addTargets()
        setLabel(type: type)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.addArrangedSubviews(starView, endView, dictView)
        starView.addSubviews(starLabel, starButton)
        endView.addSubviews(endLabel, endButton)
        dictView.addSubviews(dictLabel, dictButton)
    }
    
    private func configureConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.horizontalEdges.equalToSuperview()
        }
        
        starView.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalToSuperview()
        }
        
        [starLabel, endLabel, dictLabel].forEach {
            $0.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(24)
            }
        }
        
        [starButton, endButton, dictButton].forEach {
            $0.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    private func setLabel(type: ProductSortType) {
        switch type {
        case .star:
            starLabel.textColor = .pointColor2
        case .end:
            endLabel.textColor = .pointColor2
        case .dict:
            dictLabel.textColor = .pointColor2
        }
        
    }
    
    private func addTargets() {
        [starButton, endButton, dictButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        if sender == starButton {
            delegate?.sort(type: .star)
        } else if sender == endButton {
            delegate?.sort(type: .end)
        } else {
            delegate?.sort(type: .dict)
        }
        dismiss(animated: true)
    }
    
    
}
