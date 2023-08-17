//
//  UIViewController + Extension.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/07/04.
//

import UIKit

extension UIViewController {
    func changeRootViewController(_ rootViewController: UIViewController) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = rootViewController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            rootViewController.modalPresentationStyle = .overFullScreen
            self.present(rootViewController, animated: true, completion: nil)
        }
    }
    
    func hideKeyboardWhenTappedArround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// Alert 띄우는 메서드
    /// - Parameters:
    ///   - title: 제목
    ///   - message: 메시지
    ///   - isCancelActionInclude: 취소 포함 여부
    ///   - style: AlertStyle
    ///   - handler: 확인 누른 후 작동될 액션
    func presentAlert(
        title: String,
        message: String? = nil,
        isCancelActionIncluded: Bool = false,
        preferredStyle style: UIAlertController.Style = .alert,
        handler: ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionDone = UIAlertAction(title: "확인", style: .default, handler: handler)
        alert.addAction(actionDone)
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func configureBackbarButton(_ exitType: ExitType = .pop) {
//        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.hidesBackButton = true
        let backImage = UIImage(named: ImageNamespace.navigationBackButton)
        let backBarbuttonItem = UIBarButtonItem(
            image: backImage,
            style: .plain,
            target: self,
            action: exitType == .pop ? #selector(popView) : #selector(dismissView)
        )
        navigationItem.leftBarButtonItem = backBarbuttonItem
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc
    func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func dismissView() {
        dismiss(animated: true)
    }
    
    enum ExitType {
        case pop
        case dismiss
    }
}
