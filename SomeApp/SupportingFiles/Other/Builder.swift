//
//  BaseViewProtocol.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 26.01.2025.
//


import Foundation
import UIKit

protocol BaseViewProtocol: AnyObject {
    associatedtype PresenterType
    var presenter: PresenterType? { get set }
}

class Builder {
    
    // Общая функция для создания view
    static private func createView<View: UIViewController & BaseViewProtocol>(viewType: View.Type, presenter: (View) -> View.PresenterType) -> UIViewController {
        let view = View()
        let presenter = presenter(view)
        view.presenter = presenter
        return view
    }
    
    static func createRegistrationView() -> UIViewController {
        return self.createView(viewType: RegistrationView.self) { view in
            RegistrationViewPresenter(view: view)
        }
    }
    
    static func createHomeView() -> UIViewController {
        let homeViewController = self.createView(viewType: HomeView.self) { view in
            HomeViewPresenter(view: view)
        }
        return UINavigationController(rootViewController: homeViewController)
    }
    
    static func createSearchView() -> UIViewController {
        return self.createView(viewType: SearchView.self) { view in
            SearchViewPresenter(view: view)
        }
    }
    
    static func createLyricsView(id: Int64, titile: String, artist: String, lyrics: String) -> UIViewController {
        return self.createView(viewType: LyricsView.self) { view in
            LyricsViewPresenter(view: view, id: id, title: titile, artist: artist, lyrics: lyrics)
        }
    }
}
