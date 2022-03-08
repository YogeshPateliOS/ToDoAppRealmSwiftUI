//
//  DatabaseHelper.swift
//  ContactAppSwiftUI
//
//  Created by Yogesh Patel on 04/03/22.
//

import RealmSwift

/// Singleton class - Design Pattern

class DatabaseHelper{
    
    static let shared = DatabaseHelper()
    
    private var realm = try! Realm()
    
    init(){
        print(databaseURL())
    }
    
    func databaseURL() -> URL?{
        return realm.configuration.fileURL
    }
    
    func addContact(contact: Contact){
        try! realm.write({
            realm.add(contact)
        })
    }
    
    func updateContact(oldContact: Contact, newContact: Contact){
        try! realm.write({
            oldContact.firstname = newContact.firstname
            oldContact.lastname = newContact.lastname
        })
    }
    
    func deleteContact(contact: Contact){
        try! realm.write({
            //realm.delete(contact)
            realm.delete(contact)            
        })
    }
    
    func getAllContacts() -> [Contact]{
        return Array(realm.objects(Contact.self))
    }
}

