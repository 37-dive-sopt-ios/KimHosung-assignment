//
//  LoginViewModel.swift
//  Baemin
//
//  Created by 김호성 on 2025.12.02.
//

import Foundation
import Combine

final class LoginViewModel {
    var email: CurrentValueSubject<String?, Never> = .init(nil)
    var password: CurrentValueSubject<String?, Never> = .init(nil)
    
    var isLoginButtonEnabled: CurrentValueSubject<Bool, Never> = .init(false)
    
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        bind()
    }
    
    private func bind() {
        Publishers.CombineLatest(email, password)
            .map({ email, password in
                Log.d("email: \(email)")
                Log.d("password: \(password)")
                return !(email?.isEmpty ?? true) && !(password?.isEmpty ?? true)
            })
            .assign(to: \.value, on: isLoginButtonEnabled)
            .store(in: &cancellables)
    }
}
