//
//  ProductPosterCell.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/13.
//

import UIKit

final class ProductPosterCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let stackView: UIStackView = {
        return UIStackView()
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.pointColor2?.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .body2
        return label
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        posterImageView.layer.cornerRadius = 10
        posterImageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubviews(posterImageView, titleLabel)
    }
    
    private func configureConstraints() {
        posterImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(140)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    func setUI(item: ProductListContentHaveSelected) {
        if let url = URL(string: item.poster) {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = nil
        }
        titleLabel.text = item.name
        posterImageView.layer.borderWidth = item.isSelected ? 4 : 0
    }
    
}
