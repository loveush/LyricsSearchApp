import UIKit

enum WindowCase: String {
    case reg, main
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
        guard let userInfo = notification.userInfo as? [String: WindowCase],
              let window = userInfo[.windowInfo] else { return }
        
        switch window {
        case .reg:
            self.window?.rootViewController = Builder.createRegistrationView()
        case .main:
            self.window?.rootViewController = Builder.createHomeView()
        }
    }
}

