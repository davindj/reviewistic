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
    let nama_produk: String
    let harga_produk: Int
    let qty_produk: Int
    
    init(nomorTransaksi: String, id: String, nama: String, harga: Int, qty: Int){
        self.NomorTransaksi = nomorTransaksi
        self.id_produk = id
        self.nama_produk = nama
        self.harga_produk = harga
        self.qty_produk = qty
    }
    
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
    
    init(id: String, fields: Produk, createdTime: String){
        self.id = id
        self.fields = fields
        self.createdTime = createdTime
    }
}

struct RecordsProduk: Codable {
    var records: [RecordProduk] = []
    
    init(records: [RecordProduk]) {
        self.records = records
    }
}

