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
}

protocol ProductSortBottomSheetDelegate: AnyObject {
    func sort(type: ProductSortType)
}


final class ProductSortBottomSheet: UIViewController {
    
    // MARK: - UI properties
    
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
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        
    }
    
    private func configureSubviews() {
        
    }
    
    private func configureConstraints() {
        
    }
    
}
