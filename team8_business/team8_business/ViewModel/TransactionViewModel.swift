//
//  Transaction.swift
//  team8_business
//
//  Created by Davin Djayadi on 23/07/21.
//

import Foundation

struct TransactionViewModel {
    private let transaction: Record
    
    init(transaction: Record){
        self.transaction = transaction
    }
    
    var noTransactionDetail: String { "Order Number \(self.noTransaction)" }
    var noTransaction: String { "#\(transaction.fields.NomorTransaksi)" }
    var review: String { transaction.fields.Review }
}
