//
//  DailysVC.swift
//  team8_business
//
//  Created by rubby handojo on 27/07/21.
//

import UIKit

class DailysVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var Progressviewb1: UIProgressView!
    @IBOutlet weak var Progressviewb2: UIProgressView!
    @IBOutlet weak var Progressviewb3: UIProgressView!
    @IBOutlet weak var Progressviewb4: UIProgressView!
    @IBOutlet weak var Progressviewb5: UIProgressView!
    @IBOutlet weak var Labelb1: UILabel!
    @IBOutlet weak var Labelb2: UILabel!
    @IBOutlet weak var Labelb3: UILabel!
    @IBOutlet weak var Labelb4: UILabel!
    @IBOutlet weak var Labelb5: UILabel!
    @IBOutlet weak var ratingsegmen : UISegmentedControl!
    @IBOutlet weak var Avg: UILabel!
    @IBOutlet weak var avgRateImg: UIImageView!
    @IBOutlet weak var totalrate: UILabel!
    var transaksi:[TransactionViewModel] = []
    var filtereddata: [TransactionViewModel] = []
    var latestReview:[TransactionViewModel] = []
    var transDaily:[TransactionViewModel] = []
    var kategoriID = ""
    var rating = 0
    let cellSpacingHeight: CGFloat = 10
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = .none
        return latestReview.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return cellSpacingHeight
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return latestReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaksiCellDailys", for: indexPath) as! tableviewcell
        
        
        let trans = latestReview[indexPath.section]
        
        
        cell.transaksiID.text = trans.noTransaction
        cell.komentar.text = trans.review
        
        cell.tanggal.text = trans.tanggal
        if kategoriID == "RatingPrice" {
            cell.rating.text = String(trans.ratingPrice)
        }
        else if kategoriID == "RatingProduk"{
            cell.rating.text = String(trans.ratingProduct)
        }
        else if kategoriID == "RatingService"{
            cell.rating.text = String(trans.ratingService)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = filtereddata[indexPath.section]
        
        
        let storyboard = UIStoryboard(name: "Transaction", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "DetailTransaction") as? DetailTransactionVC{
            vc.transactionVM = transaction
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBOutlet weak var tableViewDailys:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        print(formatter1.string(from: today))
        
        
        // Navigation Item
        self.navigationItem.title = kategoriID
        
        Transaction.callData{r in
            let arr = r.filter{$0.fields.status == 2}
            let tanggal = r.filter{$0.date == formatter1.string(from: today)}
            for record in 1...arr.count{
                let viewmodel = TransactionViewModel(transaction: arr[record-1])
                self.transaksi.append(viewmodel)
            }
            
            let totalbintang = self.filtereddata.count <= 0 ? 1 : self.filtereddata.count
            let arrProgressView = [self.Progressviewb1,
                                   self.Progressviewb2,
                                   self.Progressviewb3,
                                   self.Progressviewb4,
                                   self.Progressviewb5]
            let arrLabel = [self.Labelb1,
                            self.Labelb2,
                            self.Labelb3,
                            self.Labelb4,
                            self.Labelb5]
            //price
            if self.kategoriID == "RatingPrice"{
               
                for bin in 1...5 {
                    let bintang = self.filtereddata.filter{$0.RPrice == bin}.count
                    let avg = Float(bintang)/Float(totalbintang)
                    arrProgressView[bin-1]?.setProgress(avg, animated: true)
                    arrLabel[bin-1]?.text = String(self.filtereddata.filter{$0.RPrice == bin}.count)
                    let avgrate = Float(bintang*bin)/Float(totalbintang)
                    self.Avg.text = "\(String(format: "%.01f", avgrate)) / 5"
                    
                    var imageName: String = ""
                    if (avgrate <= 1)  {
                        imageName = "0"
                    }
                    else{
                        let idxImage: Int = Int(avgrate * 2) - 2
                    
                        imageName = [
                            "bintang1",
                            "1 setengah",
                            "Bintang2",
                            "2 setengah",
                            "Bintang3",
                            "3 setengah",
                            "Bintang4",
                            "4 setengah",
                            "Bintang5"
                        ][idxImage]
                    }
                    let img = UIImage(named: imageName)
                    self.avgRateImg.image = img
                }
                
            }
           
                if self.kategoriID == "RatingProduk"{
                   
                    for bin in 1...5 {
                        let bintang = self.filtereddata.filter{$0.RProduct == bin}.count
                        let avg = Float(bintang)/Float(totalbintang)
                        arrProgressView[bin-1]?.setProgress(avg, animated: true)
                        arrLabel[bin-1]?.text = String(self.filtereddata.filter{$0.RProduct == bin}.count)
                        let avgrate = Float(bintang*bin)/Float(totalbintang)
                        self.Avg.text = "\(String(format: "%.01f", avgrate)) / 5"
                        
                        var imageName: String = ""
                        if (avgrate <= 1)  {
                            imageName = "0"
                        }
                        else{
                            let idxImage: Int = Int(avgrate * 2) - 2
                        
                            imageName = [
                                "bintang1",
                                "1 setengah",
                                "Bintang2",
                                "2 setengah",
                                "Bintang3",
                                "3 setengah",
                                "Bintang4",
                                "4 setengah",
                                "Bintang5"
                            ][idxImage]
                        }
                        let img = UIImage(named: imageName)
                        self.avgRateImg.image = img
                    }
                    
                }
                    if self.kategoriID == "RatingService"{
                       
                        for bin in 1...5 {
                            let bintang = self.filtereddata.filter{$0.RService == bin}.count
                            let avg = Float(bintang)/Float(totalbintang)
                            arrProgressView[bin-1]?.setProgress(avg, animated: true)
                            arrLabel[bin-1]?.text = String(self.filtereddata.filter{$0.RService == bin}.count)
                            let avgrate = Float(bintang*bin)/Float(totalbintang)
                            self.Avg.text = "\(String(format: "%.01f", avgrate)) / 5"
                            
                            var imageName: String = ""
                            if (avgrate <= 1)  {
                                imageName = "0"
                            }
                            else{
                                let idxImage: Int = Int(avgrate * 2) - 2
                            
                                imageName = [
                                    "bintang1",
                                    "1 setengah",
                                    "Bintang2",
                                    "2 setengah",
                                    "Bintang3",
                                    "3 setengah",
                                    "Bintang4",
                                    "4 setengah",
                                    "Bintang5"
                                ][idxImage]
                            }
                            let img = UIImage(named: imageName)
                            self.avgRateImg.image = img
                        }
                        
                    }

                //AVG
                
                
              
                        self.rating = 5
                        self.filter()
        }
        
                   tableViewDailys.delegate=self
                  tableViewDailys.dataSource=self
    }
    
    
         @IBAction func didChangeSegment(_ sender: Any) {
        switch ratingsegmen.selectedSegmentIndex {
        case 0:
            rating = 5
            filter()
        case 1:
            rating = 4
            filter()
        case 2:
            rating = 3
            filter()
        case 3:
            rating = 2
            filter()
        case 4:
            rating = 1
            filter()
        default:
            break
        }
    }
    func filter(){
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        
        if kategoriID == "RatingPrice" {
            filtereddata = transaksi.filter{$0.RPrice == rating}
            filtereddata = filtereddata.filter{$0.transObj.date == formatter1.string(from: today)}
        }
        else if kategoriID == "RatingProduk"{
            filtereddata = transaksi.filter{$0.RProduct == rating}
            filtereddata = filtereddata.filter{$0.transObj.date == formatter1.string(from: today)}
        }
        else if kategoriID == "RatingService"{
            filtereddata = transaksi.filter{$0.RService == rating}
            filtereddata = filtereddata.filter{$0.transObj.date == formatter1.string(from: today)}
        }
        
        tableViewDailys.reloadData()
        
    }
    
    
}


class tableviewcell: UITableViewCell {
    
    @IBOutlet weak var transaksiID: UILabel!
    @IBOutlet weak var komentar: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var tanggal: UILabel!
    @IBOutlet weak var Celltransaksi: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        Celltransaksi.layer.cornerRadius = 5
        
    }
}
