//
//  BasketSummaryRowView.swift
//  HomeAssignment
//
//  Created by Ceboolion on 17/04/2024.
//

import UIKit
import SnapKit

class BasketSummaryRowView: UIView {
    
    //MARK: - PRIVATE PROPERTIES
    private var titleLabel: UILabel!
    private var amountLabel: UILabel!
    private var stackView: UIStackView!
    private var viewType: BasketRowViewType!
    
    // MARK: INIT
    init(viewType: BasketRowViewType) {
        self.viewType = viewType
        super.init(frame: .zero)
        configureUI()
    }
    
    //MARK: - OVERRIDDEN METHODS
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PUBLIC METHODS
    func setViewData(title: String, amount: String) {
        titleLabel.text = title
        amountLabel.text = amount
    }
    
    //MARK: - PRIVATE METHODS
    private func configureUI() {
        configureTitleLabel()
        configureAmountLabel()
        configureStackView()
        configureConstraints()
    }
    
    private func configureTitleLabel() {
        titleLabel = .init()
        titleLabel.font = .systemFont(ofSize: viewType == .regular ? 14 : 18, weight: viewType == .regular ? .regular : .bold)
    }
    
    private func configureAmountLabel() {
        amountLabel = .init()
        amountLabel.font = .systemFont(ofSize: viewType == .regular ? 14 : 22, weight: viewType == .regular ? .regular : .bold)
    }
    
    private func configureStackView() {
        stackView = .init()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.addSubviews(views: titleLabel, UIView(), amountLabel)
    }
    
    private func configureConstraints() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    
}
