//
//  Image.swift
//  team8_business
//
//  Created by Davin Djayadi on 28/07/21.
//

import Foundation
import UIKit
import CoreImage

extension UIImage{
    static func generateBarcode(content: String) -> UIImage{
        let data = content.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        let output = filter.outputImage!.transformed(by: transform)
        let result = UIImage(ciImage: output)
        return result
    }
}
