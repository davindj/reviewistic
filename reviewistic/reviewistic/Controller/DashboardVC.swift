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
        guard let storeId = try? UserDefaults.standard.getUserId() else { return }
        
        Transaction.getAllReviewedTransactionsByStoreId(storeId: storeId){r in
            self.trans = r.map{ TransactionViewModel.init(transaction: $0) }
            self.latestReview = Array(self.trans.sorted{ $0.waktu < $1.waktu }.prefix(3)) // 3 first element for latest review
            
            // Rata - rata
            if (self.trans.isEmpty) {
                self.lblRevNum.text = "No reviews"
                self.lblPriceRating.text = "0"
                self.lblServiceRating.text = "0"
                self.lblProdukRating.text = "0"
            } else {
                let avgPriceRating = self.trans.reduce(0){$0+$1.RPrice} / self.trans.count
                let avgServiceRating = self.trans.reduce(0){$0+$1.RService} / self.trans.count
                let avgProdukRating = self.trans.reduce(0){$0+$1.RProduct} / self.trans.count
                
                self.lblRevNum.text = "Based on "+String(self.trans.count)+" reviews"
                self.lblPriceRating.text = String(avgPriceRating)
                self.lblServiceRating.text = String(avgServiceRating)
                self.lblProdukRating.text = String(avgProdukRating)
            }
            self.tblLatest.reloadData()
            
            callback()
        }
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
        navigateToDailys(kategori: .Price)
    }
    
    @IBAction func serviceBtnTapped(_ sender: Any) {
        navigateToDailys(kategori: .Service)
    }
    
    @IBAction func productBtnTapped(_ sender: Any) {
        navigateToDailys(kategori: .Product)
    }
    
    @objc func refreshTrigger(){
        loadDataFromAPI{
            self.tblLatest.refreshControl?.endRefreshing()
        }
    }
    
    func navigateToDailys(kategori: Kategori){
        let storyboard = UIStoryboard(name: "Dailys", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! DailysVC
        vc.kategori = kategori
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
