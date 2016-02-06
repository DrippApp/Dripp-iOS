//
//  ApiKeys.swift
//  Dripp
//
//  Created by Henry Saniuk on 2/6/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import Foundation

func valueForAPIKey(keyname: String) -> String {
    let filePath = NSBundle.mainBundle().pathForResource("ApiKeys", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value:String = plist?.objectForKey(keyname) as! String
    return value
}
