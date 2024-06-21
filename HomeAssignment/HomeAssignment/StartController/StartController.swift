import UIKit
import SnapKit

class StartController: UIViewController {
    
    //MARK: - PRIVATE PROPERTIES
    private var productListView: ProductListView!
    private var viewModel: StartViewModel!
    
    //MARK: - PUBLIC PROPERTIES
    var didSendEventClosure: ((Event)->Void)?
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    init(viewModel: StartViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        configureProductListView(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        title = "Start"
        navigationItem.title = "Zrób super zakupy"
        navigationController?.navigationBar.prefersLargeTitles = false
        configureConstraints()
    }
    
    private func configureProductListView(with viewModel: StartViewModel) {
        productListView = ProductListView(viewModel: viewModel)
        productListView.didSendEventClosure = { [weak self] event in
            self?.didSendEventClosure?(event)
        }
    }
    
    private func configureConstraints() {
        view.addSubview(productListView)
        productListView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }


}

//MARK: - EXTENSIONS
extension StartController {
    enum Event {
        case showProduct(ProductModel)
    }
}

