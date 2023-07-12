//
//  PartyMemberRecruitingProductViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/13.
//

import Foundation
import Combine

final class PartyMemberRecruitingProductViewModel {
    
    // MARK: - Properties
    private let usecase: PartyMemberRecruitingProductUsecase
    var productSelectInfo = PassthroughSubject<[ProductSelectInfo], Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Lifecycles
    
    init(usecase: PartyMemberRecruitingProductUsecase) {
        self.usecase = usecase
    }
    
    // MARK: - Helpers
    
    func requestProductSelectInfo() {
        usecase.execute()
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.productSelectInfo.send(completion: .failure(error))
                }
            } receiveValue: { [weak self] result in
                self?.productSelectInfo.send(result)
            }.store(in: &cancellables)
    }
}
