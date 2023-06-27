//
//  LoginUsecase.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
protocol LoginUsecase{
    func getStudiesDetailsList() -> StudiesModel?
//    func saveCategoryModelInDB(category: CategoryDetailModel, person: Person)
//    func getCategoryModel(person: Person, category: Category) -> Category?
//    func getCategoryModelForPerson(person: Person) -> CategoryDetailModel?
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
    
//    func saveCategoryModelInDB(category: CategoryDetailModel, person: Person) {
//        do {
//            let jsonData = try JSONEncoder().encode(category)
//            let jsonString = String(data: jsonData, encoding: .utf8)!
//            print(jsonString)
//            person.categoryListJson = jsonString
//            dbHelper.update(person: person, categoryJSON: jsonString)
//        } catch {}
//    }
//
//    func getCategoryModel(person: Person, category: Category) -> Category? {
//        let persons = dbHelper.read()
//        var personCategoryModel: CategoryDetailModel?
//        if let currentPerson = persons.filter({$0.name == person.name}).first {
//            do {
//                personCategoryModel = try JSONDecoder().decode(CategoryDetailModel.self, from: currentPerson.categoryListJson.data(using: .utf8)!)
//            } catch {}
//        }
//        if let model = personCategoryModel {
//            return model.categories.filter({$0.name == category.name}).first
//        }
//        return nil
//    }
//
//    func getCategoryModelForPerson(person: Person) -> CategoryDetailModel? {
//        let persons = dbHelper.read()
//        var personCategoryModel: CategoryDetailModel?
//        if let currentPerson = persons.filter({$0.name == person.name}).first {
//            do {
//                personCategoryModel = try JSONDecoder().decode(CategoryDetailModel.self, from: currentPerson.categoryListJson.data(using: .utf8)!)
//            } catch {}
//        }
//        return personCategoryModel
//    }
}
