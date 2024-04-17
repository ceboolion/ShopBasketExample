import UIKit
import SnapKit
import RxSwift

class BasketTableViewCell: UITableViewCell {
    
    //MARK: - PRIVATE PROPERTIES
    private var productData: ProductModel = .init(product: .none, productPrice: 0, itemsAvailable: 0, unitOfMeasure: .none)
    private var basketData: BasketProductsModel?
    private var productImageView: UIImageView!
    private var productTitleLabel: UILabel!
    private var productNumberLabel: UILabel!
    private var summaryCostLabel: UILabel!
    private var topStackView: UIStackView!
    private var quantityManagementView: QuantityManagementView!
    private var bottomStackView: UIStackView!
    private var disposeBag = DisposeBag()
    
    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
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
        configureUI()
    }
    
    //MARK: - PUBLIC METHODS
    func configureCell(with model: BasketProductsModel) {
        basketData = model
        productData = model.getProductModel()
        configureProductImageView()
        configureProductTitleLabel()
        configureProductNumberLabel()
        configureSummaryCostLabel()
        configureQuantityManagementView()
        configureBottomStackView()
        configureTopStackView()
        configureConstraints()
        setupObservables()
        productNumberLabel.text = (quantityManagementView.buyQuantityLabel.text ?? "") + " x " + productData.productPrice.formatted(.currency(code: "USD"))
    }
    
    //MARK: - PRIVATE METHODS
    private func configureUI() {
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 25
    }
    
    private func configureProductImageView() {
        productImageView = .init()
        productImageView.contentMode = .scaleAspectFill
        productImageView.image = UIImage(resource: productData.product.image)
    }
    
    private func configureProductTitleLabel() {
        productTitleLabel = .init()
        productTitleLabel.text = productData.product.productTitle
        productTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        productTitleLabel.numberOfLines = 2
        productTitleLabel.lineBreakMode = .byWordWrapping
    }
    
    private func configureProductNumberLabel() {
        productNumberLabel = .init()
        productNumberLabel.font = .systemFont(ofSize: 14, weight: .regular)
        productNumberLabel.text = (basketData?.numberOfChosenProducts.asInt().description ?? "") + " x " + productData.productPrice.formatted(.currency(code: "USD"))
    }
    
    private func configureSummaryCostLabel() {
        summaryCostLabel = .init()
    }
    
    private func configureQuantityManagementView() {
        quantityManagementView = QuantityManagementView(productData: productData)
    }
    
    private func configureBottomStackView() {
        bottomStackView = .init()
        bottomStackView.axis = .horizontal
        bottomStackView.alignment = .center
        bottomStackView.spacing = 5
        bottomStackView.distribution = .fill
        bottomStackView.addSubviews(views: quantityManagementView, UIView())
    }
    
    private func configureTopStackView() {
        topStackView = .init()
        topStackView.axis = .vertical
        topStackView.alignment = .leading
        topStackView.spacing = 5
        topStackView.distribution = .fill
        topStackView.addSubviews(views: productTitleLabel, UIView(), productNumberLabel, bottomStackView)
    }
    
    private func configureConstraints() {
        contentView.addSubview(productImageView)
        contentView.addSubview(topStackView)
        
        productImageView.snp.makeConstraints {
            $0.top.leading.equalTo(5)
            $0.bottom.equalTo(-5)
            $0.width.height.equalTo(150)
        }
        
        topStackView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(5)
            $0.leading.equalTo(productImageView.snp.trailing).offset(5)
            $0.trailing.equalTo(self.snp.trailing).offset(-5)
            $0.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }
    
    private func setupObservables() {
//        bindShoppingBasketData()
    }
    
//    private func bindShoppingBasketData() {
//        ShoppingBasket.shared.basketItems
//            .bind { [weak self] data in
//                guard let cellData = data.first(where: {$0.id == self?.productData.id}) else { return }
//                self?.productNumberLabel.text = cellData.numberOfChosenProducts.asInt().description + " x " + cellData.productPrice.formatted(.currency(code: "USD"))
//            }
//            .disposed(by: disposeBag)
//    }
    
    
}
