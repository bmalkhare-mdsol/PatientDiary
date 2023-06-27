//
//  LoginViewConfigurator.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
import Foundation
protocol  LoginViewConfigurator{
    func configure()
}

class LoginViewConfiguratorImpl:  LoginViewConfigurator {
    var viewController: ViewController
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func configure() {
        let router = LoginRouterImpl(viewController: viewController)
        let usecase = LoginUsecaseImpl()

        let presenter = LoginPresenterImpl(router: router, usecase: usecase)
        viewController.presenter = presenter
    }
}
