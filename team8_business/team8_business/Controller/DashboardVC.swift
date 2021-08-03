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
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var borderView: UIView!
    
    var trans:[Record] = []
    var transDaily:[Record] = []
    var latestReview:[Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Item
        navigationItem.title = "Reviews"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // UIRefresher
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(refreshTrigger), for: .valueChanged)
        tblLatest.refreshControl = refreshControl
        
        tblLatest.delegate=self
        tblLatest.dataSource=self
        
        priceView.layer.cornerRadius = 10
        serviceView.layer.cornerRadius = 10
        productView.layer.cornerRadius = 10
        
        loadDataFromAPI{}
    }
    
    func loadDataFromAPI(callback: @escaping()->Void){
        transDaily = []
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        print(formatter1.string(from: today))
        
        var avgPriceRating :Int = 0
        var avgServiceRating :Int = 0
        var avgProdukRating :Int = 0
        
        var date1 = Date(timeIntervalSinceReferenceDate: -123456789.0)
        var date2 = Date(timeIntervalSinceReferenceDate: -123456789.0)
        var date3 = Date(timeIntervalSinceReferenceDate: -123456789.0)
        
        Transaction.callData( response: {r in
            self.trans = r
            self.latestReview = r
            self.tblLatest.reloadData()
            
            for re in self.trans {
                //array harian
                if (re.fields.status == 2) {
                    if (formatter1.string(from: today) == re.date) {
                        self.transDaily.append(re)
                        print("kepindah")
                    }
                    //array latest
                    if (date1 < re.date2) {
                        date3 = date2
                        date2 = date1
                        date1 = re.date2
                        self.latestReview[2] = self.latestReview[1]
                        self.latestReview[1] = self.latestReview[0]
                        self.latestReview[0] = re
                    } else if (date2 < re.date2) {
                        date3 = date2
                        date2 = re.date2
                        self.latestReview[2] = self.latestReview[1]
                        self.latestReview[1] = re
                    } else if (date3 < re.date2) {
                        date3 = re.date2
                        self.latestReview[2] = re
                    }
                    print(date1)
                }
            }
            //Untuk rata-rata harian
            if (self.transDaily.count > 0) {
                avgPriceRating = self.transDaily.reduce(0, {result,currentelement in return result+currentelement.fields.RatingPrice}) / self.transDaily.count
                avgServiceRating = self.transDaily.reduce(0, {$0+$1.fields.RatingService}) / self.transDaily.count
                avgProdukRating = self.transDaily.reduce(0) {$0+$1.fields.RatingProduk} / self.transDaily.count
                
                self.lblRevNum.text = "Based on "+String(self.transDaily.count)+" reviews"
                self.lblPriceRating.text = String(avgPriceRating)
                self.lblServiceRating.text = String(avgServiceRating)
                self.lblProdukRating.text = String(avgProdukRating)
            } else {
                self.lblRevNum.text = "No reviews"
                self.lblPriceRating.text = "0"
                self.lblServiceRating.text = "0"
                self.lblProdukRating.text = "0"
            }
            // Panggil Callback
            callback()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestReview.count > 3 ? 3 : latestReview.count
        //return trans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTC", for: indexPath) as! DashboardTC
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 2
        cell.lblReview.numberOfLines = 5
        
        cell.lblNomorTransaksi.text = "#"+latestReview[indexPath.row].fields.NomorTransaksi
        cell.lblAvgRating.text = String(format: "%.1f", latestReview[indexPath.row].avgrate)
        cell.lblReview.text = latestReview[indexPath.row].fields.Review
        cell.lblPriceR.text = String(latestReview[indexPath.row].fields.RatingPrice)
        cell.lblServiceR.text = String(latestReview[indexPath.row].fields.RatingService)
        cell.lblProductR.text = String(latestReview[indexPath.row].fields.RatingProduk)
        cell.lblCreatedTime.text = latestReview[indexPath.row].date2.toString(format: "dd-MM-yyyy")
            
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record = latestReview[indexPath.row]
        let transaction = TransactionViewModel(transaction: record)
        
        let storyboard = UIStoryboard(name: "Transaction", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "DetailTransaction") as? DetailTransactionVC{
            vc.transactionVM = transaction
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func seeAllClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Review", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ReviewVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func priceBtnTapped(_ sender: Any) {
        navigateToDailys(category: "RatingPrice")
    }
    
    @IBAction func serviceBtnTapped(_ sender: Any) {
        navigateToDailys(category: "RatingService")
    }
    
    @IBAction func productBtnTapped(_ sender: Any) {
        navigateToDailys(category: "RatingProduk")
    }
    
    @objc func refreshTrigger(){
        loadDataFromAPI{
            self.tblLatest.refreshControl?.endRefreshing()
        }
    }
    
    func navigateToDailys(category: String){
        let storyboard = UIStoryboard(name: "Dailys", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! DailysVC
        vc.kategoriID = category
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
