import UIKit
import RxSwift

class ProductDetailView: UIView {
    
    //MARK: - PRIVATE PROPERTIES
    private var imageView: UIImageView!
    private var textLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var stackView: UIStackView!
    private let padding: CGFloat = 12
    private let imageHeight: CGFloat = 350
    private let disposeBag = DisposeBag()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PUBLIC METHODS
    func configureView(with model: ProductModel) {
        setImageView(image: model.product.image)
        setTextLabelText(with: model.product.productTitle)
        setDescriptionLabel(text: model.product.description)
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        backgroundColor = .systemBackground
        configureImageView()
        configureTextLabel()
        configureDescriptionLabel()
        configureStackView()
        setupConstraints()
    }
    
    private func configureImageView() {
        imageView = .init()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }

    private func configureTextLabel() {
        textLabel = .init()
        textLabel.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    private func setImageView(image: ImageResource) {
        imageView.image = UIImage(resource: image)
    }
    
    private func setTextLabelText(with text: String) {
        textLabel.text = text
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel = .init()
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
    }
    
    private func setDescriptionLabel(text: String) {
        descriptionLabel.text = text
    }
    
    private func configureStackView() {
        stackView = .init()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.addSubviews(views: imageView, textLabel, descriptionLabel, /*buyButton, */UIView())
    }
    
    private func setupConstraints() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.leading.equalTo(padding)
            $0.bottom.trailing.equalTo(-padding)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(imageHeight)
        }
    }
    

}
