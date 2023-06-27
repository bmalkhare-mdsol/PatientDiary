//
//  LoginPresenter.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
protocol LoginPresenter {
    func loginPressed(person: Person)
}

class LoginPresenterImpl: LoginPresenter {
    
    var router: LoginRouter
    let usecase: LoginUsecase

    
    init(router: LoginRouter, usecase: LoginUsecase) {
        self.router = router
        self.usecase = usecase
    }
    
    func loginPressed(person: Person) {
        if let list = usecase.getStudiesDetailsList() {
            router.navigateToDashboardView(person: person, model: list)
        }
    }
}
