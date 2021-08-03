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
    
    var trans:[TransactionViewModel] = []
    var transDaily:[TransactionViewModel] = []
    var latestReview:[TransactionViewModel] = []
    
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
        var waktu = Date(timeIntervalSinceReferenceDate: -123456789.0)
        var date3 = Date(timeIntervalSinceReferenceDate: -123456789.0)
        
        Transaction.callData( response: {r in
            self.trans = r.map{
                TransactionViewModel.init(transaction: $0)
            }
            self.latestReview = self.trans
            self.tblLatest.reloadData()
            
            for re in self.trans {
                //array harian
                if (re.status == .Reviewed) {
                    if (formatter1.string(from: today) == re.tanggal) {
                        self.transDaily.append(re)
                        print("kepindah")
                    }
                    //array latest
                    if (date1 < re.waktu) {
                        date3 = waktu
                        waktu = date1
                        date1 = re.waktu
                        self.latestReview[2] = self.latestReview[1]
                        self.latestReview[1] = self.latestReview[0]
                        self.latestReview[0] = re
                    } else if (waktu < re.waktu) {
                        date3 = waktu
                        waktu = re.waktu
                        self.latestReview[2] = self.latestReview[1]
                        self.latestReview[1] = re
                    } else if (date3 < re.waktu) {
                        date3 = re.waktu
                        self.latestReview[2] = re
                    }
                    print(date1)
                }
            }
            //Untuk rata-rata harian
            if (self.transDaily.count > 0) {
                avgPriceRating = self.transDaily.reduce(0, {result,currentelement in return result+currentelement.RPrice}) / self.transDaily.count
                avgServiceRating = self.transDaily.reduce(0, {$0+$1.RService}) / self.transDaily.count
                avgProdukRating = self.transDaily.reduce(0) {$0+$1.RProduct} / self.transDaily.count
                
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
        
        cell.lblNomorTransaksi.text = latestReview[indexPath.row].noTransaction
        cell.lblAvgRating.text = String(format: "%.1f", latestReview[indexPath.row].avgrate)
        cell.lblReview.text = latestReview[indexPath.row].review
        cell.lblPriceR.text = latestReview[indexPath.row].ratingPrice
        cell.lblServiceR.text = latestReview[indexPath.row].ratingService
        cell.lblProductR.text = latestReview[indexPath.row].ratingProduct
        cell.lblCreatedTime.text = latestReview[indexPath.row].waktu.toString(format: "dd-MM-yyyy")
            
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = latestReview[indexPath.row]
        //let transaction = TransactionViewModel(transaction: record)
        
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
    
    func navigateToDailys(category:String){
        let storyboard = UIStoryboard(name: "Dailys", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! DailysVC
        vc.namakategori = category
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
