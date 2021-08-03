//
//  ViewController.swift
//  team8_business
//
//  Created by Vincentius Phillips Zhuputra on 20/07/21.
//

import UIKit


class ReviewVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var ratingsegmen: UISegmentedControl!
    @IBOutlet weak var KriteriaSegmen: UISegmentedControl!
    //    let date = Calendar.current.date(byAdding: .day, value: -1, to: deadline.date)!
    //    let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,], from: date)
    
    
    
    var transaksi:[TransactionViewModel] = []
    var filtereddata: [TransactionViewModel] = []
    let cellSpacingHeight: CGFloat = 10
    
    
    var rating = 5
    var kategori: Kategori = .All
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = .none
        return 1
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return filtereddata.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if kategori == .All{
            let cell_all = tableView.dequeueReusableCell(withIdentifier: "transaksiCellAll", for: indexPath) as! transaksi_cell_all
            let transAll = filtereddata[indexPath.section]
            
            cell_all.transaksiIDAll.text = transAll.noTransaction
            cell_all.RatingPrice.text = transAll.ratingPrice
            cell_all.RatingProduk.text = transAll.ratingProduct
            cell_all.RatingService.text = transAll.ratingService
            cell_all.tanggalAll.text = transAll.tanggal
            
            cell_all.komentarAll.text = transAll.review
            return cell_all
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "transaksicell", for: indexPath) as! transaksi_cell
            
            
            let trans = filtereddata[indexPath.section]
            cell.transaksiID.text = trans.noTransaction
            cell.komentar.text = trans.review
            
            cell.tanggal.text = trans.tanggal
            if kategori == .Price {
                cell.rating.text = trans.ratingPrice
            }
            else if kategori == .Product{
                cell.rating.text = trans.ratingProduct
            }
            else if kategori == .Service{
                cell.rating.text = trans.ratingService
            }
            
            return cell
            
            
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = filtereddata[indexPath.section]
        
        let storyboard = UIStoryboard(name: "Transaction", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "DetailTransaction") as? DetailTransactionVC{
            vc.transactionVM = transaction
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    @IBOutlet weak var table_view: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Navigation Item
        self.navigationItem.title = "All Review"
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(refreshTrigger), for: .valueChanged)
        table_view.refreshControl = refreshControl
        
        table_view.delegate=self
        table_view.dataSource=self
        
        loadDataFromAPI {}
        // Do any additional setup after loading the view.
    }
    @IBAction func Segmentkriteria(_ sender: Any) {
        switch KriteriaSegmen.selectedSegmentIndex {
        case 0:
            kategori = .All
        case 1:
            kategori = .Price
        case 2:
            kategori = .Product
        case 3:
            kategori = .Service
        default:
            break
        }
        filter()
    }
    @IBAction func didChangeSegment(_ sender: Any) {
        
        switch ratingsegmen.selectedSegmentIndex {
        case 0:
            rating = 5
        case 1:
            rating = 4
        case 2:
            rating = 3
        case 3:
            rating = 2
        case 4:
            rating = 1
        default:
            break
        }
        filter()
    }
    
    func filter(){
        filtereddata = TransactionViewModel.filter(arrtrans: transaksi, kategori: self.kategori, rating: self.rating)
        
        table_view.reloadData()
        
    }
    func loadDataFromAPI(callback: @escaping()->Void){
        Transaction.callData { r in
            let arr = r.filter{$0.fields.status == 2}
            for record in 1...arr.count{
                let viewmodel = TransactionViewModel(transaction: arr[record-1])
                self.transaksi.append(viewmodel)
            }
            
            
            self.filter()
        }
        callback()
    }
    
    
    @objc func refreshTrigger(){
        loadDataFromAPI{
            self.table_view.refreshControl?.endRefreshing()
        }
    }
    
    
    // 1. ambil data dari variable
    // 2. filter berdasarkan segmen yang aktif
    // 3. tampilkan data sementara yang udah di filter
    
    
}
class transaksi_cell: UITableViewCell {
    @IBOutlet weak var transaksiID: UILabel!
    @IBOutlet weak var komentar: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var tanggal: UILabel!
    @IBOutlet weak var Celltransaksi: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        Celltransaksi.layer.cornerRadius = 10
    }
}
class transaksi_cell_all: UITableViewCell {
    @IBOutlet weak var transaksiIDAll: UILabel!
    @IBOutlet weak var komentarAll: UILabel!
    @IBOutlet weak var Stackview: UIStackView!
    @IBOutlet weak var RatingPrice: UILabel!
    @IBOutlet weak var RatingProduk: UILabel!
    @IBOutlet weak var RatingService: UILabel!
    @IBOutlet weak var tanggalAll: UILabel!
    @IBOutlet weak var AvgRating: UILabel!
    @IBOutlet weak var Cellview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Cellview.layer.cornerRadius = 10
        Stackview.layer.cornerRadius = 5
    }
    
}

