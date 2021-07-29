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
    
    
   
    var transaksi:[Record] = []
    var filtereddata: [Record] = []
    let cellSpacingHeight: CGFloat = 10
    
    
    var rating = 0
    var kategoriID = ""
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 1
      
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
            return filtereddata.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if kategoriID == "KategoriAll"{
            let cell_all = tableView.dequeueReusableCell(withIdentifier: "transaksiCellAll", for: indexPath) as! transaksi_cell_all
            let transAll = filtereddata[indexPath.row]
            
            cell_all.transaksiIDAll.text = transAll.fields.NomorTransaksi
            cell_all.RatingPrice.text = String( transAll.fields.RatingPrice)
            cell_all.RatingProduk.text = String( transAll.fields.RatingProduk)
            cell_all.RatingService.text = String( transAll.fields.RatingService)
            cell_all.tanggalAll.text = String( transAll.date)
            cell_all.AvgRating.text = String(transAll.avgrate)
            cell_all.komentarAll.text = transAll.fields.Review
            return cell_all
        }
        else{
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "transaksicell", for: indexPath) as! transaksi_cell
            
            
            let trans = filtereddata[indexPath.row]
            cell.transaksiID.text = trans.fields.NomorTransaksi
            cell.komentar.text = trans.fields.Review
            
            cell.tanggal.text = trans.createdTime
            if kategoriID == "RatingPrice" {
                cell.rating.text = String(trans.fields.RatingPrice)
            }
            else if kategoriID == "RatingProduk"{
                cell.rating.text = String(trans.fields.RatingProduk)
            }
            else if kategoriID == "RatingService"{
                cell.rating.text = String(trans.fields.RatingService)
            }
           
            return cell
            
            
            
            
        }
        
    }
   
     
    
    @IBOutlet weak var table_view: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Navigation Item
        self.navigationItem.title = "All Review"
        
        Transaction.callData { r in
            self.transaksi = r.filter{$0.fields.status == 2}
            self.kategoriID = "KategoriAll"
            self.filter()
        }
        
        table_view.delegate=self
        table_view.dataSource=self
        
        // Do any additional setup after loading the view.
    }

    
    
    
   @IBAction func Segmentkriteria(_ sender: Any) {
    switch KriteriaSegmen.selectedSegmentIndex {
        case 0:
            kategoriID = "KategoriAll"
            filter()
        case 1:
            kategoriID = "RatingPrice"
            
            filter()
        case 2:
            kategoriID = "RatingProduk"
           
            filter()
        case 3:
            kategoriID = "RatingService"
           
            filter()
       default:
           break
        
    }
   }
    
    
    
  @IBAction func didChangeSegment(_ sender: Any) {
    switch ratingsegmen.selectedSegmentIndex {
        case 0:
            rating = 5
            filter()
        case 1:
            print("case1")
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
        
    
        if kategoriID == "KategoriAll" {
           
            filtereddata = transaksi.filter{Int($0.avgrate.rounded()) == rating}
        }
        else if kategoriID == "RatingPrice" {
            filtereddata = transaksi.filter{$0.fields.RatingPrice == rating}
        }
        else if kategoriID == "RatingProduk"{
            filtereddata = transaksi.filter{$0.fields.RatingProduk == rating}
        }
        else if kategoriID == "RatingService"{
            filtereddata = transaksi.filter{$0.fields.RatingService == rating}
        }
        
        table_view.reloadData()
        
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
    @IBOutlet weak var kotak1: UIView!
    @IBOutlet weak var komentarAll: UILabel!
    @IBOutlet weak var kotak2: UIView!
    @IBOutlet weak var kotak3: UIView!
    @IBOutlet weak var RatingPrice: UILabel!
    @IBOutlet weak var RatingProduk: UILabel!
    @IBOutlet weak var RatingService: UILabel!
    @IBOutlet weak var tanggalAll: UILabel!
    @IBOutlet weak var AvgRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        kotak1.layer.cornerRadius = 5
        kotak2.layer.cornerRadius = 5
        kotak3.layer.cornerRadius = 5
    }

    }


