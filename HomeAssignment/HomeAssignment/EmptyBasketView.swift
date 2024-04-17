import UIKit
import SnapKit
import RxSwift
import RxCocoa

class EmptyBasketView: UIView {
    
    private var emptyBasketButton: UIButton!
    private var textLabel: UILabel!
    private var messageLabel: UILabel!
    
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
        configureTextLabel()
        configureMessageLabel()
        configureConstraints()
        setupObservers()
    }
    
    private func configureEmptyBasketButton() {
        let configuration = UIImage.SymbolConfiguration(paletteColors: [.accent, .lightGray])
        let image = UIImage(systemName: "cart.fill.badge.plus")?.withConfiguration(configuration)
        emptyBasketButton = UIButton(type: .system)
        emptyBasketButton.setImage(image, for: .normal)
        emptyBasketButton.setImage(image, for: .highlighted)
        emptyBasketButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 100), forImageIn: .normal)
    }
    
    private func configureTextLabel() {
        textLabel = .init()
        textLabel.text = "Twój koszyk jest pusty"
        textLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        textLabel.textAlignment = .center
    }
    
    private func configureMessageLabel() {
        messageLabel = .init()
        messageLabel.text = "Nie czekaj! Wrzuć coś do koszyka!"
        messageLabel.font = .systemFont(ofSize: 14, weight: .regular)
        messageLabel.textAlignment = .center
    }
    
    private func configureConstraints() {
        addSubview(emptyBasketButton)
        addSubview(textLabel)
        addSubview(messageLabel)
        emptyBasketButton.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
        }
        textLabel.snp.makeConstraints {
            $0.top.equalTo(emptyBasketButton.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
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
