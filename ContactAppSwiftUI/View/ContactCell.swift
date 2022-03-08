//
//  ContactCell.swift
//  ContactAppSwiftUI
//
//  Created by Yogesh Patel on 04/03/22.
//

import SwiftUI

struct ContactCell: View {
    var contact: Contact
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(contact.firstname)
                .font(.headline)
            Text(contact.lastname)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
    
}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell(contact: Contact.tempData.first!)
    }
}
