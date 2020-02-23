//
//  CategoriesInteractor.swift
//  GridLayoutExample
//
//  Created by Damian Kolasiński on 22/02/2020.
//  Copyright © 2020 Damian Kolasiński. All rights reserved.
//

import Combine

enum CategoriesRoute {
    
}

final class CategoriesInteractor {
    typealias Outputs = (CategoriesViewModel, AnyPublisher<CategoriesRoute, Never>)
    
    func start() -> Outputs {
        return (
            CategoriesViewModel(),
            Empty(completeImmediately: true).eraseToAnyPublisher()
        )
    }
}
