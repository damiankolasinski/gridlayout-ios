//
//  GridLayoutView.swift
//  GridLayout
//
//  Created by Damian Kolasiński on 22/02/2020.
//  Copyright © 2020 Damian Kolasiński. All rights reserved.
//

import UIKit
import Combine

public struct GridLayoutElementViewModel {
    let title: String
    let isSelected: AnyPublisher<Bool, Never>
    let onTapped: () -> Void
    
    public init(
        title: String,
        isSelected: AnyPublisher<Bool, Never>,
        onTapped: @escaping () -> Void
    ) {
        self.title = title
        self.isSelected = isSelected
        self.onTapped = onTapped
    }
}

public struct GridLayoutViewModel {
    let elements: [GridLayoutElementViewModel]
    
    public init(elements: [GridLayoutElementViewModel]) {
        self.elements = elements
    }
}

public class GridLayoutView: UIView {
    private typealias GridRow = [UIView]
    private let scrollView = UIScrollView()
    private let buttons: [UIButton]
    private let disposeBag = DisposeBag()
    
    private let verticalSpacing: CGFloat = 14
    private let horizontalSpacing: CGFloat = 8
    private var maxRowWidth: CGFloat { bounds.width }
    
    public init(viewModel: GridLayoutViewModel) {
        self.buttons = (0..<viewModel.elements.count)
            .map { _ in UIButton() }
        super.init(frame: .zero)
        setupSubviews()
        bind(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        layoutButtons()
        layoutScrollViewIfNeeded()
    }
    
    private func bind(with viewModel: GridLayoutViewModel) {
        zip(buttons, viewModel.elements)
            .forEach(bindButton(_:with:))
    }
    
    private func bindButton(
        _ button: UIButton,
        with viewModel: GridLayoutElementViewModel
    ) {
        setupButtonTitleAndFrame(button, with: viewModel.title)
        button.publisher(for: .touchUpInside)
            .sink(receiveValue: viewModel.onTapped)
            .disposed(by: disposeBag)
        viewModel.isSelected.sink(receiveValue: {
                button.setTitleColor(
                    $0 ? .white : .blue,
                    for: .normal
                )
                button.backgroundColor = $0 ? .blue : .white
            })
            .disposed(by: disposeBag)
    }
    
    private func setupButtonTitleAndFrame(
        _ button: UIButton,
        with title: String
    ) {
        button.setTitle(title, for: .normal)
        let intrinsicSize = button.titleLabel!.intrinsicContentSize
        button.frame.size = CGSize(
            width: intrinsicSize.width + 24,
            height: intrinsicSize.height + 19
        )
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.bounds.height / 2
    }
}

extension GridLayoutView {
    private func layoutButtons() {
        buttons
            .reduce(
                into: [GridRow](),
                reduceIntoRows(_:nextElement:)
            )
            .enumerated()
            .forEach(setOriginsOfRowAtIndex(_:row:))
    }
    
    private func reduceIntoRows(_ rows: inout [GridRow], nextElement element: UIView) {
        if var lastRow = rows.last, canElement(element, fitIntoRow: lastRow) {
            lastRow.append(element)
            rows.removeLast(1)
            rows.append(lastRow)
        } else {
            rows.append([element])
        }
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
    
    private func setOriginsOfRowAtIndex(
        _ rowIndex: Int,
        row: GridRow
    ) {
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
    
    private func layoutScrollViewIfNeeded() {
        guard let lastButton = buttons.last else { return }
        scrollView.contentSize = CGSize(
            width: bounds.width,
            height: lastButton.frame.maxY
        )
    }
}

extension GridLayoutView {
    private func setupSubviews() {
        setupScrollView()
        setupButtons()
    }
    
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
    
    private func setupButtons() {
        buttons.forEach { button in
            button.titleLabel!.font = .systemFont(ofSize: 14)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.blue.cgColor
            scrollView.addSubview(button)
        }
    }
}
