//
//  AddTransVoucherVC.swift
//  team8_business
//
//  Created by Davin Djayadi on 26/07/21.
//

import UIKit

class AddTransVoucherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    var vouchers: [VoucherViewModel] = []
    var selectedIdx: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Generate Voucher"
        
        // Get All voucher
        Voucher.listVoucherToko(id_toko: "1"){ vouchers in
            self.vouchers = vouchers.map{ VoucherViewModel(recordVoucher: $0) }
            self.tableView.reloadData()
        }
        
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
        cell.textLabel?.text = voucher.name
        cell.accessoryType = voucher.accesoryType
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
            vouchers[oldIdx.row].isSelected = false
        }
        vouchers[newIdx.row].isSelected = true
        tableView.reloadRows(at: updatedIdx, with: .automatic)
    }
}
