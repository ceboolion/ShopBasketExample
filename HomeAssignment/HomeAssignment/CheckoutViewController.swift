import UIKit
import SnapKit

class CheckoutViewController: UIViewController {
    
    //MARK: - PUBLIC PROPERTIES
    var showAlertClosure: (()->Void)?
    
    //MARK: - PRIVATE PROPERTIES
    private var checkoutView: CheckoutView!
    
    // MARK: - INIT
    init(checkoutView: CheckoutView) {
        self.checkoutView = checkoutView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureCheckoutView()
        setupConstraints()
    }
    
    private func configureCheckoutView() {
        checkoutView.closeButtonClosure = { [weak self] in
            self?.dismiss(animated: true)
        }
        checkoutView.payButtonClosure = {[weak self] in
            guard let self else { return }
            self.dismiss(animated: true, completion: {
                ShoppingBasket.shared.addProduct(products: [])
                self.showAlertClosure?()
            })
        }
    }
    
    private func setupConstraints() {
        view.addSubview(checkoutView)
        checkoutView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }


}
