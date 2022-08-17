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
    let RatingService: Int
    let status: Int
    let id_toko: Int
    
    init(
        nomorTransaksi: String,
        review: String,
        ratingPrice: Int,
        ratingProduk: Int,
        ratingService: Int,
        status: Int,
        idToko: Int
    ){
        self.NomorTransaksi = nomorTransaksi
        self.Review = review
        self.RatingPrice = ratingPrice
        self.RatingProduk = ratingProduk
        self.RatingService = ratingService
        self.status = status
        self.id_toko = idToko
    }
    
    
    static func callData(response: @escaping ([Record])->Void ) {
        guard let toko_id = try? UserDefaults.standard.getUserId() else { return }
        print(toko_id)
        let url = URL.getAllTransactionsByStoreId(storeId: toko_id)
        
        let dataTask = URLSession.shared.dataTask(with: url!) {data, _, _ in
            guard let jsonData = data else {
                print("fail1")
                return
            }
            do {
                let decoder = JSONDecoder()
                let recResponse = try decoder.decode(Records.self, from: jsonData)
                let records = recResponse.records.sorted{ Int($0.fields.NomorTransaksi)! < Int($1.fields.NomorTransaksi)! }
                
                DispatchQueue.main.async {
                    response(records)
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
        let url = URL.patchTransaction(transactionId: airtableid)!
        
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
    
    static func getAllTrans(voucherID:String, response: @escaping ([Record])->Void ) {
        let url = URL.getAllTransactionsByVoucherId(voucherId: voucherID)
        let dataTask = URLSession.shared.dataTask(with: url!) {data, _, _ in
            guard let jsonData = data else {
                print("fail1")
                return
            }
            do {
                let decoder = JSONDecoder()
                let recResponse = try decoder.decode(Records.self, from: jsonData)
                let records = recResponse.records.sorted{ Int($0.fields.NomorTransaksi)! < Int($1.fields.NomorTransaksi)! }
                
                DispatchQueue.main.async {
                    response(records)
                }
                
                //panggil data disini
            } catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError)")
            }
        }
        dataTask.resume()
    }
    
    static func getAllReviewedTransactionsByStoreId(storeId: String, response: @escaping ([Record])->Void ) {
        let url = URL.getAllReviewedTransactionsByStoreId(storeId: storeId)
        let dataTask = URLSession.shared.dataTask(with: url!) {data, _, _ in
            guard let jsonData = data else {
                print("fail1")
                return
            }
            do {
                let decoder = JSONDecoder()
                let recResponse = try decoder.decode(Records.self, from: jsonData)
                let records = recResponse.records.sorted{ Int($0.fields.NomorTransaksi)! < Int($1.fields.NomorTransaksi)! }
                
                DispatchQueue.main.async {
                    response(records)
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
    
    init(id: String, fields: Transaction, createdTime: String){
        self.id = id
        self.fields = fields
        self.createdTime = createdTime
    }
    
    var date: String{
        let index = createdTime.index(createdTime.startIndex, offsetBy: 10)
        let mySubstring = createdTime.prefix(upTo: index)
        
        return String(mySubstring)
    }
    
    var date2: Date {
        let isoDate = createdTime
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from:isoDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let finalDate = calendar.date(from:components)!
        return finalDate
    }
    
    var avgrate: Double{
        let array = [fields.RatingService,fields.RatingProduk,fields.RatingPrice]
        let average = array.reduce(0.0) {
            return $0 + Double($1)/Double(array.count)
        }
        return average
    }
}

struct Records: Codable {
    var records: [Record]
}

