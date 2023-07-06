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
}
