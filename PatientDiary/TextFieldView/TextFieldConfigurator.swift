//
//  TextFieldConfigurator.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
protocol  TextFieldConfigurator{
    func configure(forms: [Forms],delegate: TextFieldDelegate?,indexPath: IndexPath)
}

class TextFieldConfiguratorImpl:  TextFieldConfigurator {
    var viewController: TextFieldController
    
    init(viewController: TextFieldController) {
        self.viewController = viewController
    }
    
    func configure(forms: [Forms], delegate: TextFieldDelegate?, indexPath: IndexPath) {
        let router = TextFieldRouterImpl(viewController: viewController)
        let presenter = TextFieldPresenterImpl(router: router, forms: forms, view: viewController, delegate: delegate, indexPath: indexPath)
        viewController.presenter = presenter
    }
}
