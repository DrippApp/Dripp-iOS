//
//  CurrentUserInformation.swift
//  Dripp
//
//  Created by Henry Saniuk on 2/6/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import Foundation

class CurrentUserInformation: NSObject {
    
    private struct Constants {
        static let sharedManager = CurrentUserInformation()
    }
    
    class var sharedManager: CurrentUserInformation {
        return Constants.sharedManager
    }
    
    func getName() -> String {
        var name = ""
        let params = ["fields": "name"]
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: params)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
                name = "Error"
            }
            else
            {
                name = result.valueForKey("name") as! String
            }
        })
        return name
    }
}