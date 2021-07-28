//
//  DashboardVC.swift
//  team8_business
//
//  Created by Vincentius Phillips Zhuputra on 25/07/21.
//

import UIKit

class DashboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var lblRevNum: UILabel!
    @IBOutlet weak var btnSeeAll: UIButton!
    @IBOutlet weak var tblLatest: UITableView!
    @IBOutlet weak var lblPriceRating: UILabel!
    @IBOutlet weak var lblServiceRating: UILabel!
    @IBOutlet weak var lblProdukRating: UILabel!
    
    var trans:[Record] = []
    var transDaily:[Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        print(formatter1.string(from: today))
        var avgPriceRating :Int = 0
        var avgServiceRating :Int = 0
        var avgProdukRating :Int = 0
        
        Transaction.callData( response: {r in
            self.trans = r
            print(self.trans[0].id)
            self.tblLatest.reloadData()
            
            for re in self.trans {
                if (formatter1.string(from: today) == re.date) {
                    self.transDaily.append(re)
                    print("kepindah")
                }
            }
            avgPriceRating = self.transDaily.reduce(0, {result,currentelement in return result+currentelement.fields.RatingPrice}) / self.transDaily.count
            avgServiceRating = self.transDaily.reduce(0, {$0+$1.fields.RatingService}) / self.transDaily.count
            avgProdukRating = self.transDaily.reduce(0) {$0+$1.fields.RatingProduk} / self.transDaily.count
            
            self.lblRevNum.text = "Based on "+String(self.transDaily.count)+" reviews"
            self.lblPriceRating.text = String(avgPriceRating)+"⭐️"
            self.lblServiceRating.text = String(avgServiceRating)+"⭐️"
            self.lblProdukRating.text = String(avgProdukRating)+"⭐️"
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
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 2
        
        cell.lblNomorTransaksi.text = trans[indexPath.row].fields.NomorTransaksi
        cell.lblAvgRating.text = String(trans[indexPath.row].avgrate)
        cell.lblReview.text = trans[indexPath.row].fields.Review
        cell.lblPriceR.text = String(trans[indexPath.row].fields.RatingPrice)+"⭐️"
        cell.lblServiceR.text = String(trans[indexPath.row].fields.RatingService)+"⭐️"
        cell.lblProductR.text = String(trans[indexPath.row].fields.RatingProduk)+"⭐️"
            
        
        return cell
    }
    
    @IBAction func priceRating(_ sender: Any) {
        
        
    }
    
}
