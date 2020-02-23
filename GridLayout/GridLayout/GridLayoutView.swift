//
//  GridLayoutView.swift
//  GridLayout
//
//  Created by Damian Kolasiński on 22/02/2020.
//  Copyright © 2020 Damian Kolasiński. All rights reserved.
//

import UIKit
import Combine

struct GridLayoutViewModel {
    
}

public class GridLayoutView: UIView {
    private typealias GridRow = [UIView]
    private let scrollView = UIScrollView()
    private lazy var buttons: [UIButton] = titles.map {
        let button = UIButton()
        button.setTitle($0, for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 14)
        let size = button.titleLabel!.intrinsicContentSize
        button.frame.size = CGSize(
            width: size.width + 10,
            height: size.height + 19
        )
        button.backgroundColor = .red
        scrollView.addSubview(button)
        return button
    }
    
    private let verticalSpacing: CGFloat = 14
    private let horizontalSpacing: CGFloat = 8
    private var maxRowWidth: CGFloat { bounds.width }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        buttons
            .reduce(into: [GridRow](), { rows, button in
                if var lastRow = rows.last, canElement(button, fitIntoRow: lastRow) {
                    lastRow.append(button)
                    rows.removeLast(1)
                    rows.append(lastRow)
                } else {
                    rows.append([button])
                }
            })
            .enumerated()
            .forEach { rowIndex, row in
                let rowWidth = calculateWidthForRow(row)
                row.enumerated().forEach { elementIndex, element in
                    let previousIndex = elementIndex - 1
                    let elementX = previousIndex >= 0
                        ? row[previousIndex].frame.maxX + horizontalSpacing
                        : (maxRowWidth - rowWidth) / 2
                    element.frame.origin = CGPoint(
                        x: elementX,
                        y: CGFloat(rowIndex) * (36 + verticalSpacing)
                    )
                }
            }
        
        guard let lastButton = buttons.last else { return }
        scrollView.contentSize = CGSize(
            width: bounds.width,
            height: lastButton.frame.maxY
        )
    }
    
    private func canElement(
        _ element: UIView,
        fitIntoRow row: GridRow
    ) -> Bool {
        let rowWidth = calculateWidthForRow(row)
        let rowWidthAfterUpdate = rowWidth
            + horizontalSpacing
            + element.bounds.width
        return rowWidthAfterUpdate <= maxRowWidth
    }
    
    private func calculateWidthForRow(_ row: GridRow) -> CGFloat {
        let elementsWidth = row.reduce(
            CGFloat.zero,
            { $0 + $1.bounds.width }
        )
        let spacingsWidth = CGFloat(row.count - 1) * horizontalSpacing
        return elementsWidth + spacingsWidth
    }
}

extension GridLayoutView {
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

private let titles = [
    "Culture",
    "World news",
    "Culture",
    "Religion",
    "Sports",
    "Fashion",
    "Food"
]
