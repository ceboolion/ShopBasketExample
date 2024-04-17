import UIKit

class BasketController: UIViewController {
    
    //MARK: - PRIVATE PROPERTIES
    private var basketView: BasketView!
    
    //MARK: - PUBLIC PROPERTIES
    var didSendEventClosure: ((Event)->Void)?
    
    // MARK: - INIT
    init(basketView: BasketView!) {
        self.basketView = basketView
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Koszyk"
        navigationItem.title = "Twój koszyk"
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        view.backgroundColor = .systemBackground
        configureConstraints()
    }

    
    private func configureConstraints() {
        view.addSubview(basketView)
        basketView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - RX
    private func setupObservers() {
        bindPayButtonEvent()
        bindEmptyBasketButtonEvent()
    }
    
    private func bindPayButtonEvent() {
        basketView.payButtonEvent
            .bind { [weak self] _ in
                self?.didSendEventClosure?(.showPayView)
            }
            .disposed(by: basketView.viewModel.disposeBag)
    }
    
    private func bindEmptyBasketButtonEvent() {
        basketView.emptyBasketButtonEvent
            .bind { [weak self] _ in
                self?.didSendEventClosure?(.showStartTab)
            }
            .disposed(by: basketView.viewModel.disposeBag)
    }

}

//MARK: - EXTENSIONS
extension BasketController {
    enum Event {
        case showPayView
        case showStartTab
    }
}

