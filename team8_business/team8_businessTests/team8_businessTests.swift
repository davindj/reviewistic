//
//  team8_businessTests.swift
//  team8_businessTests
//
//  Created by Vincentius Phillips Zhuputra on 20/07/21.
//

import XCTest
import UIKit

@testable import team8_business

class team8_businessTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVoucherViewModelActive() throws {
        let voucher = Voucher(Id_Voucher: "123",
                              Nama: "Promo 1",
                              Exp_Date: "2000-12-21",
                              Keterangan: "Buy 1 get 1 free",
                              Id_Toko: "1")
        let record = RecordVoucher(id: "EHE", fields: voucher, createdTime: "2012-12-21")
        var voucherVM = VoucherViewModel(recordVoucher: record)
        voucherVM.isSelected = true
        
        XCTAssertEqual(voucher.nama, voucherVM.name)
        XCTAssertEqual(.none.rawValue, voucherVM.accesoryType.rawValue)
    }
    
    func testVoucherViewModelInactive() throws {
        let voucher = Voucher(Id_Voucher: "123",
                              Nama: "Promo 1",
                              Exp_Date: "2000-12-21",
                              Keterangan: "Buy 1 get 1 free",
                              Id_Toko: "1")
        let record = RecordVoucher(id: "EHE", fields: voucher, createdTime: "2012-12-21")
        let voucherVM = VoucherViewModel(recordVoucher: record)
        
        XCTAssertEqual(voucher.nama, voucherVM.name)
        XCTAssertEqual(.none.rawValue, voucherVM.accesoryType.rawValue)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
