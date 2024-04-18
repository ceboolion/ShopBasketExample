import UIKit

class ProductListView: UIView {
    
    //MARK: - PRIVATE PROPERTIES
    private var viewModel: StartViewModel!
    private var tableView: UITableView!
    
    //MARK: - PUBLIC PROPERTIES
    var didSendEventClosure: ((StartController.Event)->Void)?
    
    // MARK: - INIT
    init(viewModel: StartViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PRIVATE METHODS
    private func setup() {
        configureTableView()
        setupObservers()
        configureConstraints()
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProductViewCell.self, forCellReuseIdentifier: ProductViewCell.reuseIdentifier)
    }
    
    private func configureConstraints() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupObservers() {
        bindTableViewProducts()
    }
    
    //MARK: - RX
    private func bindTableViewProducts() {
        viewModel.productsData
            .bind(to: tableView.rx.items(cellIdentifier: ProductViewCell.reuseIdentifier,
                                         cellType: ProductViewCell.self)) { [weak self] cellIndex, cellData, cell in
                guard let self else { return }
                cell.configureCell(with: cellData)
                cell.onTap = { updateType, data in
                    self.viewModel.updateShoppingData(updateType: updateType, data: data)
                }
            }
            .disposed(by: viewModel.disposeBag)
        
        tableView
            .rx
            .itemSelected
            .map(\.item)
            .bind { [weak self] row in
                guard let data = self?.viewModel.productsData.value[row] else { return }
                self?.didSendEventClosure?(.showProduct(data))
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    
}
