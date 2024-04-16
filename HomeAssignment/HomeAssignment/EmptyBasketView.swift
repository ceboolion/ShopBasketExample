import UIKit
import SnapKit
import RxSwift
import RxCocoa

class EmptyBasketView: UIView {
    
    private var emptyBasketButton: UIButton!
    
    private let disposeBag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        configureEmptyBasketButton()
        configureConstraints()
        setupObservers()
    }
    
    private func configureEmptyBasketButton() {
        let configuration = UIImage.SymbolConfiguration(paletteColors: [.green, .lightGray])
        let image = UIImage(systemName: "cart.fill.badge.plus")?.withConfiguration(configuration)
        emptyBasketButton = UIButton(type: .system)
        emptyBasketButton.setImage(image, for: .normal)
        emptyBasketButton.setImage(image, for: .highlighted)
        emptyBasketButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 100), forImageIn: .normal)
    }
    
    private func configureConstraints() {
        addSubview(emptyBasketButton)
        emptyBasketButton.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
        }
    }
    
    private func setupObservers() {
        bindEmptyBasketButtonImageView()
    }
    
    private func bindEmptyBasketButtonImageView() {
        emptyBasketButton
            .rx
            .tap
            .bind { [weak self] in
                print("WRC emptyBasketButton tapped")
            }
            .disposed(by: disposeBag)
    }
    
    
}
