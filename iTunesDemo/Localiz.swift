//
//  Localiz.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/6.
//

import Foundation
protocol Localizable {}

extension Localizable {
    func stringFromLocal() -> String {
        return NSLocalizedString(String(describing: self), comment: "")
    }
}

enum Localiz {
    enum Home: Localizable {
        case title
        case bookmarkHeader
    }

    enum Search: Localizable {
        case song
        case album
        case artist
    }
}
