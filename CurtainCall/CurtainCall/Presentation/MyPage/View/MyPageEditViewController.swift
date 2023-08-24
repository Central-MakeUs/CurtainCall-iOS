//
//  MyPageEditViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/14.
//

import UIKit
import Combine

import SnapKit
import Moya
import CombineMoya

final class MyPageEditViewController: UIViewController {
    
    // MARK: - UI properties
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = profileImage
        return imageView
    }()
    
    private let profileEditButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ImageNamespace.myPageProfileEditingIcon), for: .normal)
        return button
    }()
    
    private lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .hexF5F6F8
        textField.font = .body1
        textField.textColor = .hex828996
        textField.addLeftPadding(width: 20)
        textField.layer.cornerRadius = 10
        textField.text = nickname
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private let setCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("중복 확인", for: .normal)
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .body4
        button.backgroundColor = .pointColor2
        return button
    }()
    
    private let completeButton: BottomNextButton = {
        let button = BottomNextButton()
        button.setTitle("변경 완료", for: .normal)
        button.setNextButton(isSelected: false)
        return button
    }()
    
    private lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    private let validLabel: UILabel = {
        let label = UILabel()
        label.font = .body4
        label.numberOfLines = 0
        return label
    }()
   
    // MARK: - Properties
    
    private var subscriptions: Set<AnyCancellable> = []
    private var profileImage: UIImage?
    private var nickname: String
    private let viewModel: MyPageEditViewModel
    
    // MARK: - Lifecycles
    
    init(viewModel: MyPageEditViewModel, profileImage: UIImage?, nickname: String) {
        self.viewModel = viewModel
        self.profileImage = profileImage
        self.nickname = nickname
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
        hideKeyboardWhenTappedArround()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.backgroundColor = .white
        view.addSubviews(
            profileImageView, profileEditButton, nicknameTextField, setCheckButton, completeButton, validLabel
        )
    }
    
    private func configureConstraints() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(90)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(67)
            $0.centerX.equalToSuperview()
        }
        profileEditButton.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView).offset(7)
            $0.trailing.equalTo(profileImageView).offset(12)
        }
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(59)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(60)
        }
        setCheckButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(32)
            $0.width.equalTo(91)
        }
        completeButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(55)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        validLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().inset(125)
            
        }
    }
    
    private func configureNavigation() {
        title = "내정보 수정"
        navigationController?.navigationBar.prefersLargeTitles = false
        configureBackbarButton(.dismiss)
    }
    
    private func addTargets() {
        profileEditButton.addTarget(
            self,
            action: #selector(profileEditButtonTapped),
            for: .touchUpInside
        )
        setCheckButton.addTarget(
            self,
            action: #selector(nicknameCheckButtonTapped),
            for: .touchUpInside
        )
        completeButton.addTarget(
            self,
            action: #selector(completeButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func bind() {
        viewModel.isValidRegexNickname
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { isValid in
                self.validLabel.text = isValid.message
                self.validLabel.textColor = isValid == .success ? UIColor(rgb: 0x00C271) : .myRed
                self.nicknameTextField.layer.borderColor = isValid == .success ? UIColor(rgb: 0x00C271).cgColor : UIColor.myRed?.cgColor
                self.completeButton.setNextButton(isSelected: isValid == .success)
                self.setCheckButton.backgroundColor = isValid == .success ? .hexE4E7EC : .pointColor2
                self.setCheckButton.setTitleColor(isValid != .success ? .white : .hexBEC2CA, for: .normal)
                self.setCheckButton.isUserInteractionEnabled = isValid != .success
                self.nicknameTextField.isUserInteractionEnabled = isValid != .success
            }.store(in: &subscriptions)
        
        viewModel.$isSuccessUpdate
            .sink { [weak self] isSuccess in
                if isSuccess {
                    self?.dismiss(animated: true)
                }
            }.store(in: &subscriptions)

    }
    
    @objc
    private func profileEditButtonTapped() {
        openLibrary()
    }
    
    @objc
    private func nicknameCheckButtonTapped() {
        viewModel.isValidNickname(nickname: nicknameTextField.text)
    }
    
    @objc
    private func completeButtonTapped() {
        guard let nickname = nicknameTextField.text else { return }
        viewModel.updateUser(nickname: nickname)
    }
}

extension MyPageEditViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    private func openCamera() {
        picker.sourceType = .camera
        present(picker, animated: true)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            viewModel.uploadProfileImage(image: image)
            viewModel.$uploadImageLoading
                .sink { isLoading in
                    if !isLoading {
                        self.profileImageView.image = image

                    }
                }.store(in: &subscriptions)
            dismiss(animated: true)
        }
    }
}
