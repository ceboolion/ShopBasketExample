import UIKit
import RxSwift

class BasketSummaryView: UIView {
    
    //MARK: - PRIVATE PROPERTIES
    private var topDividerView: UIView!
    private var productsSummaryAmountView: BasketSummaryRowView!
    private var shipmentAmountView: BasketSummaryRowView!
    private var bottomDividerView: UIView!
    private var costSummaryView: BasketSummaryRowView!
    private var stackView: UIStackView!
    private let disposeBag = DisposeBag()
    
    //MARK: - OVERRIDDEN METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PRIVATE METHODS
    private func configureUI() {
        configureTopDividerView()
        configureProductsSummaryAmountView()
        configureShipmentAmountView()
        configureBottomDividerView()
        configureCostSummaryView()
        configureStackView()
        configureConstraints()
        setupObservers()
    }
    
    private func configureTopDividerView() {
        topDividerView = .init()
        topDividerView.backgroundColor = .systemGray6
    }
    
    private func configureProductsSummaryAmountView() {
        productsSummaryAmountView = BasketSummaryRowView(viewType: .regular)
    }
    
    private func configureShipmentAmountView() {
        shipmentAmountView = BasketSummaryRowView(viewType: .regular)
    }
    
    private func configureBottomDividerView() {
        bottomDividerView = .init()
        bottomDividerView.backgroundColor = .systemGray6
    }
    
    private func configureCostSummaryView() {
        costSummaryView = BasketSummaryRowView(viewType: .large)
    }
    
    private func configureStackView() {
        stackView = .init()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.distribution = .fill
        stackView.addSubviews(views: topDividerView, productsSummaryAmountView, shipmentAmountView, bottomDividerView, costSummaryView)
    }
    
    private func configureConstraints() {
        addSubview(stackView)
        
        topDividerView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        bottomDividerView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        stackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(5)
            $0.bottom.trailing.equalToSuperview().offset(-5)
        }
    }
    
    private func setProductSummaryAmount(amount: String) {
        productsSummaryAmountView.setViewData(title: "Wartość produktów:", amount: amount)
    }
    
    private func setShipmentAmount(amount: String) {
        shipmentAmountView.setViewData(title: "Dostawa od:", amount: amount)
    }
    
    private func setCostSummaryView(amount: String) {
        costSummaryView.setViewData(title: "Razem z dostawą:", amount: amount)
    }
    
    //MARK: - RX
    private func setupObservers() {
        bindShoppingBasketData()
    }
    
    private func bindShoppingBasketData() {
        ShoppingBasket.shared.basketItems
            .bind { [weak self] data in
                let totalAmount = data.reduce(0, { $0 + ($1.productPrice * $1.numberOfChosenProducts)})
                let shipmentCost = 1.99
                self?.setProductSummaryAmount(amount: totalAmount.formatted(.currency(code: "USD")))
                self?.setShipmentAmount(amount: shipmentCost.formatted(.currency(code: "USD")))
                self?.setCostSummaryView(amount: (totalAmount + shipmentCost).formatted(.currency(code: "USD")))
            }
            .disposed(by: disposeBag)
    }
    
    
}
