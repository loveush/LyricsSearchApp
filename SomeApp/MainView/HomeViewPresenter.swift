//
//  HomeViewPresenter.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//

import Foundation

protocol HomeViewPresenterProtocol: AnyObject {
    var greeting: String { get }
}

class HomeViewPresenter: HomeViewPresenterProtocol {
    weak var view: (any HomeViewProtocol)?
    
    init(view: any HomeViewProtocol) {
        self.view = view
    }
    
    private let userName = String(UserDefaults.standard.string(forKey: "name") ?? "User")
    lazy var greeting = "Hello, \(userName)!"

}
