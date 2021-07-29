//
//  File.swift
//  team8_business
//
//  Created by Davin Djayadi on 29/07/21.
//

import Foundation

struct ProductViewModel {
    var name: String
    var price: String
    var qty: String
    
    init(product: RecordProduk){
        self.name = product.fields.nama_produk
        self.price = "Rp \(product.fields.harga_produk)"
        self.qty = "\(product.fields.qty_produk) pcs"
    }
}
