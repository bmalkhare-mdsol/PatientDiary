//
//  LoginRouter.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//


import Foundation
import UIKit
protocol LoginRouter {
    func navigateToDashboardView(person: Person, model: StudiesModel)
}

class LoginRouterImpl: LoginRouter {
    var viewController: ViewController
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func navigateToDashboardView(person: Person, model: StudiesModel) {
        let vc =  CommonUtility.getViewController(storyboardName: StoryBordIds.main, bundleID: StoryBordIds.dashboardViewController) as? DashboardViewController
        let configurator = DashboardViewConfiguratorImpl(viewController: vc!)
        configurator.configure(model: model, person: person)
        vc?.configurator = configurator
        self.viewController.navigationController?.pushViewController(vc!, animated: true)
    }
}
