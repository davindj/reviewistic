//
//  VoucherViewModel.swift
//  team8_business
//
//  Created by Davin Djayadi on 27/07/21.
//

import Foundation
import UIKit

struct VoucherViewModel {
    private let voucher: Voucher
    var isSelected: Bool
    
    init(recordVoucher: RecordVoucher){
        self.voucher = recordVoucher.fields
        self.isSelected = false
    }
    
    var name: String{ voucher.nama }
    var accesoryType: UITableViewCell.AccessoryType { isSelected ? .checkmark : .none }
}
