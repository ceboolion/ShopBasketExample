import UIKit
import SnapKit

class CheckoutView: UIView {
    
    //MARK: - PRIVATE PROPERTIES
    private var viewModel: CheckoutViewModel!
    private var closeButton: CustomButton!
    private var titleLabel: UILabel!
    private var tableView: UITableView!
    private var checkoutSummaryView: CheckoutSummaryView!
    private let padding: CGFloat = 12.0
    
    //MARK: - PUBLIC PROPERTIES
    var closeButtonClosure: (()->Void)?
    var payButtonClosure: (()->Void)?
    
    // MARK: INIT
    init(viewModel: CheckoutViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PRIVATE METHODS
    private func configureUI() {
        configureCloseButton()
        configureTitleLabel()
        configureTableView()
        configureCheckoutSummaryView()
        setupConstraints()
        setupObservers()
    }
    
    private func configureCloseButton() {
        closeButton = .init(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .highlighted)
        closeButton.backgroundColor = .systemBackground
        closeButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 26), forImageIn: .normal)
        closeButton.onTap = { [weak self] in
            self?.closeButtonClosure?()
        }
    }
    
    private func configureTitleLabel() {
        titleLabel = .init()
        titleLabel.text = "Podsumowanie"
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CheckoutViewCell.self, forCellReuseIdentifier: CheckoutViewCell.reuseIdentifier)
    }
    
    private func configureCheckoutSummaryView() {
        checkoutSummaryView = .init()
        checkoutSummaryView.setCurrencyData(viewModel.currencyData)
        checkoutSummaryView.payButtonClosure = { [weak self] in
            self?.payButtonClosure?()
        }
    }
    
    private func setupConstraints() {
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(tableView)
        addSubview(checkoutSummaryView)
        
        closeButton.snp.makeConstraints {
            $0.top.leading.equalTo(padding)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(closeButton.snp.centerY)
            $0.centerX.equalTo(snp.centerX)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(12)
            $0.leading.equalTo(padding)
            $0.trailing.equalTo(-padding)
        }
        
        checkoutSummaryView.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.leading.equalTo(padding)
            $0.trailing.equalTo(-padding)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    //MARK: - RX
    private func setupObservers() {
        bindTableViewData()
    }
    
    private func bindTableViewData() {
        viewModel.basketData
            .bind(to: tableView.rx.items(cellIdentifier: CheckoutViewCell.reuseIdentifier,
                                         cellType: CheckoutViewCell.self)) { cellIndex, cellData, cell in
                cell.configCell(data: cellData)
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    
}
