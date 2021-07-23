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

class TransactionViewController: UITableViewController {
    var transactions: [TempTransaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Transactions"
        
        transactions += [
            TempTransaction(id: "1"),
            TempTransaction(id: "2"),
            TempTransaction(id: "3"),
        ]
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transaction", for: indexPath)
        let transaction = transactions[indexPath.row]
        cell.textLabel?.text = transaction.id
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = transactions[indexPath.row]
        let vc = DetailTransactionViewController()
        vc.transaction = TempTransaction(id: "wkwkw")
        navigationController?.pushViewController(vc, animated: true)
    }

}
