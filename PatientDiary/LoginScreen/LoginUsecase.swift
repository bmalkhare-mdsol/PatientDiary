//
//  LoginUsecase.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
protocol LoginUsecase{
    func getStudiesDetailsList() -> StudiesModel?
    
}

class LoginUsecaseImpl: LoginUsecase {
    let dbHelper = DBHelper()
    
    func getStudiesDetailsList() -> StudiesModel? {
        if let url =  Bundle.main.url(forResource: "Studies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(StudiesModel.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
}
