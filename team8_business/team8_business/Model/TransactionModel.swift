//
//  TransactionModel.swift
//  team8_business
//
//  Created by Vincentius Phillips Zhuputra on 21/07/21.
//

import Foundation

class Transaction: Codable {
   let NomorTransaksi: String
   let Review: String
   let Rating: Int
   let id_toko: Int
    
    static func callData(response: @escaping ([Record])->Void ) {
        let url = URL(string: "https://api.airtable.com/v0/appP7dMHeW4puOorW/Review?api_key=keys9Q3knWNrVr89B")
        //var recResponse.records
        
        //let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: url!) {data, _, _ in
            guard let jsonData = data else {
                print("fail1")
                return
            }
            do {
                let decoder = JSONDecoder()
                let recResponse = try decoder.decode(Records.self, from: jsonData)
                
                DispatchQueue.main.async {
                    response(recResponse.records)
                }
                
                //panggil data disini
            } catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError)")
            }
        }
        dataTask.resume()
    }
}

class Record: Codable {
   let id: String
   let fields: Transaction
   let createdTime : String
}

struct Records: Codable {
   var records: [Record]
    
    init() {
        records = []
    }
}


