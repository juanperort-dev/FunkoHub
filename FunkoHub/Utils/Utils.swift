//
//  Utils.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import Foundation
import UIKit

protocol FunkoDelegate: AnyObject {
    func sendData(data: KeyDataFunkos)
}

func showAlert(title: String, message: String, messageButton: String, viewcontroller: UIViewController, onDismiss: (() -> Void)? = nil) {
    guard UIApplication.shared.windows.first(where: { $0.isKeyWindow }) != nil else { return }
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let actionOK = UIAlertAction(title: messageButton, style: .default) { _ in
    onDismiss?()
    }
    alert.addAction(actionOK)
    viewcontroller.present(alert, animated: true, completion: nil)
}

func showPopup(title: String, message: String, viewcontroller: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: nil))

    viewcontroller.present(alert, animated: true, completion: nil)
}
