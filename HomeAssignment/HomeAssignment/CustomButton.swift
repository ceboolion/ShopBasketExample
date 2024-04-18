import UIKit

class CustomButton: UIButton {
    
    //MARK: - PUBLIC PROPERTIES
    var onTap: (() -> Void)?
    
    //MARK: - OVERRIDDEN METHODS
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let isHighlighted = self?.isHighlighted else { return }
                self?.alpha = isHighlighted ? 0.5 : 1
            }
        }
    }
    
    //MARK: - PRIVATE METHODS
    @objc
    private func onTapButton() {
        onTap?()
    }
    
}
