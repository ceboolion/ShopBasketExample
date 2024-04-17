import UIKit
import SnapKit
import RxSwift


class QuantityManagementView: UIView {
    
    //MARK: - PRIVATE PROPERTIES
    private var productData: ProductModel?
    private var minusButton: UIButton!
    private(set) var buyQuantityLabel: UILabel!
    private var plusButton: UIButton!
    private var stackView: UIStackView!
    private let disposeBag = DisposeBag()
    
//    // MARK: - INIT
//    init(productData: ProductModel?) {
//        self.productData = productData
//        super.init(frame: .zero)
//        setupUI()
//        setupObservers()
//    }
    
    //MARK: - OVERRIDDEN METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupObservers()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PUBLIC METHODS
    func setupData(with data: ProductModel) {
        productData = data
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        configureMinusButton()
        configureBuyQuantityLabel()
        configurePlusButton()
        configureStackView()
        configureConstraints()
    }
    
    private func configureMinusButton() {
        minusButton = UIButton(type: .system)
        minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        minusButton.setImage(UIImage(systemName: "minus"), for: .highlighted)
        minusButton.backgroundColor = .systemBackground
    }
    
    private func configureBuyQuantityLabel() {
        buyQuantityLabel = UILabel()
        buyQuantityLabel.text = "0"
    }
    
    private func configurePlusButton() {
        plusButton = UIButton(type: .system)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .highlighted)
        plusButton.backgroundColor = .systemBackground
    }
    
    private func configureStackView() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.addSubviews(views: UIView(), minusButton, buyQuantityLabel, plusButton)
    }
    
    private func configureConstraints() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        minusButton.snp.makeConstraints {
            $0.width.height.equalTo(16)
        }
        
        plusButton.snp.makeConstraints {
            $0.width.height.equalTo(16)
        }
    }
    
    //MARK: - RX
    private func setupObservers() {
        bindMinusButton()
        bindNumberOfChosenProducts()
        bindPlusButton()
    }
    
    private func bindMinusButton() {
        minusButton
            .rx
            .tap
            .bind { [weak self] in
                print("WRC minusButton tapped in cell")
                guard let productData = self?.productData else { return }
                ShoppingBasket.shared.updateProductsBasket(.remove,
                                                           product: productData.mapProductModel(numberOfChosenProducts: productData.product == .egg ? 12 : 1))
            }
            .disposed(by: disposeBag)
    }
    
    private func bindNumberOfChosenProducts() {
        ShoppingBasket.shared.basketItems
            .bind { [weak self] data in
                print("WRC ShoppingBasket data: \(data)")
                if let productIndex = data.firstIndex(where: {$0.id == self?.productData?.id}) {
                    self?.buyQuantityLabel.text = "\(Int(data[productIndex].numberOfChosenProducts))"
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func bindPlusButton() {
        plusButton
            .rx
            .tap
            .bind { [weak self] in
                print("WRC plusButton tapped")
                guard let productData = self?.productData else { return }
                ShoppingBasket.shared.updateProductsBasket(.add,
                                                           product: productData.mapProductModel(numberOfChosenProducts: productData.product == .egg ? 12 : 1))
            }
            .disposed(by: disposeBag)
    }
    
}
