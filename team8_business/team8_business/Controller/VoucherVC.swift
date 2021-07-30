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
    var vouchers: [VoucherViewModel] = []
    
    var successCallback: ((RecordVoucher)->Void)!
    
    override func viewDidLoad() {
        
        navigationItem.title = "Promo"
        navigationController?.navigationBar.prefersLargeTitles = true
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(refreshTrigger), for: .valueChanged)
        tableviewControllerVoucher.refreshControl = refreshControl
        
        tableviewControllerVoucher.dataSource = self       
        tableviewControllerVoucher.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadDataFromAPI(callback: @escaping()->Void){
        Voucher.listVoucherToko() { r in
            self.listVoucher = r
            print(self.listVoucher)
            self.tableviewControllerVoucher.reloadData()
        }
        callback()
    }
    
    
    @objc func refreshTrigger(){
        loadDataFromAPI{
            self.tableviewControllerVoucher.refreshControl?.endRefreshing()
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return listVoucher.count
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
          //Code I want to do here
        let alert = UIAlertController(title: "Do you want to Delete Promo ?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: "Default action"), style: .default, handler: { _ in
            self.listVoucher.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        NSLog("The \"OK\" alert occured.")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .default, handler: { _ in
            self.tableviewControllerVoucher.reloadData()
        NSLog("Cancel delete promo")
        }))
        self.present(alert, animated: true, completion: nil)
        
        
        
      }
      let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        

      return swipeActions
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
    
    @IBAction func tambahVoucher(_ sender: Any) {
        let vc1 = UIStoryboard.instantiateModalVoucher{ recordVouchervs in
         // setelah tambah voucher
            self.listVoucher.append(recordVouchervs)
            self.tableviewControllerVoucher.reloadData()
        }
        self.present(vc1, animated: true)
        print("masukoi")
    }
    
}


class tableviewVoucherCell: UITableViewCell{
    @IBOutlet weak var NamaVoucher: UILabel!
    @IBOutlet weak var Keterangan: UILabel!
    @IBOutlet weak var ExpDate: UILabel!
    @IBOutlet weak var viewcell: UIView!
}
