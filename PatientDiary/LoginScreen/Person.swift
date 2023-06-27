//
//  Person.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
class Person {
    var name: String = ""
    var emailID: String = ""
    var imageURL: URL?
    var jsonString: String = ""
    
    init(name: String, emailID: String, url: URL?, jsonString: String)
    {
        self.name = name
        self.emailID = emailID
        self.imageURL = url
        self.jsonString = jsonString
    }
    
}
