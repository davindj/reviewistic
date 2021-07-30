//
//  BarcodeVC.swift
//  team8_business
//
//  Created by Davin Djayadi on 28/07/21.
//

import UIKit

class BarcodeVC: UIViewController {
    @IBOutlet var barcodeImageView: UIImageView!
    var transaction: TransactionViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let trans = transaction{
            navigationItem.title = "Barcode \(trans.noTransaction)"
            let url = "https://example.com?t=\(trans.idTrans)"
            barcodeImageView.image = UIImage.generateBarcode(content: url)
        }
    }
}
