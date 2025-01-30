//
//  SceneDelegate.swift
//  SomeApp
//
//  Created by Любовь Ушакова on 24.01.2025.
//

import UIKit

enum WindowCase {
    case reg, main, search, song
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Получатель
        NotificationCenter.default.addObserver(self, selector: #selector(windowManager), name: .windowManager, object: nil)
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = PreviewView()
        self.window?.makeKeyAndVisible()
    }
    
    // Обработчик
    @objc func windowManager(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any], 
              let window = userInfo[.windowInfo] as? WindowCase else { return }
        
        switch window {
        case .reg:
            self.window?.rootViewController = Builder.createRegistrationView()
        case .main:
            self.window?.rootViewController = Builder.createHomeView()
        case .search:
            self.window?.rootViewController = Builder.createSearchView()
        case .song:
            if let song = userInfo["selectedSong"] as? Song {  // Safely cast the song
                self.window?.rootViewController = Builder.createLyricsView(song: song)
            } else {
                print("Error: Could not retrieve selected song.")
            }
        }
    }
}

