//
//  Drippers.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import Foundation
import SwiftyJSON

class Dripper {
    let uid: String
    let email: String
    let firstName: String
    let lastName: String
    let photo: String
    let accountType: String
    let lowestShowerLength: String
    let savedWater: String
    
    convenience init(json: JSON) {
        let uid = json["uid"].stringValue
        let firstName = json["first_name"].stringValue
        let lastName = json["last_name"].stringValue
        let email = json["email"].stringValue
        let photo = json["photo"].stringValue
        let accountType = json["account_type"].stringValue
        let lowestShowerLength = json["lowest_shower_length"].stringValue
        let savedWater = json["saved_water"].stringValue
        self.init(uid: uid, firstName: firstName, lastName: lastName, email: email, photo: photo, accountType: accountType, lowestShowerLength: lowestShowerLength, savedWater: savedWater)
    }
    
    init(uid: String, firstName: String, lastName: String, email: String, photo: String, accountType: String, lowestShowerLength: String, savedWater: String) {
        self.uid = uid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
        self.accountType = accountType
        self.lowestShowerLength = lowestShowerLength
        self.savedWater = savedWater
    }
}