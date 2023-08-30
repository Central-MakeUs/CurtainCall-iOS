//
//  MyWriteViewController.swift
//  CurtainCall
//
//  Created by 김민석 on 2023/08/30.
//

import UIKit
import Combine

import UIKit

final class MyWriteViewController: UIViewController {
    
    // MARK: UI Property
    
    // MARK: Property
    
    private let viewModel: MyWriteViewModel
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: Life Cycle
    
    init(viewModel: MyWriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.requestMyWrite()
    }
    
    // MARK: Configure
    
    private func bind() {
        viewModel.myShowList
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                    return
                }
            } receiveValue: { value in
                print("##", value)
            }.store(in: &subscriptions)

    }
    
}
