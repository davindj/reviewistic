//
//  Transaction.swift
//  team8_business
//
//  Created by Davin Djayadi on 23/07/21.
//

import Foundation
import UIKit

enum TransactionStatus{
    case BarcodeNotGenerated
    case BarcodeGenerated
    case Reviewed
    case Unknown
}
enum Kategori {
    case Price
    case Product
    case Service
    case All
}

class TransactionViewModel {
    let transObj: Record
    var status: TransactionStatus
 
    init(transaction: Record){
        self.transObj = transaction
        
        let dicStatus: Dictionary<Int, TransactionStatus> = [
            0: .BarcodeNotGenerated,
            1: .BarcodeGenerated,
            2: .Reviewed
        ]
        status = dicStatus[transObj.fields.status]!
    }
    // Computed Property
    var idTrans: String { transObj.fields.NomorTransaksi }
    var noTransaction: String { "#\(transObj.fields.NomorTransaksi)" }
    var noTransactionDetail: String { "Order Number \(self.noTransaction)" }
    var review: String {
        if status == .BarcodeNotGenerated{
            return "Barcode belum digenerate, silahkan generate dahulu untuk menerima review"
        }else if status == .BarcodeGenerated{
            return "Belum ada review"
        }else{
            return transObj.fields.Review
        }
    }
    var tanggal: String {"\(transObj.date)"}
    var waktu: Date {transObj.date2}
    var avgrate: Double {transObj.avgrate}
    var ratingPrice: String { "\(transObj.fields.RatingPrice)" }
    var ratingProduct: String { "\(transObj.fields.RatingProduk)" }
    var ratingService: String { "\(transObj.fields.RatingService)" }
    var RProduct : Int{transObj.fields.RatingProduk}
    var RPrice : Int{transObj.fields.RatingPrice}
    var RService : Int{transObj.fields.RatingService}
    // utk button
    var btnText: String {
        let dictText: Dictionary<TransactionStatus, String> = [
            .BarcodeNotGenerated: "Generate Barcode",
            .BarcodeGenerated: "Show Barcode",
            .Reviewed: "Show Barcode"
        ]
        let text = dictText[self.status]!
        return text
    }
    var btnColor: UIColor {
        let dictColor: Dictionary<TransactionStatus, UIColor> = [
            .BarcodeNotGenerated: UIColor(named: "Orange1")!,
            .BarcodeGenerated: UIColor(named: "Orange2")!,
            .Reviewed: UIColor(named: "Orange2")!
        ]
        let color = dictColor[self.status]!
        return color
    }
    // Function
    static func filterToday(arrtrans: [TransactionViewModel]) -> [TransactionViewModel]
    {
        var filtered: [TransactionViewModel] = []
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        filtered = arrtrans.filter{$0.transObj.date == formatter1.string(from: today)}
        
        return filtered
        
    }
    static func filter(arrtrans: [TransactionViewModel], kategori: Kategori, rating: Int) -> [TransactionViewModel] {
        var filtered: [TransactionViewModel] = []
        if kategori == .Price {
            filtered = arrtrans.filter{$0.RPrice == rating}
             
        }
        else if kategori == .Product{
            filtered = arrtrans.filter{$0.RProduct == rating}
           
        }
        else if kategori == .Service{
            filtered = arrtrans.filter{$0.RService == rating}
            
        }
        else if kategori == .All{
            filtered = arrtrans.filter{
                $0.RPrice == rating ||
                $0.RProduct == rating ||
                $0.RService == rating
            }
            
        }
        return filtered
    }
}
