//
//  CategoriesView.swift
//  GridLayoutExample
//
//  Created by Damian Kolasiński on 22/02/2020.
//  Copyright © 2020 Damian Kolasiński. All rights reserved.
//

import UIKit
import UI
import GridLayout

struct CategoriesViewModel {
    let gridViewModel: GridLayoutViewModel
}

final class CategoriesView: UIView {
    private let gridView: GridLayoutView
    
    init(frame: CGRect, viewModel: CategoriesViewModel) {
        self.gridView = GridLayoutView(viewModel: viewModel.gridViewModel)
        super.init(frame: frame)
        applyStyling()
        setupSubviews()
        setupInteractions()
        bind(with: viewModel)
    }
            
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("Storyboards are not compatible with true love and beauty") }
    
    private func applyStyling() {
        backgroundColor = .white
    }
    
    private func setupInteractions() {
        
    }
    
    private func bind(with viewModel: CategoriesViewModel) {
        
    }
}

extension CategoriesView {
    private func setupSubviews() {
        gridView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gridView)
        NSLayoutConstraint.activate(
            gridView.centerXAnchor == centerXAnchor,
            gridView.centerYAnchor == centerYAnchor,
            gridView.widthAnchor == 150,
            gridView.heightAnchor == 200
        )
    }
}
