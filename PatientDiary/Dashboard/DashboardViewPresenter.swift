//
//  DashboardViewPresenter.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
enum StudyStringConstant: String{
    case studies = "Studies"
    case incompleted = "Incompleted"
    case completed = "Completed"
    case completePrevForms = "Please fill all the previous forms first"
    case visitTheForm = "Please fill all the information for form %@"
    case visitedAll = "All information is completed"
}

protocol DashboardViewPresenter {
    func didTapOnRow(indexPath: IndexPath, delegate: TextFieldDelegate?)
    func numberOfRows() -> Int
    func getNavigationHeaderTitle() -> String
    func getStudyModel(at index: Int)  -> Studies?
    func updateModel(indexPath: IndexPath?, forms:[Forms])
    func isCellInteractive(index: IndexPath) -> Bool
    var isAllCellsVisited: Bool {get}
    func viewWillAppear()
    func getNotificationInfo() -> (title: String, body: String)
}

protocol DashboardView {
    func showToast(text: String)
    func dismiss()
    func reloadData()
}

class DashboardViewPresenterImpl: DashboardViewPresenter {
    
    var router: DashboardViewRouter
    var model: StudiesModel
    var person: Person
    var usecase: StudiesModelUseCase
    var view: DashboardView
    var isAllCellsVisited: Bool = false

    init(router: DashboardViewRouter, model: StudiesModel, person: Person, usecase: StudiesModelUseCase, view: DashboardView) {
        self.router = router
        self.model = model
        self.person = person
        self.usecase = usecase
        self.view = view
    }
    
    func numberOfRows()  -> Int{
        return model.studies.count
    }
    
    func getNotificationInfo() -> (title: String, body: String) {
        let studiesList = model.studies
        let count = studiesList.filter({$0.isAllElementVisited}).count
        
        if count != studiesList.count {
            return (StudyStringConstant.incompleted.rawValue, (String(format: StudyStringConstant.visitTheForm.rawValue, model.studies[count].name)))
        }
        return (StudyStringConstant.completed.rawValue, StudyStringConstant.visitedAll.rawValue)
    }
    
    func viewWillAppear(){
        getDataFromDB()
    }

    func getStudyModel(at index: Int)  -> Studies? {
        return model.studies[index]
    }
    
    func getDataFromDB() {
        if let data = usecase.getStudiesModelForPerson(person: person) {
            self.model = data
            self.view.reloadData()
        }
    }
    
    func didTapOnRow(indexPath: IndexPath, delegate: TextFieldDelegate?) {
        if let forms = model.studies[safe: indexPath.row]?.forms {
            router.navigateToStudyForm(forms: forms, delegate: delegate, indexPath: indexPath)
        }
    }
    
    func getNavigationHeaderTitle() -> String {
        return self.person.name
    }
    
    func isCellEnable() -> String {
        return self.person.name
    }
    
    func isCellInteractive(index: IndexPath) -> Bool {
        let studiesList = model.studies
        let count = studiesList.filter({$0.isAllElementVisited}).count

        if count == index.row || index.row < count {
            return true
        }
        
        return false
    }
    
    func updateModel(indexPath: IndexPath?, forms:[Forms]) {
        guard let index = indexPath, let _ = model.studies[safe: index.row]?.forms else {
            return
        }
        model.studies[index.row].forms = forms
        if usecase.isUserAlreadyExist(emailID: self.person.emailID) {
            usecase.updateStudiesModelInDB(studies: model, person: person)
        } else {
            usecase.saveModelInDB(studies: model, person: person)
        }
    }


}
