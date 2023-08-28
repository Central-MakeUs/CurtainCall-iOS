//
//  PartyMemberRecruitingContentViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/17.
//

import Foundation
import Combine

import CombineMoya
import Moya

final class PartyMemberRecruitingContentViewModel {
    
    // MARK: - Properties
    
    @Published var isValidTitle: Bool = false
    @Published var isValidContent: Bool = false
    @Published var isSuccessCreateParty: Bool = false
    
    private let provider = MoyaProvider<PartyAPI>()
    private var subscriptions: Set<AnyCancellable> = []
    
    var isValid: AnyPublisher<Bool, Never> {
        return $isValidTitle.combineLatest($isValidContent) {
            return $0 && $1
        }.eraseToAnyPublisher()
    }
    
    // MARK: - Helpers
    
    func titleTextFieldChanged(text: String?) {
        guard let text, !text.isEmpty,
              text != Constants.PARTY_MEMBER_PRODUCT_TITLE_TEXTFIELD_PLACEHOLDER else {
            isValidTitle = false
            return
        }
        isValidTitle = true
    }
    
    func contentTextViewChanged(text: String?) {
        guard let text, !text.isEmpty,
               text != Constants.PARTY_MEMBER_PRODUCT_CONTENT_TEXTVIEW_PLACEHOLDER else {
            isValidContent = false
            return
        }
        isValidContent = true
    }
    
    func requestCreateParty(body: CreatePartyBody) {
        provider.requestPublisher(.create(body: body))
            .sink { completion in
                if case let .failure(error) = completion {
                    return
                }
            } receiveValue: { [weak self] response in
                self?.isSuccessCreateParty = true
            }.store(in: &subscriptions)
    }
    
    
}
