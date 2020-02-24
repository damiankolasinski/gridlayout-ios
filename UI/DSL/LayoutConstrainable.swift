//
//  LayoutConstrainable.swift
//  UI
//
//  Created by Damian Kolasiński on 23/02/2020.
//  Copyright © 2020 Damian Kolasiński. All rights reserved.
//

import UIKit

public protocol LayoutConstrainable {
    var layoutConstraints: [NSLayoutConstraint] { get }
}

extension NSLayoutConstraint: LayoutConstrainable {
    public var layoutConstraints: [NSLayoutConstraint] { return [self] }
}

extension Array: LayoutConstrainable where Element == NSLayoutConstraint {
    public var layoutConstraints: [NSLayoutConstraint] { return self }
}

extension NSLayoutConstraint {
    public static func activate(_ constrainables: LayoutConstrainable...) {
        activate(constrainables.flatMap({ $0.layoutConstraints }))
    }
}
