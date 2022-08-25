//
//  DashboardTC.swift
//  team8_business
//
//  Created by Vincentius Phillips Zhuputra on 27/07/21.
//

import Foundation
import UIKit

class DashboardTC: UITableViewCell{
    
    @IBOutlet weak var lblNomorTransaksi: UILabel!
    @IBOutlet weak var lblAvgRating: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblPriceR: UILabel!
    @IBOutlet weak var lblServiceR: UILabel!
    @IBOutlet weak var lblProductR: UILabel!
    @IBOutlet weak var box: UIView!
    @IBOutlet weak var lblCreatedTime: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
    }
}
