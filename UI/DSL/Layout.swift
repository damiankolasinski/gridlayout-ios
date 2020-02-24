//
//  Layout.swift
//  GridLayoutExample
//
//  Created by Damian Kolasiński on 23/02/2020.
//  Copyright © 2020 Damian Kolasiński. All rights reserved.
//

import UIKit

public struct LayoutAnchor<T: AnyObject> {
    fileprivate let anchor: NSLayoutAnchor<T>
    fileprivate let constant: CGFloat
}

public func + <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> LayoutAnchor<T> {
    return LayoutAnchor(anchor: lhs, constant: rhs)
}

public func - <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> LayoutAnchor<T> {
    return lhs + (-rhs)
}

public func == <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: rhs)
}

public func >= <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualTo: rhs)
}

public func <= <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualTo: rhs)
}

public func == <T>(lhs: NSLayoutAnchor<T>, rhs: LayoutAnchor<T>) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: rhs.anchor, constant: rhs.constant)
}

public func >= <T>(lhs: NSLayoutAnchor<T>, rhs: LayoutAnchor<T>) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.constant)
}

public func <= <T>(lhs: NSLayoutAnchor<T>, rhs: LayoutAnchor<T>) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant)
}

// MARK: NSLayoutDimension

public struct LayoutDimension {
    fileprivate let dimension: NSLayoutDimension
    fileprivate let multiplier: CGFloat
    fileprivate let constant: CGFloat
}

public func + (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutDimension {
    return LayoutDimension(dimension: lhs, multiplier: 1, constant: rhs)
}

public func + (lhs: LayoutDimension, rhs: CGFloat) -> LayoutDimension {
    return LayoutDimension(dimension: lhs.dimension, multiplier: lhs.multiplier, constant: rhs)
}

public func - (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutDimension {
    return LayoutDimension(dimension: lhs, multiplier: 1, constant: -rhs)
}

public func - (lhs: LayoutDimension, rhs: CGFloat) -> LayoutDimension {
    return LayoutDimension(dimension: lhs.dimension, multiplier: lhs.multiplier, constant: -rhs)
}

public func * (lhs: NSLayoutDimension, rhs: CGFloat) -> LayoutDimension {
    return LayoutDimension(dimension: lhs, multiplier: rhs, constant: 0)
}

public func == (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.constraint(equalToConstant: rhs)
}

public func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualToConstant: rhs)
}

public func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualToConstant: rhs)
}

public func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: rhs)
}

public func >= (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualTo: rhs)
}

public func <= (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualTo: rhs)
}

public func == (lhs: NSLayoutDimension, rhs: LayoutDimension) -> NSLayoutConstraint {
    return lhs.constraint(equalTo: rhs.dimension, multiplier: rhs.multiplier, constant: rhs.constant)
}

public func >= (lhs: NSLayoutDimension, rhs: LayoutDimension) -> NSLayoutConstraint {
    return lhs.constraint(greaterThanOrEqualTo: rhs.dimension, multiplier: rhs.multiplier, constant: rhs.constant)
}

public func <= (lhs: NSLayoutDimension, rhs: LayoutDimension) -> NSLayoutConstraint {
    return lhs.constraint(lessThanOrEqualTo: rhs.dimension, multiplier: rhs.multiplier, constant: rhs.constant)
}

// MARK: Nested

public func == (lhs: [NSLayoutDimension], rhs: CGFloat) -> [NSLayoutConstraint] {
    return lhs.map { $0 == rhs }
}

// MARK: LayoutPriority

infix operator ~: AssignmentPrecedence
public func ~ (lhs: NSLayoutConstraint, rhs: UILayoutPriority) -> NSLayoutConstraint {
    lhs.priority = rhs
    return lhs
}

