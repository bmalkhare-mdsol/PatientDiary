//
//  Colors.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 27/06/23.
//

import Foundation
import UIKit
enum Colors {
    case lightGray
    case header
    var uiColor:UIColor {
        switch self {
        case .lightGray:
            return UIColor(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0, alpha: 0.5)
        case .header:
            return UIColor(red: 95.0/255.0, green: 125.0/255.0, blue: 220.0/255.0, alpha: 0.5)
        }
    }
}
