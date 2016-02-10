//
//  WebViewController.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/31/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import Foundation

class WebViewController: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    
    override func viewDidLoad() {
        
        let link = "http://dripp.xyz/credits.html"
        
        let url = NSURL (string: link)
        let requestObj = NSURLRequest(URL: url!)
        webview.loadRequest(requestObj)
        self.navigationItem.title = "Credits"
        
    }

}