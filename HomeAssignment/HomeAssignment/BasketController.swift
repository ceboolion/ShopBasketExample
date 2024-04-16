import UIKit

class BasketController: UIViewController {
    
    private var basketView: BasketView!
    
    init(basketView: BasketView!) {
        self.basketView = basketView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
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

}
