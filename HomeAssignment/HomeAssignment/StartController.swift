import UIKit
import SnapKit

class StartController: UIViewController {
    
    private var viewModel: StartViewModel!
    private var tableView: UITableView!
    
    var didSendEventClosure: ((Event)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Start"
        navigationItem.title = "Zrób super zakupy"
        navigationController?.navigationBar.prefersLargeTitles = false
        setup()
    }

    init(viewModel: StartViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        configureTableView()
        setupObservers()
        configureConstraints()
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProductViewCell.self, forCellReuseIdentifier: ProductViewCell.reuseIdentifier)
    }
    
    private func configureConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.bottom.trailing.equalToSuperview()
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

//MARK: - EXTENSIONS
extension StartController {
    enum Event {
        case showProduct(ProductModel)
    }
}

