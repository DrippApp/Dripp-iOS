//
//  FeedItem.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeedItem {
    let uid: String
    let notificationID: String
    let firstName: String
    let lastName: String
    let photo: String
    let data: String
    let date: String
    let type: String
    
    convenience init(json: JSON) {
        let uid = json["uid"].stringValue
        let firstName = json["first_name"].stringValue
        let lastName = json["last_name"].stringValue
        let data = json["data"].stringValue
        let photo = json["photo"].stringValue
        let type = json["type"].stringValue
        let date = json["date"].stringValue
        let notificationID = json["notification_id"].stringValue
        self.init(uid: uid, firstName: firstName, lastName: lastName, data: data, photo: photo, type: type, notificationID: notificationID, date: date)
    }
    
    init(uid: String, firstName: String, lastName: String, data: String, photo: String, type: String, notificationID: String, date: String) {
        self.uid = uid
        self.data = data
        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
        self.type = type
        self.notificationID = notificationID
        self.date = date
    }
}