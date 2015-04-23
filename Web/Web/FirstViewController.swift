//
//  FirstViewController.swift
//  Web
//
//  Created by pomn on 4/15/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ReceiveDataHandler {
    
    var data: NSDictionary?
    var mySession: MySessionDelegate!
    var basicUrl = "http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch?appid=dj0zaiZpPURWeFVCUkhHNFBKWCZkPVlXazlhMmRWY0hWcE5tOG1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9NWM-&sresults=10&output=json"

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchButton(sender: UIButton) {
        let keyword = self.searchTextField.text
        if (count(self.searchTextField.text) > 0) {
            var searchUrl = self.basicUrl + "&query=" + self.searchTextField.text
            println(searchUrl)
            //searchUrl = NSString(data: searchUrl, encoding: NSUTF8StringEncoding)
            println(searchUrl)
            self.mySession.setUrl(searchUrl)
            self.getData()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.data = NSDictionary()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        var strUrl = "http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch?appid=dj0zaiZpPURWeFVCUkhHNFBKWCZkPVlXazlhMmRWY0hWcE5tOG1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9NWM-&query=%E3%83%9F%E3%83%83%E3%83%89%E3%82%BF%E3%82%A6%E3%83%B3&results=10&output=json"
        self.mySession = MySessionDelegate(url: strUrl, delegate: self)
        
        //mySession.startHttpGetDataTask()
        
        //self._get()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        mySession.startHttpGetDataTask()
    }
    
    /* ReceiveDataHandler */
    func handleData() {
        println("FirstViewController::handleData start")
        self.data = mySession.jsonData
        self.tableView.reloadData()
        //println(self.data)
        println("FirstViewController::handleData end")
    }
    
    /* UITableViewDelegate */
    
    
    /* UITableViewDataSource */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        //println("numberOfSectionsInTableView")
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var n = 0
        if self.data != nil {
            if let features = self.data!["Feature"] as? NSArray {
                n = features.count
            }
        }
        println("numberOfRowsInSection \(n)")
        
        return n
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell", forIndexPath: indexPath) as! UITableViewCell
//        println("cellForRowAtIndexPath")
//        println(indexPath.row)
        if let features = self.data!["Feature"] as? [[String: AnyObject]] {
            let feature = features[indexPath.row]
            let name = feature["Name"] as! String
            cell.textLabel?.text = name
        }

        return cell
    }
    
    
    
    
    /////////////////////////////////////////////
    
    func _get(){
        
        
        var url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=London,uk")
        url = NSURL(string: "http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch?appid=dj0zaiZpPURWeFVCUkhHNFBKWCZkPVlXazlhMmRWY0hWcE5tOG1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9NWM-&query=%E3%83%9F%E3%83%83%E3%83%89%E3%82%BF%E3%82%A6%E3%83%B3&results=10&output=json")
        var request = NSURLRequest(URL: url!)
        //var session = NSURLSession.sharedSession()
        var session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            //println("Response: \(response)\n")
            let httpResponse = response as! NSHTTPURLResponse
            //println(httpResponse.statusCode)
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
            //println(json)
            self.data = json
            //println(self.data)
            self.tableView.reloadData()
            
            if let dict = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary {
                var features = dict["Feature"] as! [[String: AnyObject]]
                var names: String = ""
                //println(features)
                for feature in features {
                    let name = feature["Name"] as! String
                    //println(name)
                    names += name + "\n"
                }
                println(names)
                //self.firstTextLabel.text = names
                //self.firstTextView.text = names

            }
            
            //println(NSString(data: data, encoding: NSUTF8StringEncoding))
            
            //let a = json["Optional"] as!
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//            if(err != nil) {
//                println(err!.localizedDescription)
//                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
//                println("Error could not parse JSON: '\(jsonStr)'")
//            }
//            else {
//                // The JSONObjectWithData constructor didn't return an error. But, we should still
//                // check and make sure that json has a value using optional binding.
//                //self.firstTextLabel.text = json
//                if let parseJSON = json {
//                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
//                    var success = parseJSON["success"] as? Int
//                    println("Succes: \(success)")
//                }
//                else {
//                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
//                    let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
//                    println("Error could not parse JSON: \(jsonStr)")
//                }
//            }
        })
        
        task.resume()

    }

}

