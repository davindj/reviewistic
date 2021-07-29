//
//  AddVoucherVC.swift
//  team8_business
//
//  Created by Davin Djayadi on 26/07/21.
//

import UIKit

class AddVoucherVC: UIViewController {
    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var dateLabel: UIDatePicker!
    @IBOutlet var descriptionLabel: UITextField!
    @IBOutlet var createButton: UIButton!
    
    var successCallback: ((RecordVoucher)->Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Create Voucher"
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        print("Oi masuk")
        // Validate Form
        let date = dateLabel.date.toString(format: "yyyy-MM-dd")
        let name = nameLabel.text!
        let desc = descriptionLabel.text!
        
        if name.isEmpty || desc.isEmpty{ // Ada Field kosong
            showAlert(title: "Missing Field", message: "Please fill all fields")
            return
        }
        
        // Success
        // Insert ke AirTable
        let idToko = try! UserDefaults.standard.getUserId()
        Voucher.insVoucher(nama: name, exp_date: date, keterangan: desc, id_toko: idToko){ recVoucher in
//            if !isSuccess{
//                self.showAlert(title: "Something went wrong", message: "Please try again later")
//                return
//            }
            
            self.dismiss(animated: true){
                self.successCallback(recVoucher)
            }
        }
    }
    
    func showAlert(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(ac, animated: true)
    }
}
