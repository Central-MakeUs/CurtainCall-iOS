//
//  OnboardingViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/05.
//

import Foundation
import Combine

protocol OnboardingViewModelInput {
    func scrollPage(x: Double, width: Double)
}

protocol OnboardingViewModelOutput {
    var currentPage: Int { get set }
}

final class OnboardingViewModel: OnboardingViewModelInput, OnboardingViewModelOutput {
    
    // MARK: - Properties
    
    @Published var currentPage: Int = 0
    
    // MARK: - Helpers
    
    func scrollPage(x: Double, width: Double) {
        currentPage = Int((x / width).rounded(.up))
    }
    
}
