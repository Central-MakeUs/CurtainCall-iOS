//
//  LodingIndicator.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/28.
//

import UIKit

final class LodingIndicator {
    static func showLoading() {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let window = windowScene.windows.last else { return }

                let loadingIndicatorView: UIActivityIndicatorView
                if let existedView = window.subviews.first(where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView {
                    loadingIndicatorView = existedView
                } else {
                    loadingIndicatorView = UIActivityIndicatorView(style: .large)
                    /// 다른 UI가 눌리지 않도록 indicatorView의 크기를 full로 할당
                    loadingIndicatorView.frame = window.frame
                    loadingIndicatorView.color = .black
                    window.addSubview(loadingIndicatorView)
                }

                loadingIndicatorView.startAnimating()
            }
        }

        static func hideLoading() {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let window = windowScene.windows.last else { return }
                window.subviews.filter({ $0 is UIActivityIndicatorView }).forEach { $0.removeFromSuperview() }
            }
        }
}
