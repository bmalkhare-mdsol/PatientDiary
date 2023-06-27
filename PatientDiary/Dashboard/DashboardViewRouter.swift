//
//  DashboardViewRouter.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
import UIKit
protocol DashboardViewRouter {
    func navigateToStudyForm(forms: [Forms], delegate: TextFieldDelegate?, indexPath: IndexPath)
}

class DashboardViewRouterImpl: DashboardViewRouter {
    
    var viewController: DashboardViewController
    
    init(viewController: DashboardViewController) {
        self.viewController = viewController
    }
    
    func navigateToStudyForm(forms: [Forms], delegate: TextFieldDelegate?, indexPath: IndexPath) {
        let vc =  CommonUtility.getViewController(storyboardName: StoryBordIds.main, bundleID: StoryBordIds.textFieldController) as? TextFieldController
        let configurator = TextFieldConfiguratorImpl(viewController: vc!)
        configurator.configure(forms: forms, delegate: delegate, indexPath: indexPath)
        vc?.configurator = configurator
        self.viewController.navigationController?.pushViewController(vc!, animated: true)
    }
    
  
    
}
