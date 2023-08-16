//
//  NicknameSettingViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/06.
//

import Foundation
import Combine

import Moya
import CombineMoya

protocol NicknameSettingViewModelInput {
    func isValidNickname(nickname: String?)
}

protocol NicknameSettingViewModelOutput {
    var isValidRegexNickname: PassthroughSubject<NicknameValidType, Error> { get set }
}

final class NicknameSettingViewModel: NicknameSettingViewModelInput,
                                      NicknameSettingViewModelOutput {
    
    // MARK: - Properties
    
    private let nicknameProvider = MoyaProvider<SignUpAPI>()
    private let usecase: NicknameSettingUsecase
    private var cancellables = Set<AnyCancellable>()
    
    var isValidRegexNickname = PassthroughSubject<NicknameValidType, Error>()
    
    // MARK: - Life Cycle
    
    init(usecase: NicknameSettingUsecase) {
        self.usecase = usecase
    }
    
    // MARK: - Helpers
    
    func isValidNickname(nickname: String?) {
        guard let nickname else { return }
        guard !nickname.contains(" ") else {
            isValidRegexNickname.send(.blank)
            return
        }
        guard (6...15) ~= nickname.count else {
            isValidRegexNickname.send(.length)
            return
        }
        guard nickname.isValidRegex("^[0-9a-zA-Zㄱ-ㅎ가-힇]*$") else {
            isValidRegexNickname.send(.invalidForm)
            return
        }
        nicknameProvider.requestPublisher(.duplicate(nickname))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { response in
                if let data = try? response.map(NicknameDuplicateResponse.self) {
                    if !data.result {
                        self.isValidRegexNickname.send(.success)
                    } else {
                        self.isValidRegexNickname.send(.isDuplicated)
                    }
                    
                }
            }.store(in: &cancellables)

        
        
//        usecase.isValidNickname(nickname: nickname)
//            .sink { [weak self] validType in
//                self?.isValidRegexNickname.send(validType)
//            }.store(in: &cancellables)
    }
}
