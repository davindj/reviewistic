//
//  AddTransVoucherVC.swift
//  team8_business
//
//  Created by Davin Djayadi on 26/07/21.
//

import UIKit

class AddTransVoucherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    var transaction: TransactionViewModel!
    var vouchers: [VoucherViewModel] = []
    var selectedIdx: Int = -1
    var successCallback: (()->Void)!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Generate Barcode"
        
        // Get All voucher
        Voucher.listVoucherToko(){ vouchers in
            self.vouchers = vouchers.map{ VoucherViewModel(recordVoucher: $0) }
            self.tableView.reloadData()
        }
        
        // Set Table View
        tableView.delegate=self
        tableView.dataSource=self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vouchers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "voucher", for: indexPath)
        
        if isCreateVoucherRow(idxRow: indexPath.row){
            cell.imageView?.image = UIImage(systemName: "plus")
            cell.textLabel?.text = "Create Voucher"
        }else{
            cell.imageView?.image = nil
            let voucher = vouchers[indexPath.row]
            cell.textLabel?.text = voucher.name
            cell.accessoryType = voucher.accesoryType
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isCreateVoucherRow(idxRow: indexPath.row){ // Jika Cell Create Voucher
            let vc = UIStoryboard.instantiateModalVoucher{ recordVoucher in
                self.vouchers.append(VoucherViewModel(recordVoucher: recordVoucher))
                let insIdx = IndexPath(row: self.vouchers.count-1, section: 0)
                self.tableView.insertRows(at: [insIdx], with: .automatic)
            }
            self.present(vc, animated: true)
        }else{ // Jika Cell Voucher
            let oldIdx = selectedIdx
            let newIdx = indexPath.row
            selectedIdx = newIdx
            // Update Display
            var updatedIdx = [Int]()
            updatedIdx.append(newIdx)
            if oldIdx >= 0 { //Jika old idx valid, maka udpate juga old idx
                updatedIdx.append(oldIdx)
                vouchers[oldIdx].isSelected = false
            }
            vouchers[newIdx].isSelected = true
            self.reloadTableViewAtRows(rows: updatedIdx)
        }
    }
    
    func reloadTableViewAtRows(rows: [Int]){
        let indexPaths = rows.map{ IndexPath(row: $0, section: 0) }
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
    
    @IBAction func generateBtnTapped(_ sender: Any) {
        let isValidIdx = selectedIdx >= 0
        if !isValidIdx {
            let ac = UIAlertController(title: "No Selected Voucher", message: "Please select voucher first!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(ac, animated: true)
            return
        }
        // jika valid
        // Update Airtable
        let voucher = vouchers[selectedIdx]
        Transaction.updateReviewStatus(airtableid: transaction.transObj.id,
                                       voucherid: voucher.recVoucher.id,
                                       status: TransactionStatus.BarcodeGenerated.rawValue)
        { isSuccess in
            self.dismiss(animated: true){
                self.successCallback()
            }
        }
    }
    
    // MARK: Helper Function
    func isCreateVoucherRow(idxRow: Int)->Bool{ idxRow == vouchers.count }
}
