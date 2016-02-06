//
//  AuthenticationManager.swift
//  Dripp
//
//  Created by Henry Saniuk on 2/6/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import Foundation
import KeychainAccess

class AuthenticationManager: NSObject {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    private struct Constants {
        static let sharedManager = AuthenticationManager()
        static let keychain = Keychain(service: "xyz.Dripp.Dripp")
    }
    
    class var sharedManager: AuthenticationManager {
        return Constants.sharedManager
    }
    
    var token: String? {
        get {
            do {
                let toReturn = try Constants.keychain.get("token")
                return toReturn
            } catch {
                print("There was a problem in token")
                return "error"
            }
        }
        set {
            self.token = newValue
        }
    }
    
    func logout() {
        do {
            try Constants.keychain.set(" ", key: "token")
        } catch {
            print("Can't log out user")
        }
        let objFBSDKLoginManager: FBSDKLoginManager = FBSDKLoginManager()
        objFBSDKLoginManager.logOut()
    }
    
    var isLoggedIn: Bool {
        return FBSDKAccessToken.currentAccessToken() != nil
    }
    
}