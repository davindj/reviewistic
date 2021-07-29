//
//  VoucherVC.swift
//  team8_business
//
//  Created by Michael Hans on 26/07/21.
//

import UIKit
import SwiftUI

class VoucherVC: UITableViewController{
        
    @IBOutlet var tableviewControllerVoucher: UITableView!
    
    var listVoucher:[RecordVoucher] = []
    var filteredData: [RecordVoucher] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Voucher.listVoucherToko(id_toko: "2") { r in
            self.listVoucher = r
            self.tableviewControllerVoucher.reloadData()
        }
        tableviewControllerVoucher.dataSource = self       
        tableviewControllerVoucher.delegate = self
        
        tableviewControllerVoucher.reloadData()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return listVoucher.count
    }
      override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath ) -> [UITableViewRowAction]? {
            // #warning Incomplete implementation, return the number of rows
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            //delete variable promo
            self.listVoucher.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
      }
     return [deleteAction]
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewvouchercell", for: indexPath) as! tableviewVoucherCell
        let voucherAll = listVoucher[indexPath.row]
        
    
        cell.NamaVoucher.text = voucherAll.fields.nama
        cell.Keterangan.text = voucherAll.fields.keterangan
        cell.ExpDate.text = voucherAll.fields.exp_date
        // Configure the cell...
     
        
        cell.viewcell.layer.cornerRadius = 10
     return cell
     }

    
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


class tableviewVoucherCell: UITableViewCell{
    @IBOutlet weak var NamaVoucher: UILabel!
    @IBOutlet weak var Keterangan: UILabel!
    @IBOutlet weak var ExpDate: UILabel!
    @IBOutlet weak var viewcell: UIView!
}
