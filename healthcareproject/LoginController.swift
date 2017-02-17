//
//  LoginController.swift
//  healthcareproject
//
//  Created by Sajid gangat on 2016-12-15.
//  Copyright © 2016 pawanpreet kaur. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController
{
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser
        {
            // self.logoutButton.alpha = 1.0
            //self.usernameLabel.text = user.email
            
            
        }
        else
        {
            //self.logoutButton.alpha = 0.0
            // self.usernameLabel.text = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccountAction(sender: AnyObject)
    {
        if self.emailField.text == "" || self.passwordField.text == ""
        {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            FIRAuth.auth()?.createUserWithEmail(self.emailField.text!, password: self.passwordField.text!) { (user, error) in
                
                if error == nil
                {
                    //   self.logoutButton.alpha = 1.0
                 //   self.usernameLabel.text = user!.email
                    self.emailField.text = ""
                    self.passwordField.text = ""
                }
                else
                {
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                
            }
        }
        
    }
    
    @IBAction func loginAction(sender: AnyObject)
    {
        if self.emailField.text == "" || self.passwordField.text == ""
        {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else
        {
            FIRAuth.auth()?.signInWithEmail(self.emailField.text!, password: self.passwordField.text!) { (user, error) in
                
                if error == nil
                {
                    //  self.logoutButton.alpha = 1.0
                    //self.usernameLabel.text = user!.email
                    //  self.emailField.text = ""
                    self.passwordField.text = ""
                    //print(user!.email)
                    
                    self.success()
                    
                    
                    
                    /* func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                     
                     let destinationVC = segue.destinationViewController as? viewcontroller2
                     var a=self.emailField.text
                     
                     //var numberToDisplay
                     destinationVC!.numberToDisplay = a!
                     
                     
                     
                     }
                     */
                    
                    
                }
                    
                else
                {
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .Alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                
                
            }
        }
        
        
    }
    
    
    
    @IBAction func logoutAction(sender: AnyObject)
    {
        try! FIRAuth.auth()!.signOut()
        self.usernameLabel.text = ""
        //  self.logoutButton.alpha = 0.0
        self.emailField.text = ""
        self.passwordField.text = ""
    }
    
    func success(){
        
        self.performSegueWithIdentifier("loginsegue", sender: self)
        /*func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         
         let destinationVC = segue.destinationViewController as? viewcontroller2
         let a=self.emailField.text
         
         //var numberToDisplay
         destinationVC!.numberToDisplay = a!
         }
         */
        
        print("funtion  called")
        
    }
    
    // let storyboard = UIStoryboard(name: "ViewController", bundle: nil)
    //let controller = storyboard.instantiateViewControllerWithIdentifier("viewcontroller2") as! viewcontroller2
    // Add your destination view controller name and Identifier
    
    // For example consider that there is an variable xyz in your destination View Controller and you are passing "ABC" values from current viewController.
    
    //   controller.numberToDisplay = "ABC"
    
    //self.presentViewController(controller, animated: true, completion: nil)
    
    
}

