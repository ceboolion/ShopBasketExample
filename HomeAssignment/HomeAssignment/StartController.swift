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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.view.backgroundColor = .systemGray6
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
        bindCurrenciesData()
    }
    
    //MARK: - RX
    func bindTableViewProducts() {
        viewModel.productsData
            .bind(to: tableView.rx.items) { [weak self] _, index, model in
                let indexPath = IndexPath(row: index, section: 0)
                let cell = self?.tableView.dequeueReusableCell(withIdentifier: ProductViewCell.reuseIdentifier, for: indexPath) as? ProductViewCell
                guard let cell else { return UITableViewCell() }
                cell.configureCell(with: model)
                return cell
            }
            .disposed(by: viewModel.disposeBag)
        
        tableView
            .rx
            .itemSelected
            .map(\.row)
            .bind { [weak self] row in
                guard let data = self?.viewModel.productsData.value[row] else { return }
                self?.didSendEventClosure?(.showProduct(data))
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    func bindCurrenciesData() {
        viewModel.currenciesData
            .bind { [weak self] data in
//                print("WRC currenciesData: \(data)")
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

