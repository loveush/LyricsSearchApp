import UIKit

final class CustomBackButton: UIButton {
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .semibold, scale: .default)
        setImage(UIImage(systemName:"arrow.left")?
            .withConfiguration(config)
            .withTintColor(.geniusYellow), for: .normal)
        
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
