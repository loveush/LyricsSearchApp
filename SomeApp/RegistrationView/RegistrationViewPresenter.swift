//
//  RegistrationPresenter.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import Foundation

protocol RegistrationViewPresenterProtocol: AnyObject {
    func checkName(name: String)
}

class RegistrationViewPresenter: RegistrationViewPresenterProtocol {
    weak var view: (any RegistrationViewProtocol)?
    
    init(view: any RegistrationViewProtocol) {
        self.view = view
    }
    
    func checkName(name: String) {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            print("error")
            return
        }
        
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(WindowCase.main.rawValue, forKey: "state")
        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: WindowCase.main])
    }
}
