//
//  PatientTableViewController.swift
//  PatientList
//
//  Created by Yatin on 14/12/16.
//  Copyright © 2016 MAPD-SPY. All rights reserved.
//

import UIKit

class PatientTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

    var patients = [Patient]()
    var patientNames = [String]()
    let cellIdentifier = "PatientTableViewCell"
    var filteredArray = [Patient]()
    
    @IBOutlet weak var `as`: UISearchBar!
    var searchController: UISearchController!
    
    var shouldShowSearchResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        downloadPatients()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
      refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        for i in 0 ..< patients.count {
            let myRegex = searchString
            if let match = self.patients[i].firstName.rangeOfString(myRegex!, options: .RegularExpressionSearch){
                filteredArray.append(Patient(firstName:self.patients[i].firstName, lastName:self.patients[i].lastName, occupation: self.patients[i].occupation, bloodType : self.patients[i].bloodType) )
            }
        }
        // Filter the data array and get only those countries that match the search text.
//        filteredArray = patients.filter({
//            contains(($0 as Patient).firstName, searchString)
//        })
        
        // Reload the tableview.
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            self.tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        self.tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        self.tableView.reloadData()
    }
    
    func downloadPatients() {
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
            //            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //            print("the response returned from the endpoint URL is = \(responseString)")
            
            do {
                // parse the json object to get the IP address
                // Convert server response to a NSDictionary
                
                // the NSJSONSerialization object converts the data to a json object
                let jsonDictArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                if let patientsList = jsonDictArray as? [[String: AnyObject]] {
                    for patientJsonObject in patientsList {
                        
                        let fName = patientJsonObject["patient_name"] as? String
                        let lName = patientJsonObject["age"]  as? String
                        let occupation = patientJsonObject["address"] as? String
                        let bloodType = patientJsonObject["department"] as? String
                        
                        let patient = Patient(firstName: fName!, lastName: lName!, occupation: occupation!, bloodType:bloodType!)
                        print(patient.firstName)
                        self.patients.append(patient)
                        self.patientNames.append(patient.firstName)
                    }
                    
                }
                self.tableView.reloadData()
                //                let origin = jsonDictObj["origin"] as! String
                
                // now update the text box field
                // this will cause some threading issues
                //self.txtField.text = origin
                
                // Since this code is in a completion handler, which is a different thread, perform a selector to update the text field
                //                self.performSelectorOnMainThread("updateTxtField:", withObject: origin, waitUntilDone: false)
                
                
            } catch {
                print("there are errors...")
            }
            
            
        }).resume() // the method above returns a task. Call resume on this task. This send the request, will hit the url and obtain the results
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return patients.count
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PatientTableViewCell
        
        var patient = Patient()
        if shouldShowSearchResults {
            patient = self.filteredArray[indexPath.row]
        }
        else {
            patient = self.patients[indexPath.row]
        }
        cell.nameLabel.text = patient.firstName
        cell.agelabel.text=patient.lastName
        cell.addresslabel.text=patient.occupation
        cell.departmentlabel.text=patient.bloodType


        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
