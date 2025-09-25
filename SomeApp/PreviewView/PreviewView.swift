import UIKit

class PreviewView: UIViewController {
    var state: WindowCase = .reg
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "opticaldisc")
        imageView.tintColor = .geniusYellow
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        imageView.rotate()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let stateRaw = UserDefaults.standard.string(forKey: "state")  {
                if let state = WindowCase(rawValue: stateRaw) {
                    self.state = state
                }
            }
            NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.windowInfo: self.state])
        }
    }
}
