//
//  MyPageEditViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/25.
//

import Foundation
import Combine

import Moya
import CombineMoya
import UIKit

final class MyPageEditViewModel {
    private let nicknameProvider = MoyaProvider<SignUpAPI>()
    
    private var cancellables = Set<AnyCancellable>()
    
    var isValidRegexNickname = PassthroughSubject<NicknameValidType, Error>()
    var imageID: Int?
    @Published var uploadImageLoading = true
    @Published var isSuccessUpdate = false
    
    // MARK: - Life Cycle

    
    // MARK: - Helpers
    
    func isValidNickname(nickname: String?) {
        guard let nickname else { return }
        guard !nickname.contains(" ") else {
            isValidRegexNickname.send(.blank)
            return
        }
        guard (2...15) ~= nickname.count else {
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
    
    func uploadProfileImage(image: UIImage) {
        uploadImageLoading = true
        guard let data = image.jpegData(compressionQuality: 0.7) else {
            print("IMAGE CONVERT TO DATA ERROR")
            return
        }
        let imageProvier = MoyaProvider<ImageAPI>()
        imageProvier.requestPublisher(.request(image: data))
            .sink { completion in
                if case let .failure(error) = completion {
                    print("IMAGE UPLOAD ERROR", error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                print(String(data: response.data, encoding: .utf8))
                if let data = try? response.map(UploadImageResponse.self) {
                    self?.imageID = data.id
                    self?.uploadImageLoading = false
                }
            }.store(in: &cancellables)

    }
    
    func updateUser(nickname: String) {
        let provider = MoyaProvider<MyPageAPI>()
        provider.requestPublisher(.updateProfile(body: UpdateMyPageBody(nickname: nickname, imageId: imageID)))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                self?.isSuccessUpdate = response.statusCode == 200
            }.store(in: &cancellables)

    }
}
