//
//  Patient.swift
//  healthcareproject
//
//  Created by Sajid gangat on 2016-12-15.
//  Copyright © 2016 pawanpreet kaur. All rights reserved.
//

import UIKit

class Patient{
    
    var firstName: String
    var lastName: String
    var occupation: String
    var bloodType:String
    
    init(firstName: String, lastName: String, occupation: String, bloodType: String) {
        // Initialize stored properties.
        self.firstName = firstName
        self.lastName = lastName
        self.occupation = occupation
        self.bloodType = bloodType
    }
    
    init() {
        // Initialize stored properties.
        self.firstName = ""
        self.lastName = ""
        self.occupation = ""
        self.bloodType = ""
    }
}
