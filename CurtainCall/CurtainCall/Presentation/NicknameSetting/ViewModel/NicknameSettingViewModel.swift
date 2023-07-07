//
//  NicknameSettingViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/06.
//

import Foundation
import Combine

protocol NicknameSettingViewModelInput {
    func isValidNickname(nickname: String?)
}

protocol NicknameSettingViewModelOutput {
    var isValidRegexNickname: PassthroughSubject<NicknameValidType, Never> { get set }
}

final class NicknameSettingViewModel: NicknameSettingViewModelInput,
                                      NicknameSettingViewModelOutput {
    
    // MARK: - Properties
    
    private let usecase: NicknameSettingUsecase
    private var cancellables = Set<AnyCancellable>()
    var isValidRegexNickname = PassthroughSubject<NicknameValidType, Never>()
    
    // MARK: - Life Cycle
    
    init(usecase: NicknameSettingUsecase) {
        self.usecase = usecase
    }
    
    // MARK: - Helpers
    
    func isValidNickname(nickname: String?) {
        guard let nickname else { return }
        usecase.isValidNickname(nickname: nickname)
            .sink { [weak self] validType in
                self?.isValidRegexNickname.send(validType)
            }.store(in: &cancellables)
    }
}
