//
//  TextFieldRouter.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
import UIKit
protocol TextFieldRouter {
    func navigateToNextScreen()
}

class TextFieldRouterImpl: TextFieldRouter {
    
    var viewController: TextFieldController
    
    init(viewController: TextFieldController) {
        self.viewController = viewController
    }
    
    func navigateToNextScreen() {
        
    }

   
    
}
