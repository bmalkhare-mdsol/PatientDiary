//
//  TextFieldPresenter.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
enum TextFieldConstant: String{
    case studies = "Studies"
    case ok = "Select"
    case cancel = "Cancel"
    case selectDate = "Select Date"
    case mild = "Mild"
    case severe = "Severe"
    case temp = "Temporary"
}


enum Vaccination: CaseIterable {
    case mild
    case temporary
    case severe

    
    func getTitle() -> String {
        switch self {
        case .mild:
            return TextFieldConstant.mild.rawValue
        case .temporary:
            return TextFieldConstant.temp.rawValue
        case .severe:
            return TextFieldConstant.severe.rawValue
        }
    }
}


protocol TextFieldPresenter {
    func nextPressed()
    func getPlaceHolder() -> String
    func getTextValue() -> String
    func getButtonText() -> String
    func getLableValue() -> String
    func updateVaccinationDay(text: String)
    func updateEffects(effect: Vaccination)
    func getFormType() -> FormType
    func getNavigationHeaderTitle() -> String 
}

protocol TextFieldView {
    func updateView()
    func dismiss()
}

protocol TextFieldDelegate {
    func updateForms(form: [Forms], indexPath: IndexPath?)
}

class TextFieldPresenterImpl: TextFieldPresenter {
    
    var router: TextFieldRouter
    var forms: [Forms]
    var totalForm = 0
    var currentForm = 0
    var view: TextFieldView
    var delegate: TextFieldDelegate?
    var indexPath: IndexPath?
    init(router: TextFieldRouter, forms: [Forms], view: TextFieldView, delegate: TextFieldDelegate?, indexPath: IndexPath) {
        self.router = router
        self.forms = forms
        totalForm = forms.count - 1
        self.view = view
        self.delegate = delegate
        self.indexPath = indexPath
    }
    
    func getFormType() -> FormType {
        return self.forms[currentForm].formType
    }

    
    func updateVaccinationDay(text: String) {
        self.forms[currentForm].value = text
        self.forms[currentForm].isVisited = true
        self.view.updateView()
    }
    
    func getFormAtCurrentIndex() -> Forms? {
        return forms[safe: currentForm]
    }
    
    func getPlaceHolder() -> String {
        if let form = getFormAtCurrentIndex(), form.value.isEmpty {
            return form.formType.getPlaceHolder()
        }
        return ""
    }
    
    func getTextValue() -> String {
        if let form = getFormAtCurrentIndex(), !form.value.isEmpty {
            return form.value
        }
        return ""
    }
    
    func getLableValue() -> String {
        if let form = getFormAtCurrentIndex() {
            return form.formType.getLabelHolder()
        }
        return ""
    }
    
    func getButtonText() -> String {
        if currentForm < totalForm {
            return "Next"
        }
        return "Submit"
    }
    
    func getNavigationHeaderTitle() -> String {
        return self.forms[currentForm].name
    }
    
    
    func nextPressed() {
        
        if currentForm >= totalForm  {
            self.delegate?.updateForms(form: forms, indexPath: indexPath)
            self.view.dismiss()
            return
        }
        self.delegate?.updateForms(form: forms, indexPath: indexPath)
        currentForm += 1
        self.view.updateView()

    }
    
    func updateEffects(effect: Vaccination) {
        forms[currentForm].value = effect.getTitle()
        forms[currentForm].isVisited = true
        self.view.updateView()
    }
    
    
}
