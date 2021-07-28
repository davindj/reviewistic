//
//  Date.swift
//  team8_business
//
//  Created by Davin Djayadi on 28/07/21.
//

import Foundation

extension Date{
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let resultString = dateFormatter.string(from: self)
        return resultString
    }
}
