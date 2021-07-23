//
//  ViewController.swift
//  team8_business
//
//  Created by Vincentius Phillips Zhuputra on 20/07/21.
//

import UIKit

class ReviewVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var transaksi:[Record] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transaksi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaksicell", for: indexPath) as! transaksi_cell
        
        
        cell.transaksiID.text = transaksi[indexPath.row].fields.NomorTransaksi
        cell.komentar.text = transaksi[indexPath.row].fields.Review
        cell.rating.text = String(transaksi[indexPath.row].fields.Rating)
        cell.tanggal.text = transaksi[indexPath.row].createdTime
        return cell
        
    }
    
    @IBOutlet weak var table_view: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        Transaction.callData { r in
            
            self.transaksi = r
            print(self.transaksi[0].id)
            self.table_view.reloadData()
        }
        
        table_view.delegate=self
        table_view.dataSource=self
        
        // Do any additional setup after loading the view.
    }
//
//  @IBAction func didChangeSegment(_ sender:UISegmentedControl){
//        if sender.selectedSegmentIndex == 0 {
//
//        }
//        else if sender.selectedSegmentIndex == 1{
//
//        }
//        else if sender.selectedSegmentIndex == 2{
//
//        }
//        else if sender.selectedSegmentIndex == 3{
//
//        }
//        else if sender.selectedSegmentIndex == 4{
//
//        }
//
//
//    }
    

}
class transaksi_cell: UITableViewCell {
    @IBOutlet weak var transaksiID: UILabel!
    @IBOutlet weak var komentar: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var tanggal: UILabel!
    
}

