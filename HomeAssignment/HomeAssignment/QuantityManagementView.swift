import UIKit
import SnapKit
import RxSwift


class QuantityManagementView: UIView {
    
    //MARK: - PUBLIC PROPERTIES
    var onButtonTap: ((BasketUpdateType) -> Void)?
    
    //MARK: - PRIVATE PROPERTIES
    private var productData: BasketProductsModel?
    private var minusButton: CustomButton!
    private(set) var buyQuantityLabel: UILabel!
    private var plusButton: CustomButton!
    private var stackView: UIStackView!
    private let disposeBag = DisposeBag()
    
    //MARK: - OVERRIDDEN METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PUBLIC METHODS
    func setupData(with data: BasketProductsModel) {
        productData = data
        setBuyQuantityLabelText(with: data)
    }
    
    func setBuyQuantityLabelText(with data: BasketProductsModel) {
        buyQuantityLabel.text = "\(Int(data.numberOfChosenProducts))"
    }
     
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        configureMinusButton()
        configureBuyQuantityLabel()
        configurePlusButton()
        configureStackView()
        configureConstraints()
    }
    
    private func configureMinusButton() {
        minusButton = .init()
        minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
        minusButton.setImage(UIImage(systemName: "minus"), for: .highlighted)
        minusButton.backgroundColor = .systemBackground
        minusButton.onTap = { [weak self] in
            self?.onButtonTap?(.remove)
        }
    }
    
    private func configureBuyQuantityLabel() {
        buyQuantityLabel = UILabel()
        buyQuantityLabel.text = "0"
    }
    
    private func configurePlusButton() {
        plusButton = .init()
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .highlighted)
        plusButton.backgroundColor = .systemBackground
        plusButton.onTap = { [weak self] in
            self?.onButtonTap?(.add)
        }
    }
    
    private func configureStackView() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 6
        stackView.addSubviews(views: UIView(), minusButton, buyQuantityLabel, plusButton)
    }
    
    private func configureConstraints() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        minusButton.snp.makeConstraints {
            $0.width.height.equalTo(16)
        }
        
        plusButton.snp.makeConstraints {
            $0.width.height.equalTo(16)
        }
    }

    
}
