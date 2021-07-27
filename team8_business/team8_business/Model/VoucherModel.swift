//
//  VoucherModel.swift
//  team8_business
//
//  Created by Vincentius Phillips Zhuputra on 26/07/21.
//

import Foundation

class Voucher: Codable {
    let id_voucher: String
    let nama: String
    let exp_date: String
    let keterangan: String
    let id_toko: String
    
    init(Id_Voucher:String, Nama: String, Exp_Date:String, Keterangan:String, Id_Toko:String) {
        id_voucher = Id_Voucher
        nama = Nama
        exp_date = Exp_Date
        keterangan = Keterangan
        id_toko = Id_Toko
    }
    
    static func listVoucherToko(id_toko: String, response: @escaping ([RecordVoucher])->Void ) {
        let url = URL(string: "https://api.airtable.com/v0/appP7dMHeW4puOorW/Voucher?filterByFormula=id_toko="+id_toko+"&api_key=keys9Q3knWNrVr89B")
        //var recResponse.records
        
        //let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: url!) {data, _, _ in
            guard let jsonData = data else {
                print("fail1")
                return
            }
            do {
                let decoder = JSONDecoder()
                let recResponse = try decoder.decode(RecordsVoucher.self, from: jsonData)
                
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
    
    static func getVoucher(id_voucher: String, response: @escaping ([RecordVoucher])->Void ) {
        let url = URL(string: "https://api.airtable.com/v0/appP7dMHeW4puOorW/Voucher?filterByFormula=id_voucher="+id_voucher+"&api_key=keys9Q3knWNrVr89B")
        //var recResponse.records
        
        //let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: url!) {data, _, _ in
            guard let jsonData = data else {
                print("fail1")
                return
            }
            do {
                let decoder = JSONDecoder()
                let recResponse = try decoder.decode(RecordsVoucher.self, from: jsonData)
                
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
    
    static func insVoucher(nama: String, exp_date: String, keterangan:String, id_toko:String, response: @escaping (Bool)->Void ) {
        // prepare json data
        let uuid = UUID().uuidString
        let json = [ "fields": ["id_voucher":uuid, "nama":nama, "exp_date": exp_date, "keterangan": keterangan, "id_toko": id_toko]]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "https://api.airtable.com/v0/appP7dMHeW4puOorW/Voucher?api_key=keys9Q3knWNrVr89B")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
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


class RecordVoucher: Codable {
   let id: String
   let fields: Voucher
   let createdTime : String
}

struct RecordsVoucher: Codable {
   var records: [RecordVoucher]
    
    init() {
        records = []
    }
}
