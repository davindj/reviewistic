//
//  Storyboard.swift
//  team8_business
//
//  Created by Davin Djayadi on 28/07/21.
//

import Foundation
import UIKit

extension UIStoryboard{
    static func instantiateModalVoucher(successCallback: @escaping (Voucher) -> Void) -> UINavigationController{
        let storyboard = UIStoryboard(name: "ModalVoucher", bundle: nil)
        let nvc = storyboard.instantiateInitialViewController() as! UINavigationController
        let vc = nvc.visibleViewController as! AddVoucherVC
        vc.successCallback = successCallback
        return nvc
    }
}
