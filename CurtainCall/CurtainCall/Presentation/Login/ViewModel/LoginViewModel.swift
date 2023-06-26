//
//  LoginViewModel.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/06/26.
//

import Foundation

protocol LoginViewModelInput {
    func didTappedLoginButton(tag: Int)
}

final class LoginViewModel: LoginViewModelInput {
    
    func didTappedLoginButton(tag: Int) {
        switch tag {
        case LoginButtonTag.kakaoTag:
            print("kakaoLogin Tapped")
        case LoginButtonTag.naverTag:
            print("naverLogin Tapped")
        case LoginButtonTag.facebookTag:
            print("facebookLogin Tapped")
        case LoginButtonTag.appleTag:
            print("appleLogin Tapped")
        default:
            fatalError("Login Tag invalid")
        }
    }
    
}
