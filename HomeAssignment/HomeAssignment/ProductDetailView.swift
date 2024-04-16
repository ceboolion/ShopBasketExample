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
    private var quantityLabel: UILabel!
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
    
    //MARK: - PUBLIC METHODS
    func configureView(with model: ProductModel) {
        configureImageView(with: model.product.image)
        configureTextLabel(with: model.product.productTitle)
        configureQuantityLabel(from: model)
        configureBuyButton()
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        backgroundColor = .systemBackground
        imageView = UIImageView()
        textLabel = UILabel()
        quantityLabel = UILabel()
        buyButton = UIButton(type: .system)
        stackView = UIStackView()
        configureStackView()
        setupConstraints()
    }
    
    private func configureImageView(with image: ImageResource) {
        imageView.image = UIImage(resource: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    private func configureTextLabel(with text: String) {
        textLabel.text = text
    }
    
    private func configureQuantityLabel(from model: ProductModel) {
        var text = ""
        if model.unitOfMeasure == .dozen {
            text = "Dostępne: \(model.itemsAvailable / 12) \(model.getItemsQuantity())"
        } else {
            text = "Dostępne: \(model.itemsAvailable) \(model.getItemsQuantity())"
        }
        quantityLabel.text = text
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
        stackView.addSubviews(views: imageView, textLabel, quantityLabel, buyButton, UIView())
    }
    
    private func setupConstraints() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(12)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(400)
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
