//
//  ContentView.swift
//  ContactAppSwiftUI
//
//  Created by Yogesh Patel on 04/03/22.
//

import SwiftUI

struct ContentView: View {
    
   @State private var contactArray: [Contact] = []
    
    var body: some View {
        NavigationView{
            List {
                ForEach(0..<contactArray.count, id: \.self){ index in
                    ContactCell(contact: contactArray[index])
                        .swipeActions {
                            Button{
                                DatabaseHelper.shared.deleteContact(contact: contactArray[index])
                                contactArray.remove(at: index) // Delete
                            }label: {
                                Text("Delete")
                            }
                            .tint(.red)
                        }
                        .swipeActions {
                            Button{
                                openAlert(isAdd: false, index: index)
                            }label: {
                                Text("Update")
                            }
                            .tint(.indigo)
                        }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        openAlert(isAdd: true)
                    }label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                contactArray = DatabaseHelper.shared.getAllContacts()
            }
        }
    }
}

// MARK: - Helper Methods
extension ContentView{
    
    func openAlert(isAdd: Bool, index: Int = 0){
        let alertController = UIAlertController(
            title: isAdd ? "Add Contact" : "Update Contact",
            message: isAdd ? "Please enter your contact details" : "Please update your contact details",
            preferredStyle: .alert)
        
        alertController.addTextField { firstnameField in
            firstnameField.placeholder = isAdd ? "Enter your firstname" :
            contactArray[index].firstname
        }
        
        alertController.addTextField { lastnameField in
            lastnameField.placeholder = isAdd ? "Enter your lastname" :
            contactArray[index].lastname
        }
        
        let save = UIAlertAction(title: isAdd ? "Save" : "Update", style: .default) { _ in
            if let firstname = alertController.textFields?.first?.text,
               let lastname = alertController.textFields?[1].text{
                let contact = Contact(firstname: firstname, lastname: lastname)
               
                if isAdd{
                    contactArray.append(contact) // Add
                    DatabaseHelper.shared.addContact(contact: contact)// Realm Add Hoga
                }else{
                    DatabaseHelper.shared.updateContact(oldContact: contactArray[index], newContact: contact)
                    contactArray[index] = contact // Update
                }
            }
        }
        
        alertController.addAction(save)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
