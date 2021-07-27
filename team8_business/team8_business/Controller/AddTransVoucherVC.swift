//
//  AddTransVoucherVC.swift
//  team8_business
//
//  Created by Davin Djayadi on 26/07/21.
//

import UIKit

class AddTransVoucherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    var vouchers: [TempVoucher] = []
    var selectedIdx: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Generate Voucher"
        
        // Get All voucher
        vouchers += [
            TempVoucher(id: "Voucher 1"),
            TempVoucher(id: "Voucher 2"),
            TempVoucher(id: "Voucher 3")
        ]
        
        // Set Table View
        tableView.delegate=self
        tableView.dataSource=self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vouchers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "voucher", for: indexPath)
        let voucher = vouchers[indexPath.row]
        let isSelected = indexPath.row == selectedIdx
        cell.textLabel?.text = voucher.id
        cell.accessoryType = isSelected ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oldIdx = IndexPath(row: selectedIdx, section: 0)
        let newIdx = indexPath
        selectedIdx = indexPath.row
        
        // Update Display
        var updatedIdx = [IndexPath]()
        updatedIdx.append(newIdx)
        if oldIdx.row >= 0 {
            updatedIdx.append(oldIdx)
        }
        tableView.reloadRows(at: updatedIdx, with: .automatic)
    }
}

struct TempVoucher {
    let id: String
}
