//
//  ViewController.swift
//  team8_business
//
//  Created by Vincentius Phillips Zhuputra on 20/07/21.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Transaction.callData{ records in
            
            print(records)
        }
        // Do any additional setup after loading the view.
    }


}

