//
//  FirstViewController.swift
//  Web
//
//  Created by pomn on 4/15/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, CompletionHandlerForSession {
    
    var data: NSDictionary?
    var mySession: MySessionDelegate!
    var basicUrl = "http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch?appid=dj0zaiZpPURWeFVCUkhHNFBKWCZkPVlXazlhMmRWY0hWcE5tOG1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9NWM-&output=json"
    
    var pickerArray: [Int] = []
    var pickerView: UIPickerView!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultsTextField: UITextField!
    
    @IBAction func searchButton(sender: UIButton) {
        var searchUrl = self.basicUrl
        if (count(self.searchTextField.text) > 0) {
            searchUrl += "&query=" + self.searchTextField.text
        }
        if (count(self.resultsTextField.text) > 0) {
            searchUrl += "&results=" + self.resultsTextField.text
        }
        self.mySession.setUrl(searchUrl)
        self.getData()
    }
    
    @IBAction func resultsTextAction(sender: UITextField) {
        self.pickerViewSelectRow()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.data = NSDictionary()
        
        self.initPickerView()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.searchTextField.delegate = self
        
        
        var strUrl = "http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch?appid=dj0zaiZpPURWeFVCUkhHNFBKWCZkPVlXazlhMmRWY0hWcE5tOG1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9NWM-&query=%E3%83%9F%E3%83%83%E3%83%89%E3%82%BF%E3%82%A6%E3%83%B3&results=10&output=json"
        //self.mySession = MySessionDelegate(url: strUrl, delegate: self)
        //mySession.startHttpGetDataTask()
        self.mySession = MySessionDelegate()
        self.mySession.setDelegate(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        mySession.startHttpGetDataTask()
    }
    
    
    /* pickerView */
    func initPickerView() {
        for n in 1...100 {
            pickerArray.append(n)
        }

        self.pickerView = UIPickerView()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerViewSelectRow()
        
        var toolBar = UIToolbar()
        //toolBar.barStyle = UIBarStyle.Default
        //toolBar.translucent = true
        //toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        var cancelBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("doPickerViewCancel"))
        var spaceBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        var doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doPickerViewDone")
        
        toolBar.setItems([cancelBarButton, spaceBarButton, doneBarButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        self.resultsTextField.inputView = self.pickerView
        self.resultsTextField.inputAccessoryView = toolBar
    }
    
    func pickerViewSelectRow() {
        if let selected = self.resultsTextField.text {
            if (count(selected) > 0) {
                if let intRow = selected.toInt() {
                    self.pickerView.selectRow(intRow - 1, inComponent: 0, animated: true)
                }
            }
        }
    }
    
    func doPickerViewCancel() {
        self.resultsTextField.resignFirstResponder()
    }
    func doPickerViewDone() {
        //self.resultsTextField.text = String(self.pickerArray[row])
        let selected = self.pickerView(self.pickerView, titleForRow: self.pickerView.selectedRowInComponent(0), forComponent: 0)
        self.resultsTextField.text = selected
        self.resultsTextField.resignFirstResponder()
    }

    
    /* ReceiveDataHandler */
    func handleReceivedData() {
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
        //println("numberOfRowsInSection \(n)")
        
        return n
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell", forIndexPath: indexPath) as! UITableViewCell
        //println("cellForRowAtIndexPath \(indexPath.row)")
        if let features = self.data!["Feature"] as? [[String: AnyObject]] {
            let feature = features[indexPath.row]
            let name = feature["Name"] as! String
            cell.textLabel?.text = name
        }

        return cell
    }
    
    
    /* UIPickerViewDelegate */
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return String(self.pickerArray[row])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //self.resultsTextField.text = String(self.pickerArray[row])
        //self.resultsTextField.resignFirstResponder()
        //pickerView.hidden = true
    }
    
    
    /* UIPickerViewDataSource */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerArray.count
    }
    
    /* UITextFieldDelegate */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }

}

