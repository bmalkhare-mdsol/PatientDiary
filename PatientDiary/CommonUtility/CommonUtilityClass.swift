//
//  CommonUtilityClass.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
import UIKit

struct StoryBordIds{
    static var main = "Main"
    static var dashboardViewController = "DashboardViewController"
    static var textFieldController = "TextFieldController"
   
}


class CommonUtility{
   public static func getViewController(storyboardName: String, bundleID: String)  -> UIViewController? {
        return UIStoryboard.init(name: storyboardName, bundle: Bundle.main).instantiateViewController(withIdentifier: bundleID)
    }
}
