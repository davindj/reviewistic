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
    
    var kategori: Kategori = .Price
    
    var rating = 0
    let cellSpacingHeight: CGFloat = 10
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = .none
        return 1
        
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
        
        return filtereddata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaksiCellDailys", for: indexPath) as! tableviewcell
        
        
        let trans = filtereddata[indexPath.section]
        
        
        cell.transaksiID.text = trans.noTransaction
        cell.komentar.text = trans.review
        
        cell.tanggal.text = trans.tanggal
        if kategori == .Price {
            cell.rating.text = String(trans.ratingPrice)
        }
        else if kategori == .Product{
            cell.rating.text = String(trans.ratingProduct)
        }
        else if kategori == .Service{
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
        
        
        
        // Navigation Item
        if kategori == .Price{
            self.navigationItem.title = "Price Review"
        }
        else if kategori == .Product{
            self.navigationItem.title = "Product Review"
        }
        else if kategori == .Service{
            self.navigationItem.title = "Service Review"
        }
        
        guard let storeId = try? UserDefaults.standard.getUserId() else { return }
        Transaction.getAllReviewedTransactionsByStoreId(storeId: storeId){ arr in
            self.transaksi = arr.map{ TransactionViewModel(transaction: $0) }
            
            let totalbintang = self.transaksi.count <= 0 ? 1 : self.transaksi.count
            self.filtereddata = self.transaksi
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
            var valuebintang = 0
            //price
            if self.kategori == .Price{
               
                for bin in 1...5 {
                    let bintang = self.filtereddata.filter{$0.RPrice == bin}.count
                    let avg = Float(bintang)/Float(totalbintang)
                    arrProgressView[bin-1]?.setProgress(avg, animated: true)
                    arrLabel[bin-1]?.text = String(self.filtereddata.filter{$0.RPrice == bin}.count)
                    valuebintang += bintang*bin
                }
            }
            if self.kategori == .Product{
                for bin in 1...5 {
                    let bintang = self.filtereddata.filter{$0.RProduct == bin}.count
                    let avg = Float(bintang)/Float(totalbintang)
                    arrProgressView[bin-1]?.setProgress(avg, animated: true)
                    arrLabel[bin-1]?.text = String(self.filtereddata.filter{$0.RProduct == bin}.count)
                    valuebintang += bintang*bin
                }
            }
            if self.kategori == .Service{
                for bin in 1...5 {
                    let bintang = self.filtereddata.filter{$0.RService == bin}.count
                    let avg = Float(bintang)/Float(totalbintang)
                    arrProgressView[bin-1]?.setProgress(avg, animated: true)
                    arrLabel[bin-1]?.text = String(self.filtereddata.filter{$0.RService == bin}.count)
                    valuebintang += bintang*bin
                }
            }
            let avgrate = Float(valuebintang)/Float(totalbintang)
            self.Avg.text = "\(String(format: "%.01f", avgrate)) / 5"
            self.totalrate.text = "Total Rating: \(String(self.filtereddata.count))"
            var imageName: String = ""
            if (avgrate < 1)  {
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
        filtereddata = TransactionViewModel.filter(arrtrans: transaksi, kategori: self.kategori, rating: self.rating)
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

