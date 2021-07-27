//
//  TransactionViewController.swift
//  team8_business
//
//  Created by Davin Djayadi on 22/07/21.
//

import UIKit

struct TempTransaction {
    let id: String
}

class TransactionVC: UITableViewController {
    var transactions: [TransactionViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Transactions"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        Transaction.callData{ data in
            self.transactions = data.map{ TransactionViewModel(transaction: $0) }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaction", for: indexPath)
        let transaction = transactions[indexPath.row]
        cell.textLabel?.text = transaction.noTransaction
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = transactions[indexPath.row]
        if let vc = self.storyboard?.instantiateViewController(identifier: "DetailTransaction") as? DetailTransactionVC {
            vc.transaction = transaction
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
