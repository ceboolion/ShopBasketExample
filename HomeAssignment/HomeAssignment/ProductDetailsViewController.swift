//
//  ProductDetailsViewController.swift
//  HomeAssignment
//
//  Created by Ceboolion on 15/04/2024.
//

import UIKit
import SnapKit

class ProductDetailsViewController: UIViewController {
    
    private var productDetailView: ProductDetailView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
        setupUI()
    }
    
    func setupView(with data: ProductModel) {
        productDetailView = ProductDetailView()
        productDetailView.configureView(with: data)
    }
    
    private func setupUI() {
        view.addSubview(productDetailView)
        productDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
