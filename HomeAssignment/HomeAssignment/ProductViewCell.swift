import UIKit
import RxSwift

class ProductViewCell: UITableViewCell {
    
    //MARK: - PRIVATE PROPERTIES
    private var productData: ProductModel?
    private var productImageView: UIImageView!
    private var productTitleLabel: UILabel!
    private var productPriceLabel: UILabel!
    private var productAvailabilityNumber: UILabel!
    private var productBuyButton: UIButton!
    private var stackView: UIStackView!
//    private var minusButton: UIButton!
//    private var buyQuantityLabel: UILabel!
//    private var plusButton: UIButton!
    private var productQuantityStackView: UIStackView!
    private var quantityManagementView: QuantityManagementView!
    
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
        productData = model
        configureImageView(with: model.product)
        configureProductTitle(for: model.product)
        configureProductPriceLabel(for: model)
        configureProductAvailabilityLabel()
        configureProductBuyButton()
        configureQuantityManagementView()
        configureProductQuantityStackView()
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
        productTitleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        productTitleLabel.minimumScaleFactor = 0.6
    }
    
    private func configureProductPriceLabel(for model: ProductModel) {
        productPriceLabel = UILabel()
        productPriceLabel.text = model.productPrice.formatted(.currency(code: "USD")) + model.unitOfMeasure.name
        productPriceLabel.font = .systemFont(ofSize: 14, weight: .regular)
        productTitleLabel.minimumScaleFactor = 0.6
    }
    
    private func configureProductAvailabilityLabel() {
        productAvailabilityNumber = UILabel()
        productAvailabilityNumber.text = getProductAvailabilityNumber(productsNumber: 0)
        productAvailabilityNumber.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    private func configureProductBuyButton() {
        productBuyButton = UIButton(type: .system)
        productBuyButton.setTitle("Kup", for: .normal)
        productBuyButton.setTitle("Kup", for: .highlighted)
    }
    
    private func configureQuantityManagementView() {
        quantityManagementView = QuantityManagementView(productData: productData)
    }
    
    private func configureProductQuantityStackView() {
        productQuantityStackView = UIStackView()
        productQuantityStackView.axis = .horizontal
        productQuantityStackView.alignment = .center
        productQuantityStackView.spacing = 6
        productQuantityStackView.addSubviews(views: productBuyButton, UIView(), quantityManagementView)
    }
    
    private func configureStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.addSubviews(views: productTitleLabel, productPriceLabel, productAvailabilityNumber,  productQuantityStackView)
    }
    
    private func setupConstraints() {
        contentView.addSubview(productImageView)
        contentView.addSubview(stackView)
        
        productImageView.snp.makeConstraints {
            $0.top.leading.equalTo(5)
            $0.width.height.equalTo(productImageHeight)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(5)
            $0.leading.equalTo(productImageView.snp.trailing).offset(10)
            $0.bottom.trailing.equalTo(-5)
        }
        
        productQuantityStackView.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
    }
    
    //MARK: - RX
    private func setupObservers() {
        bindBuyButton()
        bindNumberOfChosenProducts()
    }
    
    private func bindBuyButton() {
        productBuyButton
            .rx
            .tap
            .bind { [weak self] in
                print("WRC productBuyButton tapped in cell")
                
            }
            .disposed(by: disposeBag)
    }
    
    private func bindNumberOfChosenProducts() {
        ShoppingBasket.shared.basketItems
            .bind { [weak self] data in
                print("WRC ShoppingBasket data: \(data)")
                if let productIndex = data.firstIndex(where: {$0.id == self?.productData?.id}) {
//                    self?.buyQuantityLabel.text = "\(Int(data[productIndex].numberOfChosenProducts))"
                    self?.setProductAvailabilityNumber(productsNumber: data[productIndex].numberOfChosenProducts.asInt())
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setProductAvailabilityNumber(productsNumber: Int) {
        productAvailabilityNumber.text = getProductAvailabilityNumber(productsNumber: productsNumber)
    }
    
    private func getProductAvailabilityNumber(productsNumber: Int) -> String {
        guard let productData else { return " - "}
        let availabilityNumber = productData.itemsAvailable - productsNumber
        return "Dostępne: \(availabilityNumber)"
    }
}
