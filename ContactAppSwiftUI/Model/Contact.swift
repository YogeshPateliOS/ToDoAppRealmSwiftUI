//
//  Contact.swift
//  ContactAppSwiftUI
//
//  Created by Yogesh Patel on 04/03/22.
//

import RealmSwift

class Contact: Object{
    //var id = UUID().uuidString
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var firstname = ""
    @Persisted var lastname = ""
    
    convenience init(firstname: String, lastname: String){
        self.init()
        self.firstname = firstname
        self.lastname = lastname
    }
    
    static var tempData: [Contact] = [
        Contact(firstname: "Ashish", lastname: "Patel"),
        Contact(firstname: "Yogesh", lastname: "Patel")
    ]
}
