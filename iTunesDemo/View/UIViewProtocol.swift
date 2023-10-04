//
//  UIViewProtocol.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/4.
//

import Foundation
import UIKit
protocol NibFromClassNameble{
}
extension NibFromClassNameble where Self: UIView {
    static func nibFromClassName() -> UINib{
        UINib(nibName: String(describing: self), bundle: nil)
    }
}
