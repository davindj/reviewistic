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
        XCTAssertEqual(UITableViewCell.AccessoryType.checkmark, voucherVM.accesoryType)
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
        XCTAssertEqual(UITableViewCell.AccessoryType.none, voucherVM.accesoryType)
    }
    
    func testProductViewModel() throws {
        let produk = Produk(nomorTransaksi: "1", id: "12", nama: "Pensil", harga: 12, qty: 10)
        let recordProduk: RecordProduk = RecordProduk(id: "123", fields: produk, createdTime: "2020-12-21")
        let viewModel = ProductViewModel(product: recordProduk)
        
        XCTAssertEqual(produk.nama_produk, viewModel.name)
        XCTAssertEqual("Rp \(produk.harga_produk)", viewModel.price)
        XCTAssertEqual("\(produk.qty_produk) pcs", viewModel.qty)
    }
    
    func testTransactionViewModel() throws {
        let transaction = generateTransaction(status: 1)
        let record = generateRecordTransaction(transaction: transaction)
        let viewModel = generateTransactionVM(record: record)
        
        XCTAssertEqual(viewModel.idTrans, transaction.NomorTransaksi)
        let noTransaction = "#\(transaction.NomorTransaksi)"
        XCTAssertEqual(viewModel.noTransaction, noTransaction)
        XCTAssertEqual(viewModel.noTransactionDetail, "Order Number " + noTransaction)
        XCTAssertEqual(viewModel.tanggal, "\(record.date)")
        XCTAssertEqual(viewModel.ratingPrice, "\(transaction.RatingPrice)")
        XCTAssertEqual(viewModel.ratingService, "\(transaction.RatingService)")
        XCTAssertEqual(viewModel.ratingProduct, "\(transaction.RatingProduk)")
    }
    
    func testTransactionViewModelStatus0(){
        let transaction = generateTransaction(status: 0)
        let viewModel = generateTransactionVM(transaction: transaction)
        
        XCTAssertEqual(viewModel.status, .BarcodeNotGenerated)
        XCTAssertEqual(viewModel.review, "Barcode belum digenerate, silahkan generate dahulu untuk menerima review")
        XCTAssertEqual(viewModel.btnText, "Generate Barcode")
        XCTAssertEqual(viewModel.btnColor, UIColor(named: "Orange1"))
    }
    func testTransactionViewModelStatus1(){
        let transaction = generateTransaction(status: 1)
        let viewModel = generateTransactionVM(transaction: transaction)
        
        XCTAssertEqual(viewModel.status, .BarcodeGenerated)
        XCTAssertEqual(viewModel.review, "Belum ada review")
        XCTAssertEqual(viewModel.btnText, "Show Barcode")
        XCTAssertEqual(viewModel.btnColor, UIColor(named: "Orange2"))
    }
    func testTransactionViewModelStatus2(){
        let transaction = generateTransaction(status: 2)
        let viewModel = generateTransactionVM(transaction: transaction)
        
        XCTAssertEqual(viewModel.status, .Reviewed)
        XCTAssertEqual(viewModel.review, transaction.Review)
        XCTAssertEqual(viewModel.btnText, "Show Barcode")
        XCTAssertEqual(viewModel.btnColor, UIColor(named: "Orange2"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Helper Function
    func generateTransaction(status: Int) -> Transaction{
        let transaction: Transaction = Transaction(nomorTransaksi: "1",
                                                   review: "Hehe",
                                                   ratingPrice: 3,
                                                   ratingProduk: 4,
                                                   ratingService: 5,
                                                   status: status,
                                                   idToko: 1)
        return transaction
    }
    func generateRecordTransaction(transaction: Transaction) -> Record {
        let record: Record = Record(id: "1", fields: transaction, createdTime: "2021-12-21")
        return record
    }
    func generateTransactionVM(status: Int) -> TransactionViewModel {
        let transaction = generateTransaction(status: status)
        return generateTransactionVM(transaction: transaction)
    }
    func generateTransactionVM(transaction: Transaction) -> TransactionViewModel {
        let record: Record = generateRecordTransaction(transaction: transaction)
        return generateTransactionVM(record: record)
    }
    func generateTransactionVM(record: Record) -> TransactionViewModel {
        let viewModel = TransactionViewModel(transaction: record)
        return viewModel
    }
}
