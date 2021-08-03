//
//  DetailVoucher.swift
//  team8_business
//
//  Created by Michael Hans on 03/08/21.
//

import UIKit

class DetailVoucher: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailPromo", for: indexPath) as! outletDetailVoucher
        let listTransVouch = transaksi[indexPath.row]
        
        
        //cell.Status.text = UIImage (systemName: "note.text")
        cell.noIDTrx.text = "#"+listTransVouch.fields.NomorTransaksi
        //cell.ExpDate.text = voucherAll.fields.exp_date
        //Configure the cell...
        
        return cell
    }
    
    var transactionVM: TransactionViewModel!
    //@IBOutlet weak var Count: UILabel!
    @IBOutlet weak var detailVoucherView: UITableView!
    
    @IBOutlet weak var vouchID: UILabel!
    
    var vouchObj: RecordVoucher!
    var transaksi:[Record] = []
    var listVoucher:[RecordVoucher] = []
    var vouchers:[VoucherViewModel] = []
 
    let cellSpacingHeight: CGFloat = 10
    var jumlahVoucher: Int = 0
    var namaVoucher: String { "\(vouchObj.fields.nama)"}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        detailVoucherView.delegate = self
        detailVoucherView.dataSource = self
        
        loadDataFromAPI(voucherID: vouchObj.id){
            //self.Count.text = String(self.transaksi.count)
            self.jumlahVoucher = self.transaksi.count
            self.detailVoucherView.reloadData()
            self.navigationItem.title = "Voucher Used :  \(self.jumlahVoucher)"
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        vouchID.text = "Nama Voucher : \(self.namaVoucher)"
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transaksi.count
    }
    
    func loadDataFromAPI(voucherID: String, callback: @escaping()->Void){
        Transaction.getAllTrans(voucherID: voucherID) { r in
            self.transaksi = r.filter{$0.fields.status == 2}
            callback()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trans = transaksi[indexPath.row]
        let transactionVM = TransactionViewModel(transaction: trans)
        
        let storyboard = UIStoryboard(name: "Transaction", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "DetailTransaction") as? DetailTransactionVC{
            vc.transactionVM = transactionVM
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    /*
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "detailPromo", for: indexPath) as! outletDetailVoucher
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}

class outletDetailVoucher: UITableViewCell{
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var noIDTrx: UILabel!
}
