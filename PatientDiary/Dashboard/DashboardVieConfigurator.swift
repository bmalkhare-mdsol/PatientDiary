//
//  DashboardVieConfigurator.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
protocol  DashboardViewConfigurator{
    func configure(model: StudiesModel, person: Person)
}

class DashboardViewConfiguratorImpl:  DashboardViewConfigurator {
    var viewController: DashboardViewController
    
    init(viewController: DashboardViewController) {
        self.viewController = viewController
    }
    
    func configure(model: StudiesModel, person: Person) {
        let router = DashboardViewRouterImpl(viewController: viewController)
        let presenter = DashboardViewPresenterImpl(router: router, model: model, person: person, usecase: StudiesModelUseCaseImpl(), view: viewController)
        viewController.presenter = presenter
    }
}
