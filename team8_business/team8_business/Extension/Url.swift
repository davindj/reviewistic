//
//  Url.swift
//  team8_business
//
//  Created by Davin Djayadi on 14/08/22.
//

import Foundation

extension URL{
    private static var AIRTABLE_URL: String{
        ProcessInfo.processInfo.environment["AIRTABLE_URL"]!
    }
    private static var AIRTABLE_API_KEY: String{
        ProcessInfo.processInfo.environment["AIRTABLE_API_KEY"]!
    }
    static func getAllVouchers() -> URL?{
        return URL(string: "\(AIRTABLE_URL)/Voucher?api_key=\(AIRTABLE_API_KEY)")
    }
    static func getAllVouchersByStoreId(storeId: String) -> URL?{
        return URL(string: "\(AIRTABLE_URL)/Voucher?api_key=\(AIRTABLE_API_KEY)&filterByFormula='id_toko=\(storeId)'")
    }
    static func getAllVouchersByVoucherId(voucherId: String) -> URL?{
        return URL(string: "\(AIRTABLE_URL)/Voucher?api_key=\(AIRTABLE_API_KEY)&filterByFormula='id_voucher=\(voucherId)'")
    }
    static func insertVoucher() -> URL?{
        return URL(string: "\(AIRTABLE_URL)/Voucher?api_key=\(AIRTABLE_API_KEY)")
    }
    static func deleteVoucher(airtableId: String) -> URL?{
        return URL(string: "\(AIRTABLE_URL)/Voucher/\(airtableId)?&api_key=\(AIRTABLE_API_KEY)")
    }
}
