//
//  DetailTransactionViewController.swift
//  team8_business
//
//  Created by Davin Djayadi on 22/07/21.
//

import UIKit

class DetailTransactionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Component
    @IBOutlet var noTransLabel: UILabel!
    @IBOutlet var reviewResultLabel: UILabel!
    @IBOutlet var barcodeBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    
    // Parameter
    var transactionVM: TransactionViewModel!
    
    // Variables
    var products: [ProductViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Transaction Detail"
        navigationItem.largeTitleDisplayMode = .always
                
        // Reload button
        updateBtnDisplay()
        
        // Setup Table
        tableView.delegate = self
        tableView.dataSource = self
        
        loadProducts()
    }
    
    // Load Data
    func loadProducts(){
        Produk.listProdukTransaksi(nomorTransaksi: transactionVM.idTrans){ pr in
            self.products = pr.map{ ProductViewModel(product: $0) }
            self.tableView.reloadData()
        }
    }
    
    // Override
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        let viewModel = products[indexPath.row]
        cell.viewModel = viewModel
        return cell
    }
    
    func updateBtnDisplay(){
        noTransLabel.text = transactionVM.noTransactionDetail
        reviewResultLabel.text = transactionVM.review
        
        // Barcode btn style
        barcodeBtn.setTitle(transactionVM.btnText, for: .normal)
        barcodeBtn.backgroundColor = transactionVM.btnColor
        barcodeBtn.tintColor = .white
    }
    
    @IBAction func barcodeBtnTapped(_ sender: Any) {
        if transactionVM.status == .BarcodeNotGenerated{
            self.present(UIStoryboard.instantiateModalPromo(transaction: transactionVM){
                self.transactionVM.status = .BarcodeGenerated
                self.updateBtnDisplay()
                self.present(UIStoryboard.instantiateModalBarcode(transaction: self.transactionVM),animated: true)
            }, animated: true)
        }else{
            self.present(UIStoryboard.instantiateModalBarcode(transaction: transactionVM),animated: true)
        }
    }
}

class ProductCell: UITableViewCell {
    @IBOutlet var prdLabel: UILabel!
    @IBOutlet var prcLabel: UILabel!
    @IBOutlet var qtyLabel: UILabel!
    
    var viewModel: ProductViewModel?{
        didSet{
            guard let model = viewModel else { return }
            prdLabel.text = model.name
            prcLabel.text = model.price
            qtyLabel.text = model.qty
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
