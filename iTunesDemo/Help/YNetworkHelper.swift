//
//  YNetworkUtil.swift
//  iTunesDemo
//
//  Created by yaojunren on 2023/10/14.
//

import Foundation
import CoreTelephony
import Network
import UIKit

/// 网络工具箱
class YNetworkHelper {
    static let shared = YNetworkHelper()
    var monitor = NWPathMonitor()
    let cellular = CTCellularData()
    private init() {
        
    }
    func setup(){
        monitor.start(queue: DispatchQueue.main)
        monitor.pathUpdateHandler = {path in
            print(path)
            if #available(iOS 14.2, *) {
                print(path.debugDescription)
            }
        }
        
    }
    func checkNetworkAndAlert(){
        // 通过查看蜂窝状态 查看是否触发网络授权
        
        let cellularState = cellular.restrictedState
        if cellularState == .restrictedStateUnknown{
            URLSession.shared.dataTask(with: URLRequest(url: URL(fileURLWithPath: "https://baidu.com"))).resume()
            return
        }
        
        // check network state： 受限制就不提示  不可用就是说明网络状态
        if monitor.currentPath.status == .unsatisfied {
            var msg = YLocaliz.Network.notAvailable.str
            if #available(iOS 14.2, *) {
                switch monitor.currentPath.unsatisfiedReason {
                case .notAvailable:
                    msg = YLocaliz.Network.notAvailable.str
                case .cellularDenied:
                    msg = YLocaliz.Network.cellularDenied.str
                case .wifiDenied:
                    msg = YLocaliz.Network.wifiDenied.str
                case .localNetworkDenied:
                    msg = YLocaliz.Network.localNetworkDenied.str
                case .vpnInactive:
                    msg = YLocaliz.Network.vpnInactive.str
                @unknown default:
                    msg = YLocaliz.Network.notAvailable.str
                }
            }
            // 网络尚未连接，请检查设置
            guard let delegate = UIApplication.shared.connectedScenes.first?.delegate as? UIWindowSceneDelegate,
            let window = delegate.window else { return  }
            let root = window?.rootViewController
            root?.present(self.settingsAlert(msg), animated: true)
            return
        }
        // 当前的连接都不可用
        if monitor.currentPath.status == .requiresConnection {
            return
        }
        // 网络可用
    }
    func settingsAlert(_ title:String)->UIAlertController{
        let controller = UIAlertController(title: title, message: YLocaliz.Alert.message.str, preferredStyle: .alert)
        let okAction = UIAlertAction(title:YLocaliz.Alert.ok.str , style: .default) {_ in
        }
        let settingAction = UIAlertAction(title: YLocaliz.Alert.settings.str, style: .default) { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        controller.addAction(okAction)
        controller.addAction(settingAction)
        return controller
    }
}
