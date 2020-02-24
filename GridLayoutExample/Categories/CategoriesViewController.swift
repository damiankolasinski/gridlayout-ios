//
//  CategoriesViewController.swift
//  GridLayoutExample
//
//  Created by Damian Kolasiński on 22/02/2020.
//  Copyright © 2020 Damian Kolasiński. All rights reserved.
//

import UIKit
import Combine

final class CategoriesViewController: UIViewController {
    private let interactor: CategoriesInteractor
    private let viewModel: CategoriesViewModel
    
    init(interactor: CategoriesInteractor) {
        self.interactor = interactor
        let (viewModel, routes) = interactor.start()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        observeRoutes(routes)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("Storyboards are not compatible with true love and beauty") }
    
    override func loadView() {
        view = CategoriesView(
            frame: UIScreen.main.bounds,
            viewModel: viewModel
        )
    }
    
    private func observeRoutes(_ routes: AnyPublisher<CategoriesRoute, Never>) {
        
    }
}
