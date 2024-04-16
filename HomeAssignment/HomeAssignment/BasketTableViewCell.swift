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
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with model: BasketProductsModel) {
        
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
        productImageView = UIImageView()
    }
    
    private func configureProductTitleLabel() {
        productTitleLabel = UILabel()
    }
    
    private func configureProductNumberLabel() {
        productNumberLabel = UILabel()
    }
    
    private func configureSummaryCostLabel() {
        summaryCostLabel = UILabel()
    }
    
    private func configureTopStackView() {
        topStackView = UIStackView()
        topStackView = UIStackView()
        topStackView.axis = .vertical
        topStackView.alignment = .leading
        topStackView.spacing = 5
        topStackView.distribution = .fillProportionally
        topStackView.addSubviews(views: productTitleLabel, productNumberLabel)
    }
    
    private func configureConstraints() {
        
    }
    
}
