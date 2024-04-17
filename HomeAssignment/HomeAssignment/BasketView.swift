//
//  BasketView.swift
//  HomeAssignment
//
//  Created by Ceboolion on 16/04/2024.
//

import UIKit
import RxSwift

class BasketView: UIView {
    
    //MARK: - PRIVATE PROPERTIES
    private(set) var tableView: UITableView!
    private var emptyBasketView: EmptyBasketView!
    private var payButton: UIButton!
    
    private(set) var viewModel: BasketViewModel!
    
    //MARK: - PUBLIC PROPERTIES
    let payButtonEvent = PublishSubject<Bool>()
    
    // MARK: - INIT
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupObservers()
    }
    
    //MARK: - OVERRIDDEN METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        payButton.layer.cornerRadius = payButton.bounds.height / 5
    }
    
    //MARK: - PRIVATE METHODS
    private func setupUI() {
        configureTableView()
        configureEmptyBasketView()
        configurePayButton()
        configureConstraints()
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.reuseIdentifier)
    }
    
    private func configureEmptyBasketView() {
        emptyBasketView = EmptyBasketView()
    }
    
    private func configurePayButton() {
        payButton = UIButton(type: .system)
        payButton.setTitle("Zapłać", for: .normal)
        payButton.setTitle("Zapłać", for: .highlighted)
        payButton.setTitleColor(.white, for: .normal)
        payButton.setTitleColor(.lightGray, for: .highlighted)
        payButton.backgroundColor = .accent
    }
    
    private func configureConstraints() {
        addSubview(tableView)
        addSubview(payButton)
        addSubview(emptyBasketView)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        payButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.bottom.equalTo(self.snp.bottom).offset(-10)
            $0.centerX.equalTo(tableView.snp.centerX)
            $0.height.equalTo(40)
            $0.width.equalTo(200)
        }
        
        emptyBasketView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - RX
    private func setupObservers() {
        bindUIElementsVisibility()
        bindTableViewData()
        bindPayButton()
    }
    
    private func bindUIElementsVisibility() {
        viewModel.basketData
            .bind { [weak self] data in
                self?.emptyBasketView.isHidden = data.isEmpty ? false : true
                self?.payButton.isHidden = data.isEmpty ? true : false
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    private func bindTableViewData() {
        viewModel.basketData
            .bind(to: tableView.rx.items) { [weak self] _, index, model in
                let indexPath = IndexPath(row: index, section: 0)
                let cell = self?.tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.reuseIdentifier, for: indexPath) as? BasketTableViewCell
                guard let cell else { return UITableViewCell() }
                cell.configureCell(with: model)
                return cell
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    private func bindPayButton() {
        payButton
            .rx
            .tap
            .bind { [weak self] in
                print("WRC payButton tapped")
                self?.payButtonEvent.onNext(true)
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    
}
