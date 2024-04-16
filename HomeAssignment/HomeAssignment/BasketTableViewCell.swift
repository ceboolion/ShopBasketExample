import UIKit
import SnapKit

class BasketTableViewCell: UITableViewCell {
    
    private var productImageView: UIImageView!
    private var productTitleLabel: UILabel!
    private var productNumberLabel: UILabel!
    private var summaryCostLabel: UILabel!
    private var topStackView: UIStackView!
    
    private var minusButton: UIButton!
    private var buyQuantityLabel: UILabel!
    private var plusButton: UIButton!
    private var bottomStackView: UIStackView!
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: BasketProductsModel) {
        productImageView.image = UIImage(resource: model.product.image)
        productTitleLabel.text = model.product.productTitle
        setProductLabelText(from: model)
    }
    
    private func setupUI() {
        configureProductImageView()
        configureProductTitleLabel()
        configureProductNumberLabel()
        configureSummaryCostLabel()
        configureTopStackView()
        configureConstraints()
    }
    
    private func configureProductImageView() {
        productImageView = .init()
        productImageView.contentMode = .scaleAspectFit
    }
    
    private func configureProductTitleLabel() {
        productTitleLabel = .init()
        productTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        productTitleLabel.numberOfLines = 2
        productTitleLabel.lineBreakMode = .byWordWrapping
    }
    
    private func configureProductNumberLabel() {
        productNumberLabel = .init()
        productNumberLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    private func configureSummaryCostLabel() {
        summaryCostLabel = .init()
    }
    
    private func configureBottomStackView() {
        bottomStackView = .init()
        bottomStackView.axis = .horizontal
        bottomStackView.alignment = .center
        bottomStackView.spacing = 5
        bottomStackView.distribution = .fill
//        bottomStackView.addSubviews(views: )
    }
    
    private func configureTopStackView() {
        topStackView = .init()
        topStackView.axis = .vertical
        topStackView.alignment = .leading
        topStackView.spacing = 5
        topStackView.distribution = .fill
        topStackView.addSubviews(views: productTitleLabel, UIView(), productNumberLabel)
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
//            $0.height.equalTo(productImageView.snp.height)
            $0.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }
    
    private func setProductLabelText(from model: BasketProductsModel) {
        productNumberLabel.text = model.numberOfChosenProducts.asInt().description + " x " + model.productPrice.formatted(.currency(code: "USD"))
    }
    
}
