//
//  ss.swift
//  healthcareproject
//
//  Created by Sajid gangat on 2016-12-08.
//  Copyright © 2016 pawanpreet kaur. All rights reserved.
//

import Foundation
import UIKit

class ee : UIViewController
{
    var dict = NSDictionary()
    
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var quoteLbl: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let urlString = "http://api.theysaidso.com/qod.json"
        
        if let url = NSURL(string: urlString) {
            
            if let data = try? NSData(contentsOfURL: url, options: []) {
                
                let json = JSON(data: data)
                
                print(json)
                
                let auther = json["contents"]["quotes"][0]["author"].stringValue
                
                let quote = json["contents"]["quotes"][0]["quote"].stringValue
                
               // authorLbl.text = auther
                print(auther)
                print(quote)
                
              //  quoteLbl.text = quote
                
            }
            
        }
