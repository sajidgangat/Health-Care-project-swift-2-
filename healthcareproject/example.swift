//
//  example.swift
//  healthcareproject
//
//  Created by Sajid gangat on 2016-12-08.
//  Copyright © 2016 pawanpreet kaur. All rights reserved.
//

import Foundation
import UIKit
class example : UIViewController{
   

var results = []
override func viewDidLoad() {
    super.viewDidLoad()
    self.loadSites()
    //self.labelName.text = results["name"].string!
    
}


func loadSites(){
    Alamofire.request(.POST, "https://exapmle.com/api")
        .responseJSON { (request, response, json, error) in
            
            if(json != nil){
                var jsonObj = JSON(json!)
                
                println(jsonObj)
                
            }
            
    }
}
}