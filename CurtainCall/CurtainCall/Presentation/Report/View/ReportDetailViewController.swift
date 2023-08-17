//
//  ReportDetailViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/16.
//

import UIKit

final class ReportDetailViewController: UIViewController {
    
    // MARK: - UI properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "신고 내용을 상세하게 적어주세요."
        label.font = .subTitle2
        label.textColor = .title
        return label
    }()
    
    private lazy var reportTextView: UITextView = {
        let textView = UITextView()
        textView.text = Constants.REPORT_DETAIL_TEXTVIEW_PLACEHOLDER
        textView.font = .body2
        textView.textColor = .hex828996
        textView.backgroundColor = .hexF5F6F8
        textView.layer.cornerRadius = 10
        textView.textContainerInset = .init(top: 12, left: 18, bottom: 12, right: 18)
        
        textView.delegate = self
        return textView
    }()
    
    private let limitTextLabel: UILabel = {
        let label = UILabel()
        label.text = "글자수 제한 (0/200)"
        label.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 12)
        label.textColor = .hex3B4350
        return label
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexF2F3F5
        return view
    }()
    
    private let bangMark1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.reportBangIcon)
        return imageView
    }()
    
    private let reportDetailLabel1: UILabel = {
        let label = UILabel()
        label.font = .body4
        label.textColor = .hex828996
        label.text = "허위 신고 시 운영정책에 따라 조치될 수 있습니다."
        label.numberOfLines = 0
        return label
    }()
    
    private let bangMark2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.reportBangIcon)
        return imageView
    }()
    
    private let reportDetailLabel2: UILabel = {
        let label = UILabel()
        label.font = .body4
        label.textColor = .hex828996
        label.text = "이 회원이 신고 대상에 해당하는지 다시 한번 확인하여 주시기 바랍니다."
        label.numberOfLines = 0
        return label
    }()
    
    private let bangMark3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNamespace.reportBangIcon)
        return imageView
    }()
    
    private let reportDetailLabel3: UILabel = {
        let label = UILabel()
        label.font = .body4
        label.textColor = .hex828996
        label.text = "신고자 정보 및 신고 내용은 신고 대상에게 공개되지 않으나, 사실 관계 확인에 꼭 필요한 신고 내용의 일부는 언급될 수 있습니다."
        label.numberOfLines = 0
        return label
    }()
    
    private let reportButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("신고하기", for: .normal)
        button.setNextButton(isSelected: false)
        return button
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        hideKeyboardWhenTappedArround()
        reportButton.addTarget(
            self, action: #selector(reportButtonTouchUpInside), for: .touchUpInside
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
        view.addSubviews(scrollView, reportButton)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            titleLabel, reportTextView, limitTextLabel, borderView, bangMark1, bangMark2, bangMark3,
            reportDetailLabel1, reportDetailLabel2, reportDetailLabel3
        )
    }
    
    private func configureConstraints() {
        reportButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
        }
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(reportButton.snp.top).offset(16)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(24)
        }
        reportTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(222)
        }
        limitTextLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(reportTextView.snp.bottom).offset(10)
        }
        borderView.snp.makeConstraints {
            $0.top.equalTo(limitTextLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(7)
        }
        bangMark1.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        
        reportDetailLabel1.snp.makeConstraints {
            $0.top.equalTo(borderView.snp.bottom).offset(32)
            $0.leading.equalTo(bangMark1.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        bangMark2.snp.makeConstraints {
            $0.top.equalTo(bangMark1.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(24)
        }
        
        reportDetailLabel2.snp.makeConstraints {
            $0.top.equalTo(reportDetailLabel1.snp.bottom).offset(16)
            $0.leading.equalTo(bangMark2.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(24)
        }
        
        bangMark3.snp.makeConstraints {
            $0.top.equalTo(bangMark2.snp.bottom).offset(33)
            $0.leading.equalToSuperview().offset(24)
        }
        reportDetailLabel3.snp.makeConstraints {
            $0.top.equalTo(reportDetailLabel2.snp.bottom).offset(13)
            $0.leading.equalTo(bangMark3.snp.trailing).offset(8)
            $0.bottom.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func configureNavigation() {
        configureBackbarButton(.pop)
        title = "신고하기"
    }
    
    private func updateCountLabel(count: Int) {
        limitTextLabel.text = "글자 수 제한(\(count)/200)"
    }
    
    @objc
    private func reportButtonTouchUpInside() {
        let completeViewController = ReportCompleteViewController()
        navigationController?.pushViewController(completeViewController, animated: true)
        navigationController?.navigationBar.isHidden = true
    }
    
}
extension ReportDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Constants.REPORT_DETAIL_TEXTVIEW_PLACEHOLDER {
            textView.text = nil
            return
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = Constants.REPORT_DETAIL_TEXTVIEW_PLACEHOLDER
            return
        }
        
    }
    
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        guard let content = textView.text else { return false }
        if let char = text.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard content.count <= 200 else { return false }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        reportButton.setNextButton(isSelected: !textView.text.isEmpty && textView.text != Constants.REPORT_DETAIL_TEXTVIEW_PLACEHOLDER)
        updateCountLabel(count: textView.text.count)
        
    }
}
