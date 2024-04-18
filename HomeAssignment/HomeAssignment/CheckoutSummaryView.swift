import UIKit
import RxSwift
 
class CheckoutSummaryView: UIView {
    
    //MARK: - PUBLIC PROPERTIES
    var payButtonClosure: (()->Void)?
    
    //MARK: - PRIVATE PROPERTIES
    private var pickerData: [String] = []
    private var currencyData: [CurrencyModel] = []
    private var topDividerView: UIView!
    private var productsSummaryAmountView: BasketSummaryRowView!
    private var shipmentAmountView: BasketSummaryRowView!
    private var bottomDividerView: UIView!
    private var costSummaryView: BasketSummaryRowView!
    private var payButton: CustomButton!
    private var currencyPicker: UIPickerView!
    private var choseCurrencyButton: CustomButton!
    private var stackView: UIStackView!
    private let disposeBag = DisposeBag()
    
    private var currencyPickerIsHidden: Bool = true {
        didSet {
            choseCurrencyButton.setTitle(currencyPickerIsHidden ? "Wybierz walute" : "Zamknij wybór", for: .normal)
        }
    }
    
    private var chosenCurrency: String = "USD" {
        didSet {
            let data = ShoppingBasket.shared.basketItems.value
            setLabelsData(with: data)
        }
    }
    
    //MARK: - OVERRIDDEN METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    //MARK: - PUBLIC METHODS
    func setCurrencyData(_ data: [CurrencyModel]) {
        currencyData = data
        setPickerData(data: data.map {$0.currency})
    }
    
    //MARK: - PRIVATE METHODS
    private func configureUI() {
        configureTopDividerView()
        configureProductsSummaryAmountView()
        configureShipmentAmountView()
        configureBottomDividerView()
        configureShowCurrencyButton()
        configureCostSummaryView()
        configurePayButton()
        configureCurrencyPicker()
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
    
    private func configurePayButton() {
        payButton = .init(type: .system)
        payButton.clipsToBounds = true
        payButton.layer.cornerRadius = 9
        payButton.setTitle("Zapłać", for: .normal)
        payButton.setTitle("Zapłać", for: .highlighted)
        payButton.setTitleColor(.white, for: .normal)
        payButton.setTitleColor(.lightGray, for: .highlighted)
        payButton.backgroundColor = .accent
        payButton.onTap = { [weak self] in
            self?.payButtonClosure?()
        }
    }
    
    private func configureShowCurrencyButton() {
        choseCurrencyButton = .init()
        choseCurrencyButton.setTitleColor(.accent, for: .normal)
        choseCurrencyButton.setTitleColor(.accent, for: .highlighted)
        choseCurrencyButton.setTitle(currencyPickerIsHidden ? "Wybierz walutę" : "Zamknij wybór", for: .normal)
        choseCurrencyButton.setTitle(currencyPickerIsHidden ? "Wybierz walutę" : "Zamknij wybór", for: .highlighted)
        choseCurrencyButton.onTap = { [weak self] in
            guard let self else { return }
            self.currencyPickerIsHidden.toggle()
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseInOut) {
                self.currencyPicker.isHidden = self.currencyPickerIsHidden
            }
        }
    }
    
    private func configureCurrencyPicker() {
        currencyPicker = .init()
        currencyPicker.isHidden = currencyPickerIsHidden
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
    
    private func configureStackView() {
        stackView = .init()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.distribution = .fill
        stackView.addSubviews(views: topDividerView,
                              productsSummaryAmountView,
                              shipmentAmountView,
                              bottomDividerView,
                              choseCurrencyButton,
                              costSummaryView,
                              payButton,
                              currencyPicker)
    }
    
    private func configureConstraints() {
        addSubview(stackView)
        
        topDividerView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        bottomDividerView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        payButton.snp.makeConstraints {
            $0.height.equalTo(44)
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
    
    private func setPickerData(data: [String]) {
        pickerData = data
    }
    
    //MARK: - RX
    private func setupObservers() {
        bindShoppingBasketData()
    }
    
    private func bindShoppingBasketData() {
        ShoppingBasket.shared.basketItems
            .bind { [weak self] data in
                self?.setLabelsData(with: data)
            }
            .disposed(by: disposeBag)
    }
    
    private func setLabelsData(with data: [BasketProductsModel]) {
        let currencyMultiplier = currencyData.first(where: {$0.currency == chosenCurrency})
        
        let totalAmount = data.reduce(0, { $0 + ($1.productPrice * $1.numberOfChosenProducts)}) * (currencyMultiplier?.currencyData ?? 1)
        let shipmentCost = 1.99 * (currencyMultiplier?.currencyData ?? 1)
        setProductSummaryAmount(amount: totalAmount.formatted(.currency(code: chosenCurrency)))
        setShipmentAmount(amount: shipmentCost.formatted(.currency(code: chosenCurrency)))
        setCostSummaryView(amount: (totalAmount + shipmentCost).formatted(.currency(code: chosenCurrency)))
    }
    
    
    
}

//MARK: - EXTENSIONS
extension CheckoutSummaryView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("WRC selected currency: \(pickerData[row])")
        chosenCurrency = pickerData[row]
    }
    
}
