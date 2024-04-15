//
//  ProductDetailView.swift
//  HomeAssignment
//
//  Created by Ceboolion on 15/04/2024.
//

import UIKit
import RxSwift

class ProductDetailView: UIView {
    
    //MARK: - PRIVATE PROPERTIES
    private var imageView: UIImageView!
    private var textLabel: UILabel!
    private var buyButton: UIButton!
    private var stackView: UIStackView!
    private let disposeBag = DisposeBag()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupObservables()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
    }
    
    //MARK: - PUBLIC METHODS
    func configureView(with model: ProductModel) {
        configureImageView(with: model.product.image)
        configureTextLabel(with: model.product.productTitle)
        configureBuyButton()
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        imageView = UIImageView()
        textLabel = UILabel()
        stackView = UIStackView()
        buyButton = UIButton(type: .system)
        configureStackView()
        setupConstraints()
    }
    
    private func configureImageView(with image: ImageResource) {
        
        imageView.image = UIImage(resource: image)
        imageView.contentMode = .scaleAspectFit
    }
    
    private func configureTextLabel(with text: String) {
        
        textLabel.text = text
    }
    
    private func configureBuyButton() {
        
        buyButton.setTitle("Dodaj do koszyka", for: .normal)
        buyButton.setTitle("Dodaj do koszyka", for: .highlighted)
    }
    
    private func configureStackView() {
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.addSubviews(views: imageView, textLabel, buyButton)
    }
    
    private func setupConstraints() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.top.leading.equalTo(5)
            $0.trailing.equalTo(-5)
            $0.bottom.lessThanOrEqualTo(self.snp.bottom)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
    }
    
    //MARK: - RX
    private func setupObservables() {
        bindBuyButton()
    }
    
    private func bindBuyButton() {
        buyButton
            .rx
            .tap
            .bind { [weak self] in
                print("WRC bindBuyButton tapped")
            }
            .disposed(by: disposeBag)
    }

}
