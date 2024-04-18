import UIKit
import SnapKit
import RxSwift
import RxCocoa

class EmptyBasketView: UIView {
    
    //MARK: - PUBLIC PROPERTIES
    var onTapClosure: (() -> Void)?
    
    //MARK: - PRIVATE PROPERTIES
    private var emptyBasketButton: UIButton!
    private var textLabel: UILabel!
    private var messageLabel: UILabel!
    private var shopButton: UIButton!
    private let disposeBag = DisposeBag()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        configureEmptyBasketButton()
        configureTextLabel()
        configureMessageLabel()
        configureShopButton()
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
    
    private func configureShopButton() {
        shopButton = .init(type: .system)
        shopButton.setTitle("Wrzuć coś :)", for: .normal)
        shopButton.setTitle("Wrzuć coś :)", for: .highlighted)
        shopButton.setTitleColor(.white, for: .normal)
        shopButton.setTitleColor(.lightGray, for: .highlighted)
        shopButton.backgroundColor = .accent
        shopButton.clipsToBounds = true
        shopButton.layer.cornerRadius = 9
    }
    
    private func configureConstraints() {
        addSubview(emptyBasketButton)
        addSubview(textLabel)
        addSubview(messageLabel)
        addSubview(shopButton)
        
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
        
        shopButton.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(16)
            $0.centerX.equalTo(snp.centerX)
            $0.width.equalTo(200)
            $0.height.equalTo(44)
        }
    }
    
    private func setupObservers() {
        bindEmptyBasketButtonImageView()
        bindShopButton()
    }
    
    private func bindEmptyBasketButtonImageView() {
        emptyBasketButton
            .rx
            .tap
            .bind { [weak self] in
                self?.onTapClosure?()
            }
            .disposed(by: disposeBag)
    }
    
    private func bindShopButton() {
        shopButton
            .rx
            .tap
            .bind { [weak self] in
                self?.onTapClosure?()
            }
            .disposed(by: disposeBag)
    }
    
    
}
