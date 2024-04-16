//
//  BasketView.swift
//  HomeAssignment
//
//  Created by Ceboolion on 16/04/2024.
//

import UIKit
import RxSwift

class BasketView: UIView {
    
    private(set) var tableView: UITableView!
    private var emptyBasketView: EmptyBasketView!
    
    private var viewModel: BasketViewModel!
    
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupObservers()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        configureTableView()
        configureEmptyBasketView()
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
    
    private func configureConstraints() {
        addSubview(emptyBasketView)
        
        emptyBasketView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupObservers() {
        bindEmptyBasketViewVisibility()
        bindTableViewData()
    }
    
    private func bindEmptyBasketViewVisibility() {
        viewModel.basketData
            .bind { [weak self] data in
                self?.emptyBasketView.isHidden = data.isEmpty ? false : true
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
    
    
    
}
