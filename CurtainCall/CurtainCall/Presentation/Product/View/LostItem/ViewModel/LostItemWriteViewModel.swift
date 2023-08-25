//
//  LostItemWriteViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/06.
//

import Foundation
import Combine

import CombineMoya
import Moya
import SwiftKeychainWrapper

final class LostItemWriteViewModel {
    @Published var isTitleWrite = false
    @Published var isCategoryWrite = false
    @Published var isKeepDateWrite = false
    @Published var isAddFile = false
    
    @Published var uploadImageLoading = false
    var imageID: Int?
    var selectedDate: Date?
    var selectedTime: Date?
    let imageProvier = MoyaProvider<ImageAPI>()
    var selectCategory: LostItemCategoryType?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    func titleTextFieldChanged(text: String?) {
        guard let text, !text.isEmpty else {
            isTitleWrite = false
            return
        }
        isTitleWrite = true
        
        var isValid = $isTitleWrite.combineLatest($isCategoryWrite, $isKeepDateWrite, $isAddFile)
            .eraseToAnyPublisher()
    }
    
    func selectDate(date: Date) {
        selectedDate = date
        isKeepDateWrite = true
    }
    
    func selectTime(date: Date) {
        selectedTime = date
    }
    
    func addFile(data: Data) {
        uploadImageLoading = true
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
                    self?.isAddFile = true
                    self?.uploadImageLoading = false
                }
            }.store(in: &subscriptions)
    }
    
    func uploadLostItem(
        title: String,
        id: String,
        detail: String?,
        particulars: String
    ) {
        let provider = MoyaProvider<LostItemService>()
        guard let type = selectCategory,
              let foundDate = selectedDate,
              let imageId = imageID else { return }
        let foundTime = selectedTime == nil ? nil : selectedTime!.convertToHourMinString()
        let body = CreateLostItemBody(
            title: title,
            type: type.apiName,
            facilityId: id,
            foundPlaceDetail: detail ?? "",
            foundDate: foundDate.convertToAPIDateYearMonthDayString(),
            foundTime: foundTime,
            particulars: particulars == Constants.LOSTITEM_OTHER_CONTENT_PLACEHOLDER ? "없음" : particulars,
            imageId: imageId
        )
        print("##분실물 body", body)
        provider.requestPublisher(.create(body: body))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                    return
                }
            } receiveValue: { [weak self] response in
                print("##분실물 생성", String(data: response.data, encoding: .utf8))
            }.store(in: &subscriptions)

    }
}
