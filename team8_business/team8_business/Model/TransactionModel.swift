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
   let RatingPrice: Int
   let RatingProduk: Int
   let id_toko: Int
   let RatingService: Int
    
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
    
    static func updateReviewStatus(airtableid:String, voucherid:String, status:Int, response: @escaping (Bool)->Void ) {
        
        let json = [ "fields": ["status":status, "voucher_id":voucherid]]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "https://api.airtable.com/v0/appP7dMHeW4puOorW/Review/"+airtableid+"?api_key=keys9Q3knWNrVr89B")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard data != nil else {
                print("fail1")
                return
            }
            do {
                DispatchQueue.main.async {
                    response(true)
                }
            }
            
        }

        task.resume()
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


