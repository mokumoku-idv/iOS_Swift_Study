//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by zsun on 4/6/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    var toDoItems:NSMutableArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        toDoItems = NSMutableArray()
        
        self._loadInitialData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.toDoItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        var toDoItem = self.toDoItems.objectAtIndex(indexPath.row) as ToDoItem
        cell.textLabel?.text = toDoItem.itemName
        cell.detailTextLabel?.text = self._relativeDateString(toDoItem.creationDate)
        
        if(toDoItem.completed) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToList(seque: UIStoryboardSegue) {
        
    }
    
    func _loadInitialData() {
        toDoItems.addObject(ToDoItem(itemName: "Buy milk"))
        toDoItems.addObject(ToDoItem(itemName: "Drink coffee"))
        toDoItems.addObject(ToDoItem(itemName: "Read a book"))
    }
    
    func _relativeDateString(date: NSDate) -> String {
        var units: NSCalendarUnit = .SecondCalendarUnit | .MinuteCalendarUnit | .HourCalendarUnit | .DayCalendarUnit | .WeekOfYearCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        var components = NSCalendar.currentCalendar().components(units, fromDate: date, toDate: NSDate(), options: nil)
        
        var result = ""
        if (components.year > 0) {
            result = String(components.year) + " years ago";
        } else if (components.month > 0) {
            result = String(components.month) + " months ago";
        } else if (components.weekOfYear > 0) {
            result = String(components.weekOfYear) + " weeks ago";
        } else if (components.day > 0) {
            result = String(components.day) + " days ago";
        } else if (components.hour > 0) {
            result = String(components.hour) + " hours ago";
        } else if (components.minute > 0) {
            result = String(components.minute) + " minutes ago";
        } else if (components.second > 0) {
            result = String(components.second) + " seconds ago";
        } else {
            result = "just now";
        }
        
        return result;
    }

}
