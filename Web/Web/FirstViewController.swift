//
//  FirstViewController.swift
//  Web
//
//  Created by pomn on 4/15/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var firstTextLabel: UILabel!
    @IBOutlet weak var firstTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self._get()
        
        var mySession = MySessionDelegate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func _get(){
        
        self.firstTextView.text = "_get()"
        
        var url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=London,uk")
        url = NSURL(string: "http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch?appid=dj0zaiZpPURWeFVCUkhHNFBKWCZkPVlXazlhMmRWY0hWcE5tOG1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9NWM-&query=%E3%83%9F%E3%83%83%E3%83%89%E3%82%BF%E3%82%A6%E3%83%B3&results=10&output=json")
        var request = NSURLRequest(URL: url!)
        //var session = NSURLSession.sharedSession()
        var session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            println("Response: \(response)\n")
            let httpResponse = response as! NSHTTPURLResponse
            println(httpResponse.statusCode)
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
            //println(json)
            
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
                self.firstTextView.text = names

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

