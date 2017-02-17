//
//  addpatientcontroller.swift
//  healthcareproject
//
//  Created by Sajid gangat on 2016-12-13.
//  Copyright © 2016 pawanpreet kaur. All rights reserved.
//

import Foundation
import UIKit


class addpatientcontroller: UIViewController {
    @IBOutlet weak var txtname: UITextField!
    
    @IBOutlet weak var txtdate: UIDatePicker!
    @IBOutlet weak var txttemp: UITextField!
    @IBOutlet weak var txtcholes: UITextField!
    @IBOutlet weak var txtblood: UITextField!
    override func viewDidLoad() {
        
        
    }
    
    @IBAction func addpatient(sender: AnyObject) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://bytemenode.herokuapp.com/test")!)
        request.HTTPMethod = "POST"
    //    let postString = "firstName=RAm&lastName=Bharose&address=a&contact=a&occupation=s&bloodType=B&insurance=s"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.stringFromDate(txtdate.date)
        //let postdata3 = strDate
        
        let postdata1="patient_name="+txtname.text! + "&temperature=" + txttemp.text! + "&cholesterol="+txtcholes.text! + "&blood_presure="+txtblood.text!
        let postdata2="&date=" + strDate
        //let postdata2="&blood_presure="+txtblood.text!
     //   let postdata3="&cholesterol="+txtcholes.text!
        //let postdata4="&date=" +txtdate.date
      //  let postdata4 = strDate
      
        
        //let postdata4="&date="+txtdate.accessibilityValue!
        
        let postdata=postdata1 + postdata2
        request.HTTPBody = postdata.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
        
        
        
        
    }
    
    
}