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
    var transaction: Record!
    
    private var transactionVM: TransactionViewModel! {
        didSet{
            noTransLabel.text = transactionVM.noTransactionDetail
            reviewResultLabel.text = transactionVM.review
            
            // Barcode btn style
            barcodeBtn.setTitle(transactionVM.btnText, for: .normal)
            barcodeBtn.backgroundColor = transactionVM.btnColor
            barcodeBtn.tintColor = .white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Transaction Detail"
        navigationItem.largeTitleDisplayMode = .always
        
        transactionVM = TransactionViewModel(transaction: transaction)
    }
    @IBAction func barcodeBtnTapped(_ sender: Any) {
        if transactionVM.status == .BarcodeNotGenerated{
            self.present(UIStoryboard.instantiateModalPromo{
                self.transactionVM.status = .BarcodeGenerated
            }, animated: true)
        }else{
            self.present(UIStoryboard.instantiateModalBarcode(transaction: transactionVM),animated: true)
        }
    }
}
