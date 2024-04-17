import UIKit
import RxSwift

class ProductViewCell: UITableViewCell {
    
    var onTap: ((BasketUpdateType, ProductModel) -> Void)?
    
    //MARK: - PRIVATE PROPERTIES
    private var productData: ProductModel = .init(product: .none, 
                                                  productPrice: 0,
                                                  itemsAvailable: 0,
                                                  unitOfMeasure: .none)
    private var productImageView: UIImageView!
    private var productTitleLabel: UILabel!
    private var productPriceLabel: UILabel!
    private var productAvailabilityNumber: UILabel!
    private var productBuyButton: UIButton!
    private var stackView: UIStackView!
    private var productQuantityStackView: UIStackView!
    private var quantityManagementView: QuantityManagementView!
    
    private let productImageHeight: CGFloat = 80
    private var disposeBag = DisposeBag()

    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
        super.prepareForReuse()
    }
    
    //MARK: - OVERRIDDEN METHODS
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    //MARK: - PUBLIC METHODS
    func configureCell(with model: ProductModel) {
        productData = model
        setImageViewImage()
        setProductTitleText()
        setProductPriceLabelText()
        setProductAvailabilityLabelText()
    }
    
    //MARK: - PRIVATE METHODS
    private func updateUI() {
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 25
    }
    
    private func configureUI() {
        configureProductImageView()
        configureProductTitleLabel()
        configureProductPriceLabel()
        configureProductAvailabilityNumber()
        configureProductBuyButton()
        configureQuantityManagementView()
        configureProductQuantityStackView()
        configureStackView()
        setupConstraints()
        setupObservers()
    }
    
    private func configureProductImageView() {
        productImageView = .init()
        productImageView.contentMode = .scaleAspectFit
        productImageView.backgroundColor = .white
    }
    
    private func configureProductTitleLabel() {
        productTitleLabel = .init()
        productTitleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        productTitleLabel.minimumScaleFactor = 0.6
    }
    
    private func configureProductPriceLabel() {
        productPriceLabel = .init()
        productPriceLabel.font = .systemFont(ofSize: 14, weight: .regular)
        productTitleLabel.minimumScaleFactor = 0.6
        productTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureProductAvailabilityNumber() {
        productAvailabilityNumber = .init()
        productAvailabilityNumber.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    private func configureQuantityManagementView() {
        quantityManagementView = .init()
        quantityManagementView.onButtonTap = { [weak self] updateType in
            guard let data = self?.productData else { return }
            self?.onTap?(updateType, data)
        }
    }
    
    private func configureProductBuyButton() {
        productBuyButton = UIButton(type: .system)
        productBuyButton.setTitle("Kup", for: .normal)
        productBuyButton.setTitle("Kup", for: .highlighted)
    }
    
    private func configureProductQuantityStackView() {
        productQuantityStackView = .init()
        productQuantityStackView.axis = .horizontal
        productQuantityStackView.alignment = .center
        productQuantityStackView.spacing = 6
        productQuantityStackView.addSubviews(views: productBuyButton, UIView(), quantityManagementView)
    }
    
    private func configureStackView() {
        stackView = .init()
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
            $0.top.leading.equalTo(16)
            $0.width.height.equalTo(productImageHeight)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(16)
            $0.leading.equalTo(productImageView.snp.trailing).offset(10)
            $0.bottom.trailing.equalTo(-8)
        }
        
        productQuantityStackView.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
        }
    }
    
    private func setImageViewImage() {
        productImageView.image = UIImage(resource: productData.product.image)
    }
    
    private func setProductTitleText() {
        productTitleLabel.text = productData.product.productTitle
    }
    
    private func setProductPriceLabelText() {
        productPriceLabel.text = productData.productPrice.formatted(.currency(code: "USD")) + productData.unitOfMeasure.name
    }
    
    private func setProductAvailabilityLabelText(quantity: Int = 0) {
        productAvailabilityNumber.text = getProductAvailabilityNumber(productsNumber: quantity)
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
                if let productIndex = data.firstIndex(where: {$0.id == self?.productData.id}) {
                    self?.setProductAvailabilityLabelText(quantity: data[productIndex].numberOfChosenProducts.asInt())
                    self?.quantityManagementView.setupData(with: data[productIndex])
                } else {
                    self?.resetData()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func resetData() {
        setProductAvailabilityLabelText(quantity: 0)
        quantityManagementView.setupData(with: productData.mapProductModel(numberOfChosenProducts: 0))
    }
    
    private func getProductAvailabilityNumber(productsNumber: Int) -> String {
        let availabilityNumber = productData.itemsAvailable - productsNumber
        let additionalText = productData.product == .egg ? " opak." : ""
        return "Dostępne: \(availabilityNumber)" + additionalText
    }
    

}
