//
//  DetailTransactionViewController.swift
//  team8_business
//
//  Created by Davin Djayadi on 22/07/21.
//

import UIKit

class DetailTransactionVC: UIViewController {
    // Component
    @IBOutlet var noTransLabel: UILabel!
    @IBOutlet var reviewResultLabel: UILabel!
    @IBOutlet var barcodeBtn: UIButton!
    
    // Parameter
    var transaction: TransactionViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Transaction Detail"
        navigationItem.largeTitleDisplayMode = .always

        if let trans = transaction {
            noTransLabel.text = trans.noTransactionDetail
            reviewResultLabel.text = trans.review
        }
    }
}
