//
//  ProductViewCell.swift
//  HomeAssignment
//
//  Created by Ceboolion on 14/04/2024.
//

import UIKit
import RxSwift

class ProductViewCell: UITableViewCell {
    
    //MARK: - PRIVATE PROPERTIES
    private var productImageView: UIImageView!
    private var productTitleLabel: UILabel!
    private var productPriceLabel: UILabel!
    private var productBuyButton: UIButton!
    private var stackView: UIStackView!
    private var productId: UUID?
    
    private let productImageHeight: CGFloat = 80
    
    private let disposeBag = DisposeBag()

    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - OVERRIDDEN METHODS
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    //MARK: - PUBLIC METHODS
    func configureCell(with model: ProductModel) {
        productId = model.id
        configureImageView(with: model.product)
        configureProductTitle(for: model.product)
        configureProductPriceLabel(for: model)
        configureProductBuyButton()
        configureStackView()
        setupConstraints()
        setupObservers()
    }
    
    //MARK: - PRIVATE METHODS
    private func configureUI() {
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 25
    }
    
    private func configureImageView(with productType: ProductType) {
        productImageView = UIImageView()
        productImageView.image = UIImage(resource: productType.image)
    }
    
    private func configureProductTitle(for productType: ProductType) {
        productTitleLabel = UILabel()
        productTitleLabel.text = productType.productTitle
        productTitleLabel.textColor = .black
    }
    
    private func configureProductPriceLabel(for model: ProductModel) {
        productPriceLabel = UILabel()
        productPriceLabel.text = model.productPrice.formatted(.currency(code: "USD")) + model.unitOfMeasure.name
        productPriceLabel.textColor = .black
    }
    
    private func configureProductBuyButton() {
        productBuyButton = UIButton(type: .system)
        productBuyButton.setTitle("Kup", for: .normal)
        productBuyButton.setTitle("Kup", for: .highlighted)
    }
    
    private func configureStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .fill        
        stackView.addSubviews(views: productTitleLabel, productPriceLabel, productBuyButton)
    }
    
    private func setupConstraints() {
        addSubview(productImageView)
        addSubview(stackView)
        
        productImageView.snp.makeConstraints {
            $0.top.leading.equalTo(5)
            $0.width.height.equalTo(productImageHeight)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(5)
            $0.leading.equalTo(productImageView.snp.trailing).offset(5)
            $0.bottom.trailing.equalTo(-5)
            $0.height.equalTo(productImageHeight)
        }
    }
    
    //MARK: - RX
    private func setupObservers() {
        bindBuyButton()
    }
    
    private func bindBuyButton() {
        productBuyButton
            .rx
            .tap
            .bind { [weak self] in
                print("WRC productBuyButton tapped")
            }
            .disposed(by: disposeBag)
    }
   
    
}
