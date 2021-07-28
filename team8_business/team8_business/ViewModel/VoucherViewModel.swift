//
//  VoucherViewModel.swift
//  team8_business
//
//  Created by Davin Djayadi on 27/07/21.
//

import Foundation
import UIKit

struct VoucherViewModel {
    private let recVoucher: RecordVoucher
    var isSelected: Bool
    
    init(recordVoucher: RecordVoucher){
        self.recVoucher = recordVoucher
        self.isSelected = false
    }
    
    var name: String{ recVoucher.fields.nama }
    var accesoryType: UITableViewCell.AccessoryType { isSelected ? .checkmark : .none }
}
