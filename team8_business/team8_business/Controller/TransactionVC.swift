//
//  TransactionViewController.swift
//  team8_business
//
//  Created by Davin Djayadi on 22/07/21.
//

import UIKit

class TransactionVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var transactions: [TransactionViewModel] = []
    var filteredTransactions: [TransactionViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Transactions"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:  #selector(refreshTrigger), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        searchBar.delegate = self
        
        loadDataFromAPI {}
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterText()
    }
    
    func filterText(){
        let searchString = searchBar.text ?? ""
        if !searchString.isEmpty{
            filteredTransactions = transactions.filter{ $0.noTransaction.contains(searchString) }
        }else{
            filteredTransactions = transactions
        }
        self.tableView.reloadData()
    }
    
    func loadDataFromAPI(callback: @escaping()->Void){
        Transaction.callData{ data in
            do{
                let toko_id = try UserDefaults.standard.getUserId()
                print(toko_id)
                self.transactions = data.filter{ "\($0.fields.id_toko)" == toko_id }
                                        .map{ TransactionViewModel(transaction: $0) }
                self.filterText()
            }catch{ // Ketika toko tidak ditemukan
                print("Error unhandled")
            }
            callback()
        }
    }
    
    
    @objc func refreshTrigger(){
        loadDataFromAPI{
            self.tableView.refreshControl?.endRefreshing()
        }
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTransactions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaction", for: indexPath)
        let transaction = filteredTransactions[indexPath.row]
        cell.textLabel?.text = transaction.noTransaction
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = filteredTransactions[indexPath.row]
        if let vc = self.storyboard?.instantiateViewController(identifier: "DetailTransaction") as? DetailTransactionVC {
            vc.transactionVM = transaction
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
