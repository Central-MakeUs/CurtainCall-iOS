//
//  ReportViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/15.
//

import Foundation
import Combine

import CombineMoya
import Moya

final class ReportViewModel {
    
    @Published var isChecked: Bool = false
    var isSuccessReport = PassthroughSubject<Bool, Never>()
    private let id: Int
    private var subscriptions: Set<AnyCancellable> = []
    
    init(id: Int) {
        self.id = id
    }
    
    func isCheckReport(tag: [Int]) {
        isChecked = !tag.isEmpty
    }
    
    func requestReport(index: Int, content: String) {
        let reason = ReportType.allCases[index]
        let provider = MoyaProvider<ReportAPI>()
        provider.requestPublisher(.party(body: PartyReportBody(partyId: id, reason: reason, content: content)))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                self?.isSuccessReport.send(response.statusCode == 200) 
            }.store(in: &subscriptions)

    }
}
