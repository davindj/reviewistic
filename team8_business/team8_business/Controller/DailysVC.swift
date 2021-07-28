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
    @IBOutlet weak var ratingsegmen : UISegmentedControl!
    var transaksi:[Record] = []
    var filtereddata: [Record] = []
    var rating = 0
    var kategoriID = ""

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtereddata.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaksiCellDailys", for: indexPath) as! tableviewcell
        
        
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
    
    @IBOutlet weak var tableViewDailys:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Transaction.callData{r in
            self.transaksi = r.filter{$0.fields.status == 2}
        }
//
        tableViewDailys.delegate=self
        tableViewDailys.dataSource=self

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
        
    
       if kategoriID == "RatingPrice" {
            filtereddata = transaksi.filter{$0.fields.RatingPrice == rating}
        }
        else if kategoriID == "RatingProduk"{
            filtereddata = transaksi.filter{$0.fields.RatingProduk == rating}
        }
        else if kategoriID == "RatingService"{
            filtereddata = transaksi.filter{$0.fields.RatingService == rating}
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
}
