import UIKit
import RxSwift

class BasketView: UIView {
    
    //MARK: - PRIVATE PROPERTIES
    private(set) var tableView: UITableView!
    private var emptyBasketView: EmptyBasketView!
    private var basketSummaryView: BasketSummaryView!
    private var payButton: UIButton!
    private(set) var viewModel: BasketViewModel!
    
    //MARK: - PUBLIC PROPERTIES
    let payButtonEvent = PublishSubject<Bool>()
    let emptyBasketButtonEvent = PublishSubject<Bool>()
    
    // MARK: - INIT
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupObservers()
    }
    
    //MARK: - OVERRIDDEN METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        payButton.layer.cornerRadius = payButton.bounds.height / 5
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        configureTableView()
        configureBasketSummaryView()
        configureEmptyBasketView()
        configurePayButton()
        configureConstraints()
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.reuseIdentifier)
    }
    
    private func configureBasketSummaryView() {
        basketSummaryView = .init()
    }
    
    private func configureEmptyBasketView() {
        emptyBasketView = EmptyBasketView()
        emptyBasketView.onTapClosure = { [weak self] in
            self?.emptyBasketButtonEvent.onNext(true)
        }
    }
    
    private func configurePayButton() {
        payButton = UIButton(type: .system)
        payButton.setTitle("Zapłać", for: .normal)
        payButton.setTitle("Zapłać", for: .highlighted)
        payButton.setTitleColor(.white, for: .normal)
        payButton.setTitleColor(.lightGray, for: .highlighted)
        payButton.backgroundColor = .accent
    }
    
    private func configureConstraints() {
        addSubview(tableView)
        addSubview(basketSummaryView)
        addSubview(payButton)
        addSubview(emptyBasketView)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        basketSummaryView.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.leading.equalTo(5)
            $0.trailing.equalTo(-5)
        }
        
        payButton.snp.makeConstraints {
            $0.top.equalTo(basketSummaryView.snp.bottom).offset(15)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
            $0.centerX.equalTo(basketSummaryView.snp.centerX)
            $0.height.equalTo(40)
            $0.width.equalTo(UIScreen.main.bounds.width * 0.6)
        }
        
        emptyBasketView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - RX
    private func setupObservers() {
        bindUIElementsVisibility()
        bindTableViewData()
        bindPayButton()
    }
    
    private func bindUIElementsVisibility() {
        viewModel.basketData
            .bind { [weak self] data in
                self?.emptyBasketView.isHidden = data.isEmpty ? false : true
                self?.basketSummaryView.isHidden = data.isEmpty ? true : false
                self?.payButton.isHidden = data.isEmpty ? true : false
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    private func bindTableViewData() {
        viewModel.basketData
            .bind(to: tableView.rx.items(cellIdentifier: BasketTableViewCell.reuseIdentifier,
                                         cellType: BasketTableViewCell.self)) { cellIndex, cellData, cell in
                cell.configureCell(with: cellData)
                cell.onTap = { [weak self] updateType, data in
                    self?.viewModel.updateShoppingData(updateType: updateType, data: data)
                }
            }
            .disposed(by: viewModel.disposeBag)
        
        tableView
            .rx
            .itemDeleted
            .map(\.row)
            .bind { [weak self] row in
                print("WRC row: \(row)")
                self?.viewModel.removeItem(for: row)
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    private func bindPayButton() {
        payButton
            .rx
            .tap
            .bind { [weak self] in
                print("WRC payButton tapped")
                self?.payButtonEvent.onNext(true)
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    
}
