//
//  PartyMemberRecruitingProductViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/13.
//

import Foundation
import Combine

import CombineMoya
import Moya

final class PartyMemberRecruitingProductViewModel {
    
    // MARK: - Properties

    var productSelectInfo = CurrentValueSubject<[ProductSelectInfo], Error>([])
    var isSelectProduct = CurrentValueSubject<Bool, Never>(false)
    private var cancellables: Set<AnyCancellable> = []
    private let provider = MoyaProvider<ProductAPI>()
    @Published var playList: [ProductListContentHaveSelected] = []
    @Published var musicalList: [ProductListContentHaveSelected] = []
    var isLoding = false
    var theaterPage: Int = 0
    var musicalPage: Int = 0
    
    // MARK: - Lifecycles
    
    // MARK: - Helpers
    
    func requestProductSelectInfo(page: Int, size: Int, genre: ProductListAPI) {
        provider.requestPublisher(.list(page: page, size: size, genre: genre))
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                if let data = try? response.map(ProductListResponse.self) {
                    let newData = data.content.map {
                        ProductListContentHaveSelected(
                            id: $0.id,
                            name: $0.name,
                            startDate: $0.startDate,
                            endDate: $0.endDate,
                            facilityName: $0.facilityName,
                            poster: $0.poster,
                            genre: $0.genre,
                            showTimes: $0.showTimes,
                            runtime: $0.runtime,
                            reviewCount: $0.reviewCount,
                            reviewGradeSum: $0.reviewGradeSum,
                            isSelected: false
                        )
                        
                    }
                    if genre == .play {
                        if page == 0 {
                            playList = newData
                        } else {
                            playList.append(contentsOf: newData)
                        }
                    } else {
                        if page == 0 {
                            musicalList = newData
                        } else {
                            musicalList.append(contentsOf: newData)
                        }
                    }
                }
            }.store(in: &cancellables)
    }
    
    func didSelectProduct(_ item: ProductListContentHaveSelected, genre: ProductListAPI) {
        
        if genre == .play {
            isSelectProduct.send(!playList.filter { $0.isSelected }.isEmpty)
            let newValue = playList.map {
                ProductListContentHaveSelected(
                    id: $0.id,
                    name: $0.name,
                    startDate: $0.startDate,
                    endDate: $0.endDate,
                    facilityName: $0.facilityName,
                    poster: $0.poster,
                    genre: $0.genre,
                    showTimes: $0.showTimes,
                    runtime: $0.runtime,
                    reviewCount: $0.reviewCount,
                    reviewGradeSum: $0.reviewGradeSum,
                    isSelected: $0 == item
                )
                
            }
            playList = newValue
            isSelectProduct.send(!newValue.filter { $0.isSelected }.isEmpty)
        } else {
            isSelectProduct.send(!musicalList.filter { $0.isSelected }.isEmpty)
            let newValue = musicalList.map {
                ProductListContentHaveSelected(
                    id: $0.id,
                    name: $0.name,
                    startDate: $0.startDate,
                    endDate: $0.endDate,
                    facilityName: $0.facilityName,
                    poster: $0.poster,
                    genre: $0.genre,
                    showTimes: $0.showTimes,
                    runtime: $0.runtime,
                    reviewCount: $0.reviewCount,
                    reviewGradeSum: $0.reviewGradeSum,
                    isSelected: $0 == item
                )
                
            }
            musicalList = newValue
            isSelectProduct.send(!newValue.filter { $0.isSelected }.isEmpty)
        }
    }
}
