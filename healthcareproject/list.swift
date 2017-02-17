//
//  list.swift
//  healthcareproject
//
//  Created by Sajid gangat on 2016-12-08.
//  Copyright © 2016 pawanpreet kaur. All rights reserved.
//

import Foundation
import UIKit

class list :UIViewController{
    
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // get machine IP and display in txtField
    
    @IBAction func button(sender: AnyObject) {
        
        
        // let's begin by first setting up the URL requst object and then create a NSURLSession object to send the request
        
        //prepare the HTTP request object and set up the URL session
        let endpointURL = "https://bytemenode.herokuapp.com/patient"
        
        let session = NSURLSession.sharedSession()
        
        let url = NSURL(string: endpointURL)!           // create the NSURL object
        
        // Completion Handlers are useful when the app is making a remote API call and and then to do something once the response is received like updating a table view.
        
        // It takes a request which contains the URL. Once it gets a response (or has an error to report), the completion handler gets called. The completion handler is where we can work with the results of the call: error checking, saving the data locally, updating the UI, whatever.
        
        // The response data is obtained by providing a completion handler block {data, response, error in ....}
        // The response object returned by the completion handler encapsulates metadata associated with the request, such as MIME type and content length
        
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            // the completionHandler contains the code that is executed when the task is completed.
            // ensure that the http request was successful, check for OK
            
            // Make sure we get an OK response
            // the response object encapsulates metadata associated with the request, such as the MIME type and content length
            
            // any conditions you would have checked using 'if' before, you can now check using guard
            // example: guard age > 20 else {
            //        return false
            //}
            // note the guard statement must be written with an else clause
            guard let responseObj = response as? NSHTTPURLResponse where
                responseObj.statusCode == 200 else {
                    print("Not a 200 response") // maybe status code of 404, 418....etc.
                    return
            }
            
            //check for error
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // a status code of 200 means there is data in the response body
            // unpack the data into a JSON and then convert into a Dictionary
            // dump out the response coming back from the HTTP Get request
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("the response returned from the endpoint URL is = \(responseString)")


            
            do {
                // parse the json object to get the IP address
                // Convert server response to a NSDictionary
                
                // the NSJSONSerialization object converts the data to a json object
                //let jsonDictObj = try NSJSONSerialization.JSONObjectWithData(data!, options: ////NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let responseData = responseString!.dataUsingEncoding(NSUTF8StringEncoding)
                
                
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                //let origin = json["age"] as! String
                print(json)
                // now update the text box field
                // this will cause some threading issues
                //self.txtField.text = origin
                
                // Since this code is in a completion handler, which is a 	 thread, perform a selector to update the text field
               // self.performSelectorOnMainThread("updateTxtField:", withObject: origin, waitUntilDone: false)
                
                
            } catch {
                print("there are errors...")
            }
            
            
        }).resume() // the method above returns a task. Call resume on this task. This send the request, will hit the url and obtain the results
        
    }
    
    func updateTxtField ( text: String) {
        
        self.label.text = "IP is " + text
    }
    
}

             //let auther = json["Locations"]["quotes"][0]["author"].stringValue
            
        //    do {
                // parse the json object to get the IP address
                // Convert server response to a NSDictionary
                //let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                //print("responseString = \(responseString)")
                
             //   if let responseData = responseString!.dataUsingEncoding(NSUTF8StringEncoding) {
               //     let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: .AllowFragments)
             //
                    //print(json)
              //      let data1 = json.dataUsingEncoding(NSUTF8StringEncoding)!
                //    let jsonData = try NSJSONSerialization.JSONObjectWithData(data1, options: [])
                //    if (data1 as! String != "")
                //    {
                //    if let resMsg = jsonData["ResultMsg"] as? String {
                //        print ("ResultMsg = \(resMsg)")
                //    }
                //    }
              //
              //  }
                // the NSJSONSerialization object converts the data to a json object
               // let jsonDictObj = try NSJSONSerialization.JSONObjectWithData(data!, options: ////NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
                
                //let origin = json["patient_name"] as! String
              //  self.txtField.text = "name is " + resMsg
                // now update the text box field
                // this will cause some threading issues
                //self.txtField.text = origin
                
                // Since this code is in a completion handler, which is a different thread, perform a selector to update the text field
            //self.performSelectorOnMainThread("updateTxtField:", withObject: origin, waitUntilDone: false)
        
            
      //  }).resume() // the method above returns a task. Call resume on this task. This send the request, will hit the url and obtain the results
        
    
  //  }
    //func updateTxtField ( text: String) {
        
        //self.txtField.text = "IP is " + text
  //  }

   // }



