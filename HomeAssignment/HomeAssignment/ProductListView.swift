//
//  ProductListView.swift
//  HomeAssignment
//
//  Created by Ceboolion on 15/04/2024.
//

import UIKit

class ProductListView: UIView {
    
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        configureTableView()
//        setupObservers()
        configureConstraints()
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProductViewCell.self, forCellReuseIdentifier: ProductViewCell.reuseIdentifier)
    }
    
    private func configureConstraints() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    //MARK: - RX
//    private func setupObservers() {
//        bindTableViewProducts()
//        bindCurrenciesData()
//    }

//    func bindTableViewProducts() {
//        viewModel.productsData
//            .bind(to: tableView.rx.items) { [weak self] _, index, model in
//                let indexPath = IndexPath(row: index, section: 0)
//                let cell = self?.tableView.dequeueReusableCell(withIdentifier: ProductViewCell.reuseIdentifier, for: indexPath) as? ProductViewCell
//                cell?.configureCell(with: model)
//                return cell ?? UITableViewCell()
//            }
//            .disposed(by: viewModel.disposeBag)
//        
//        tableView
//            .rx
//            .itemSelected
//            .map(\.row)
//            .bind { [weak self] row in
//                guard let data = self?.viewModel.productsData.value[row] else { return }
//                self?.didSendEventClosure?(.showProduct(data))
//            }
//            .disposed(by: viewModel.disposeBag)
//    }
//    
//    func bindCurrenciesData() {
//        viewModel.currenciesData
//            .bind { [weak self] data in
//                print("WRC currenciesData: \(data)")
//            }
//            .disposed(by: viewModel.disposeBag)
//    }
    
}
