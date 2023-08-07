//
//  UIViewController+Extension.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/07.
//

import UIKit

extension UIViewController {
    func showPopUp(title: String? = nil,
                   message: String? = nil) {
        let popUpViewController = PopUpViewController(titleText: title,
                                                      messageText: message)
        present(popUpViewController, animated: false)
    }
}
