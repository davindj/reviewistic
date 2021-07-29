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
    var transaksi:[Record] = []
    var filtereddata: [Record] = []
    var kategoriID = ""
    var rating = 0
 

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
        
        // Navigation Item
        self.navigationItem.title = kategoriID
        
        Transaction.callData{r in
            self.transaksi = r.filter{$0.fields.status == 2}
//
            if self.kategoriID == "RatingPrice"{
            //bintang1
            let totalbintang = self.transaksi.count
            let bintang1 = self.transaksi.filter{$0.fields.RatingPrice == 1}.count
            let avgb1 = Float(bintang1)/Float(totalbintang)
            self.Progressviewb1.setProgress(avgb1, animated: true)
            self.Labelb1.text = String( self.transaksi.filter{$0.fields.RatingPrice == 1}.count)
            //bintang2
            let bintang2 = self.transaksi.filter{$0.fields.RatingPrice == 2}.count
            let avgb2 = Float(bintang2)/Float(totalbintang)
            self.Progressviewb2.setProgress(avgb2, animated: true)
            self.Labelb2.text = String( self.transaksi.filter{$0.fields.RatingPrice == 2}.count)
            //bintang3
            let bintang3 = self.transaksi.filter{$0.fields.RatingPrice == 3}.count
            let avgb3 = Float(bintang3)/Float(totalbintang)
            self.Progressviewb3.setProgress(avgb3, animated: true)
            self.Labelb3.text = String( self.transaksi.filter{$0.fields.RatingPrice == 3}.count)
            //bintang4
            let bintang4 = self.transaksi.filter{$0.fields.RatingPrice == 4}.count
            let avgb4 = Float(bintang4)/Float(totalbintang)
            self.Progressviewb4.setProgress(avgb4, animated: true)
            self.Labelb4.text = String( self.transaksi.filter{$0.fields.RatingPrice == 4}.count)
            //bintang5
            let bintang5 = self.transaksi.filter{$0.fields.RatingPrice == 5}.count
            let avgb5 = Float(bintang5)/Float(totalbintang)
            self.Progressviewb5.setProgress(avgb5, animated: true)
            self.Labelb5.text = String( self.transaksi.filter{$0.fields.RatingPrice == 5}.count)
            //AVG
            let avgrate = Float(bintang1+bintang2*2+bintang3*3+bintang4*4+bintang5*5)/Float(totalbintang)
            self.Avg.text = "\(String(format: "%.01f", avgrate)) / 5"
            //image rate
            let idxImage: Int = Int(avgrate * 2) - 2
            let imageName: String = [
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
            let img = UIImage(named: imageName)
            self.avgRateImg.image = img
            // total
            self.totalrate.text = "\(String(totalbintang)) Ratings"
            }
            else if self.kategoriID == "RatingProduk"{
            //bintang1
            let totalbintang = self.transaksi.count
            let bintang1 = self.transaksi.filter{$0.fields.RatingProduk == 1}.count
            let avgb1 = Float(bintang1)/Float(totalbintang)
            self.Progressviewb1.setProgress(avgb1, animated: true)
            self.Labelb1.text = String( self.transaksi.filter{$0.fields.RatingProduk == 1}.count)
            //bintang2
            let bintang2 = self.transaksi.filter{$0.fields.RatingProduk == 2}.count
            let avgb2 = Float(bintang2)/Float(totalbintang)
            self.Progressviewb2.setProgress(avgb2, animated: true)
            self.Labelb2.text = String( self.transaksi.filter{$0.fields.RatingProduk == 2}.count)
            //bintang3
            let bintang3 = self.transaksi.filter{$0.fields.RatingProduk == 3}.count
            let avgb3 = Float(bintang3)/Float(totalbintang)
            self.Progressviewb3.setProgress(avgb3, animated: true)
            self.Labelb3.text = String( self.transaksi.filter{$0.fields.RatingProduk == 3}.count)
            //bintang4
            let bintang4 = self.transaksi.filter{$0.fields.RatingProduk == 4}.count
            let avgb4 = Float(bintang4)/Float(totalbintang)
            self.Progressviewb4.setProgress(avgb4, animated: true)
            self.Labelb4.text = String( self.transaksi.filter{$0.fields.RatingProduk == 4}.count)
            //bintang5
            let bintang5 = self.transaksi.filter{$0.fields.RatingProduk == 5}.count
            let avgb5 = Float(bintang5)/Float(totalbintang)
            self.Progressviewb5.setProgress(avgb5, animated: true)
            self.Labelb5.text = String( self.transaksi.filter{$0.fields.RatingProduk == 5}.count)
            //AVG
            let avgrate = Float(bintang1+bintang2*2+bintang3*3+bintang4*4+bintang5*5)/Float(totalbintang)
            self.Avg.text = "\(String(format: "%.01f", avgrate)) / 5"
            //image rate
            let idxImage: Int = Int(avgrate * 2) - 2
            let imageName: String = [
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
            let img = UIImage(named: imageName)
            self.avgRateImg.image = img
            // total
            self.totalrate.text = "\(String(totalbintang)) Ratings"
           }
           else if self.kategoriID == "RatingService"{
            //bintang1
            let totalbintang = self.transaksi.count
            let bintang1 = self.transaksi.filter{$0.fields.RatingService == 1}.count
            let avgb1 = Float(bintang1)/Float(totalbintang)
            self.Progressviewb1.setProgress(avgb1, animated: true)
            self.Labelb1.text = String( self.transaksi.filter{$0.fields.RatingService == 1}.count)
            //bintang2
            let bintang2 = self.transaksi.filter{$0.fields.RatingService == 2}.count
            let avgb2 = Float(bintang2)/Float(totalbintang)
            self.Progressviewb2.setProgress(avgb2, animated: true)
            self.Labelb2.text = String( self.transaksi.filter{$0.fields.RatingService == 2}.count)
            //bintang3
            let bintang3 = self.transaksi.filter{$0.fields.RatingService == 3}.count
            let avgb3 = Float(bintang3)/Float(totalbintang)
            self.Progressviewb3.setProgress(avgb3, animated: true)
            self.Labelb3.text = String( self.transaksi.filter{$0.fields.RatingService == 3}.count)
            //bintang4
            let bintang4 = self.transaksi.filter{$0.fields.RatingService == 4}.count
            let avgb4 = Float(bintang4)/Float(totalbintang)
            self.Progressviewb4.setProgress(avgb4, animated: true)
            self.Labelb4.text = String( self.transaksi.filter{$0.fields.RatingService == 4}.count)
            //bintang5
            let bintang5 = self.transaksi.filter{$0.fields.RatingService == 5}.count
            let avgb5 = Float(bintang5)/Float(totalbintang)
            self.Progressviewb5.setProgress(avgb5, animated: true)
            self.Labelb5.text = String( self.transaksi.filter{$0.fields.RatingService == 5}.count)
            //AVG
            let avgrate = Float(bintang1+bintang2*2+bintang3*3+bintang4*4+bintang5*5)/Float(totalbintang)
            self.Avg.text = "\(String(format: "%.01f", avgrate)) / 5"
            //image rate
            let idxImage: Int = Int(avgrate * 2) - 2
            let imageName: String = [
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
            let img = UIImage(named: imageName)
            self.avgRateImg.image = img
            // total
            self.totalrate.text = "\(String(totalbintang)) Ratings"
        }
            
            
        
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
