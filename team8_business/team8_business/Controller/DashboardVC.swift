//
//  DashboardVC.swift
//  team8_business
//
//  Created by Vincentius Phillips Zhuputra on 25/07/21.
//

import UIKit

class DashboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var lblRevNum: UILabel!
    @IBOutlet weak var btnPrice: UIButton!
    @IBOutlet weak var btnProduct: UIButton!
    @IBOutlet weak var btnService: UIButton!
    @IBOutlet weak var btnSeeAll: UIButton!
    @IBOutlet weak var tblLatest: UITableView!
    
    var trans:[RecordVoucher] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Voucher.getVoucher(id_voucher: "1", response: {r in
            self.trans = r
            print(self.trans[0].id)
            self.tblLatest.reloadData()
        })
        tblLatest.delegate=self
        tblLatest.dataSource=self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trans.count > 3 ? 3 : trans.count
        //return trans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTC", for: indexPath) as! DashboardTC
        
        cell.lblID.text = trans[indexPath.row].fields.keterangan
        
        return cell
    }
    
    @IBAction func priceRating(_ sender: Any) {
        
        
    }
    
}
