import UIKit
import SnapKit

class ProductDetailsViewController: UIViewController {
    
    private let productDetailView: ProductDetailView
    
    override func loadView() {
        super.loadView()
        setupBackButton()
        setupUI()
    }
    
    init(rootView: ProductDetailView, data: ProductModel) {
        self.productDetailView = rootView
        super.init(nibName: nil, bundle: nil)
        setUpNavBar(title: data.product.shortTitle)
        setupView(with: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(with data: ProductModel) {
        productDetailView.configureView(with: data)
    }
    
    private func setUpNavBar(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = "Wstecz"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func setupUI() {
        view.addSubview(productDetailView)
        productDetailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
}
