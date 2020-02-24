//
//  Stylable.swift
//  UI
//
//  Created by Damian Kolasiński on 23/02/2020.
//  Copyright © 2020 Damian Kolasiński. All rights reserved.
//

import UIKit

public protocol Stylable: UIView {}
extension UIView: Stylable {}

extension Stylable {
    public static func styled(_ styles: Style<Self>...) -> Self {
        let view = Self()
        styles.forEach { $0(view) }
        return view
    }
    
    public func apply(_ styles: Style<Self>...) {
        styles.forEach { $0(self) }
    }
}
