//
//  UIViewProtocol.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/4.
//

import Foundation
import UIKit
import Combine
protocol NibFromClassNameble{
}
extension NibFromClassNameble where Self: UIView {
    static func nibFromClassName() -> UINib{
        UINib(nibName: String(describing: self), bundle: nil)
    }
}

enum ShapeType{
    case round(CGFloat)
    case circle
}
enum ActionItem {
    case button(UIImage)
}
