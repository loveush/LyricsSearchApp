//
//  HomeViewPresenter.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import Foundation

protocol HomeViewPresenterProtocol: AnyObject {
    var greeting: String { get }
    func navigateToSearchView()
}

class HomeViewPresenter: HomeViewPresenterProtocol {
    weak var view: (any HomeViewProtocol)?
    
    init(view: any HomeViewProtocol) {
        self.view = view
    }
    
    private let userName = String(UserDefaults.standard.string(forKey: "name") ?? "User")
    lazy var greeting = "Hello, \(userName)!"

    func navigateToSearchView() {
        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: WindowCase.search])
    }

}