/* The completionHandler
 
 - { _, _, _ in } is the completion handler
 
 - if u want to ignore some arguments, you can tell the swift compiler to use '_'. For example, if you only need the data and error arguments and not the response, then in the completion handler do this
 
 - let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {data, '_', error in
 
 - the signature of the completion handler is
 
 - For the dataTask(with request: completionHandler:) the completion handler argument has this signature:      completionHandler: (Data?, URLResponse?, Error?) -> Void
 
 - The response data is obtained by providing a completion handler block {data, response, error in ....}
 
 -  The response object returned by the completion handler encapsulates metadata associated with the request, such as MIME type and content length
 
 - This completion handler is basically an inline closure
 
 - you can actually drop the completion handler and use a trailing closure - basically just tack on the closure at the end of the function call. This is totally equivalent to the completion handler code above and is a common syntax you’ll see in many swift projects.
 
 let task = session.dataTaskWithURL(with: urlRequest) { (data, response, error) in // this is where the completion handler code goes
 
 if let response = response {
 print(response)
 }
 
 if let error = error { print(error) }
 }
 
 Reusing the Completion Handler
 
 You can also declare the closure as a variable then pass it in when we call session.dataTask(with:).
 
 This is quite useful if you want to use the same completion handler for multiple tasks.
 
 Here’s how you can use a variable for a completion handler:
 
 let myCompletionHandler: (Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
 // this is where the completion handler code goes
 
 if let response = response { print(response)}
 
 if let error = error { print(error)}
 }
 
 let task = session.dataTaskWithURL(with: urlRequest, completionHandler: myCompletionHandler) task.resume()
 
 
 */


/*
 
 to summarize:
 - set up the URL object
 - use NSURLSession.sharedSession() to make the call
 - create a data task with the URL
 - NSURLSession returns data in two ways: via a completion handler when a task finishes either successfully or with an error, or by calling methods on a delegate that you set upon session creation.
 - In the data task's completion handler, we get the data as the first parameters
 
 
 Lab Exercise - retrieve the an IP address by making a REST call to httpbin.org or requestb.in (these are online testing servers)
 
 - In order to make a GET REST call using Swift, we first need a URL for our GET call. The URL we’ll use is https://httpbin.org with the path /ip. This URL represents the resource we’re trying to GET. In our case, we’re asking the REST service for our IP address. Behind the scenes, the REST service will read it out of our request and return it as JSON.
 - The next thing we need is an instance of NSURLSession.
 - This is the object we’re using to make the REST request.
 - It has a method called dataTaskWithURL that takes the URL we created and a completion handler.
 - The method returns a task, which we call resume on.
 - The completion handler contains our code that is run when we get a result.
 - We get back the data, a response, and hopefully nothing in the error.
 - In our handler, unpack the data into JSON and convert into a Dictionary, which you should populate into a label.
 - Since this code is in a completion handler, which is a different thread, we perform a selector to update the label.
 - We should test the response code in our completion handler to make sure we got a response.
 - If we get an HTTP status code of 200, that means we should have data in the response body.
 - Otherwise something happened, and we need to account for it. Test for 200, but you should write special code for 404s, including 418.
 */


