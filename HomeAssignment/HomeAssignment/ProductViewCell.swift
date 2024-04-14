//
//  ProductViewCell.swift
//  HomeAssignment
//
//  Created by Ceboolion on 14/04/2024.
//

import UIKit

class ProductViewCell: UITableViewCell {
    
    //MARK: - PRIVATE PROPERTIES
    private var productImageView: UIImageView!
    private var productTitleLabel: UILabel!
    private var productPriceLabel: UILabel!
    private var productBuyButton: UIButton!
    private var stackView: UIStackView!
    
    private let productImageHeight: CGFloat = 80

    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    func configureCell(with productType: ProductType, productPrice: String) {
        configureImageView(with: productType)
        configureProductTitle(for: productType)
        configureProductPriceLabel(for: productType, price: productPrice)
        configureStackView()
        setupConstraints()
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
    }
    
    private func configureProductPriceLabel(for productType: ProductType, price: String) {
        productPriceLabel = UILabel()
        productPriceLabel.text = price
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
   
    
}

extension UIStackView {
    func addSubviews(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
