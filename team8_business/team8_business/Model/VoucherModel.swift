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
        self.id_voucher = Id_Voucher
        self.nama = Nama
        self.exp_date = Exp_Date
        self.keterangan = Keterangan
        self.id_toko = Id_Toko
    }
    
    static func listVoucherToko(response: @escaping ([RecordVoucher])->Void ) {
        var url = URL(string:"")
        do {
            let toko_id = try UserDefaults.standard.getUserId()
            url = URL.getAllVouchersByStoreId(storeId: toko_id)!
        } catch {
            print(error)
        }
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
        let url = URL.getAllVouchersByVoucherId(voucherId: id_voucher)
        
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
    
    static func insVoucher(nama: String, exp_date: String, keterangan:String, id_toko:String, response: @escaping (RecordVoucher)->Void ) {
        // prepare json data
        let uuid = UUID().uuidString
        let json = [
            "fields": [
                "id_voucher": uuid,
                "nama": nama,
                "exp_date": exp_date,
                "keterangan": keterangan,
                "id_toko": id_toko
            ]
        ]
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL.insertVoucher()!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let dat = data else {
                print("fail1")
                return
            }
            do {
                let decoder = JSONDecoder()
                let recResponse = try decoder.decode(RecordVoucher.self, from: dat)
                
                DispatchQueue.main.async {
                    response(recResponse)
                }
            }
            catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError)")
            }
            
        }

        task.resume()
    }
    
    static func delVoucher(airtableid: String, response: @escaping (Bool)->Void ) {
        let url = URL.deleteVoucher(airtableId: airtableid)!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
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
    
    init(id: String, fields: Voucher, createdTime: String){
        self.id = id
        self.fields = fields
        self.createdTime = createdTime
    }
}

struct RecordsVoucher: Codable {
   var records: [RecordVoucher]
}
