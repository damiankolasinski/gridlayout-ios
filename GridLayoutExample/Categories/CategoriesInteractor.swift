//
//  CategoriesInteractor.swift
//  GridLayoutExample
//
//  Created by Damian Kolasiński on 22/02/2020.
//  Copyright © 2020 Damian Kolasiński. All rights reserved.
//

import Combine
import GridLayout

enum CategoriesRoute {
    
}

final class CategoriesInteractor {
    typealias Outputs = (CategoriesViewModel, AnyPublisher<CategoriesRoute, Never>)
    
    func start() -> Outputs {
        return (
            CategoriesViewModel(gridViewModel: GridLayoutViewModel(
                elements: titles.map {
                    GridLayoutElementViewModel(
                        title: $0,
                        isSelected: Just(false).eraseToAnyPublisher(),
                        onTapped: {}
                    )
                }
            )),
            Empty(completeImmediately: true).eraseToAnyPublisher()
        )
    }
}

private let titles = [
    "World news",
    "Sports",
    "Religion",
    "Food",
    "Lifestyle",
    "Culture"
]
