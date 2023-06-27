//
//  Studies.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation

struct StudiesModel: Codable {
    var studies: [Studies] = []
}

struct Studies: Codable{
    var name: String = ""
    var iconName: String = ""
    var id: String = ""
    var userID: String = ""
    var forms: [Forms] = []
    var isAllElementVisited: Bool {
        return forms.filter({ $0.isVisited }).count == forms.count
    }
}


struct Forms: Codable{
    var id: String
    var type: String
    var name: String
    var value: String
    var isVisited: Bool = false
    var category_slug: String
    var formType: FormType {
        return FormType.getFormType(text: category_slug)
    }
}

enum FormType {
    case date
    case postVaccineEffect
    
    static func getFormType(text: String) -> FormType {
        switch text{
        case "PostVaccinationEffects":
            return .postVaccineEffect
        default:
            return .date
        }
    }
    func getPlaceHolder() -> String {
        switch self {
        case .date:
            return "Select Date"
        case .postVaccineEffect:
            return "Select Post Vaccination Effects"
        }
    }
    
    func getLabelHolder() -> String {
        switch self {
        case .date:
            return "Vaccination Date"
        case .postVaccineEffect:
            return "Post Vaccination Effects"
        }
    }
}

