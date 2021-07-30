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
    
    var idTrans: String { transObj.fields.NomorTransaksi }
    var noTransactionDetail: String { "Order Number \(self.noTransaction)" }
    var noTransaction: String { "#\(transObj.fields.NomorTransaksi)" }
    var review: String {
        if status == .BarcodeNotGenerated{
            return "Barcode belum digenerate, silahkan generate dahulu untuk menerima review"
        }else if status == .BarcodeGenerated{
            return "Belum ada review"
        }else{
            return transObj.fields.Review
        }
    }
    var ratingPrice: String { "\(transObj.fields.RatingPrice)" }
    var ratingProduct: String { "\(transObj.fields.RatingProduk)" }
    var ratingService: String { "\(transObj.fields.RatingService)" }
    
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
            .BarcodeNotGenerated: .systemIndigo,
            .BarcodeGenerated: .systemGreen,
            .Reviewed: .systemGreen
        ]
        let color = dictColor[self.status]!
        return color
    }
}
