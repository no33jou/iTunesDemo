//
//  YLocaliz.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/6.
//

import Foundation
protocol Localizable {}

extension Localizable {
    var str: String {
        let prefix = String(describing: type(of: self)).split(separator: ".").last ?? ""
        let key = prefix + "." + String(describing: self)
        return NSLocalizedString(key, comment: "")
    }
}

enum YLocaliz {
    enum Home: Localizable {
        case title
        case bookmarkHeader
        case searchPlaceholder
    }

    enum Alert: Localizable {
        case networkError
        case unownedError
        case ok
        case settings
        case message
    }

    enum Search: Localizable {
        case song
        case album
        case artist
        case all
        case noDataTip
        case networkErrorTip
    }

    enum Network: Localizable {
        case notAvailable
        case cellularDenied
        case wifiDenied
        case localNetworkDenied
        case vpnInactive
    }
}
