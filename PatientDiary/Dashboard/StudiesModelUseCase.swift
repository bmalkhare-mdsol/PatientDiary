//
//  StudiesModelUseCase.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
protocol StudiesModelUseCase{
    func getStudiesModelList() -> StudiesModel?
    func updateStudiesModelInDB(studies: StudiesModel, person: Person)
    func getStudiesModelForPerson(person: Person) -> StudiesModel?
    func isUserAlreadyExist(emailID: String) -> Bool
    func saveModelInDB(studies: StudiesModel, person: Person)
    
}

class StudiesModelUseCaseImpl: StudiesModelUseCase {
    let dbHelper = DBHelper()
    
    func getStudiesModelList() -> StudiesModel? {
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
    
    func isUserAlreadyExist(emailID: String) -> Bool {
        return dbHelper.isUserAlreadyExist(emailID: emailID)
    }
    
    func updateStudiesModelInDB(studies: StudiesModel, person: Person) {
        do {
            let jsonData = try JSONEncoder().encode(studies)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            person.jsonString = jsonString
            dbHelper.update(person: person, jsonString: jsonString)
        } catch {}
    }
    
    func saveModelInDB(studies: StudiesModel, person: Person) {
        do {
            let jsonData = try JSONEncoder().encode(studies)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            person.jsonString = jsonString
            dbHelper.insert(email: person.emailID, name: person.name, jsonString: jsonString)
        } catch {}
    }
    
    func getStudiesModelForPerson(person: Person) -> StudiesModel? {
        let persons = dbHelper.read()
        var personCategoryModel: StudiesModel?
        if let currentPerson = persons.filter({$0.emailID == person.emailID}).first {
            do {
                personCategoryModel = try JSONDecoder().decode(StudiesModel.self, from: currentPerson.jsonString.data(using: .utf8)!)
            } catch {}
        }
        return personCategoryModel
    }
}
