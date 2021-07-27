//
//  ProdukModel.swift
//  team8_business
//
//  Created by Vincentius Phillips Zhuputra on 26/07/21.
//

import Foundation

class Produk: Codable {
    let NomorTransaksi: String
    let id_produk: String
    
    static func listProdukTransaksi(nomorTransaksi:String , response: @escaping ([RecordProduk])->Void ) {
        let url = URL(string: "https://api.airtable.com/v0/appP7dMHeW4puOorW/Transaksi?filterByFormula=NomorTransaksi="+nomorTransaksi+"&api_key=keys9Q3knWNrVr89B")
        //var recResponse.records
        
        //let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: url!) {data, _, _ in
            guard let jsonData = data else {
                print("fail1")
                return
            }
            do {
                let decoder = JSONDecoder()
                let recResponse = try decoder.decode(RecordsProduk.self, from: jsonData)
                
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

class RecordProduk: Codable {
   let id: String
   let fields: Produk
   let createdTime : String
}

struct RecordsProduk: Codable {
   var records: [RecordProduk]
    
    init() {
        records = []
    }
}
