//
//  CategoriesView.swift
//  GridLayoutExample
//
//  Created by Damian Kolasiński on 22/02/2020.
//  Copyright © 2020 Damian Kolasiński. All rights reserved.
//

import UIKit
import GridLayout

struct CategoriesViewModel {

}

final class CategoriesView: UIView {
    
    init(frame: CGRect, viewModel: CategoriesViewModel) {
        super.init(frame: frame)
        applyStyling()
        setupSubviews()
        setupInteractions()
        bind(with: viewModel)
    }
            
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("Storyboards are not compatible with true love and beauty") }
    
    private func applyStyling() {
        backgroundColor = .blue
    }
    
    private func setupInteractions() {
        
    }
    
    private func bind(with viewModel: CategoriesViewModel) {
        
    }
}

extension CategoriesView {
    private func setupSubviews() {
        let gridView = GridLayoutView(frame: CGRect(
            origin: CGPoint(x: 37.5, y: 64),
            size: CGSize(width: 300, height: 400)
        ))
        gridView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(gridView)
        NSLayoutConstraint.activate([
            gridView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gridView.centerYAnchor.constraint(equalTo: centerYAnchor),
            gridView.widthAnchor.constraint(equalToConstant: 150),
            gridView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
