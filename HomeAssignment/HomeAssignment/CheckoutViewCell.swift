import UIKit

class CheckoutViewCell: UITableViewCell {
    
    //MARK: - PRIVATE PROPERTIES
//    private var productData: ProductModel = .init(product: .none,
//                                                  productPrice: 0,
//                                                  itemsAvailable: 0,
//                                                  unitOfMeasure: .none)
    private var basketData: BasketProductsModel = .init(id: UUID(),
                                                        product: .none,
                                                        productPrice: 0,
                                                        unitOfMeasure: .none,
                                                        numberOfChosenProducts: 0,
                                                        numberOfAvailableProducts: 0)
    private var productImageView: UIImageView!
    private var productTitleLabel: UILabel!
    private var chosenProductNumberLabel: UILabel!
    private var productPriceLabel: UILabel!
    
    private var stackView: UIStackView!
    
    private let imageHeight: CGFloat = 60.0
    private let imagePadding: CGFloat = 5.0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - OVERRIDDEN METHODS
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    //MARK: - PUBLIC METHODS
    func configCell(data: BasketProductsModel) {
        basketData = data
        productImageView.image = UIImage(resource: data.product.image)
        productTitleLabel.text = data.product.productTitle
        chosenProductNumberLabel.text = "Ilość: " + data.numberOfChosenProducts.asInt().description
        productPriceLabel.text = "Suma: " + (data.numberOfChosenProducts * data.productPrice).formatted(.currency(code: "USD"))
    }
    
    
    //MARK: - PRIVATE METHODS
    private func configureUI() {
        configureProductImageView()
        configureProductTitleLabel()
        configureChosenProductNumberLabel()
        configureProductPriceLabel()
        configureStackView()
        setupConstraints()
    }
    
    private func updateUI() {
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 10
    }
    
    private func configureProductImageView() {
        productImageView = .init()
        productImageView.contentMode = .scaleAspectFit
        productImageView.backgroundColor = .white
    }
    
    private func configureChosenProductNumberLabel() {
        chosenProductNumberLabel = .init()
        chosenProductNumberLabel.font = .systemFont(ofSize: 13, weight: .regular)
    }
    
    private func configureProductTitleLabel() {
        productTitleLabel = .init()
        productTitleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        productTitleLabel.minimumScaleFactor = 0.6
        productTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureProductPriceLabel() {
        productPriceLabel = .init()
        productPriceLabel.font = .systemFont(ofSize: 13, weight: .regular)
    }
    
    private func configureStackView() {
        stackView = .init()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.addSubviews(views: productTitleLabel, chosenProductNumberLabel, productPriceLabel)
    }
    
    private func setupConstraints() {
        addSubview(productImageView)
        addSubview(stackView)
        
        productImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(imagePadding)
            $0.leading.equalToSuperview().offset(imagePadding)
            $0.bottom.equalToSuperview().offset(-imagePadding)
            $0.height.width.equalTo(imageHeight)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(imagePadding)
            $0.leading.equalTo(productImageView.snp.trailing).offset(imagePadding)
            $0.bottom.trailing.equalToSuperview().offset(-imagePadding)
        }
    }
    
}
