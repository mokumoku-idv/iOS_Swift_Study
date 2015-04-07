//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by zsun on 4/6/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit
import iAd

class ToDoListTableViewController: UITableViewController {
    
    var toDoItems: [ToDoItem]!

    override func viewDidLoad() {
        super.viewDidLoad()
        toDoItems = []
        
        //self._loadInitialData()
        self.loadToDoItems()
        
        NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "_reloadTableView", userInfo: nil, repeats: true)
        
        self.canDisplayBannerAds = true

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
        var toDoItem = self.toDoItems[indexPath.row]
        cell.textLabel?.text = toDoItem.itemName
        cell.detailTextLabel?.text = self._relativeDateString(toDoItem.creationDate)
        
        if(toDoItem.completed) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.toDoItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        var item = self.toDoItems[fromIndexPath.row]
        self.toDoItems.removeAtIndex(fromIndexPath.row)
        self.toDoItems.insert(item, atIndex: toIndexPath.row)
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        var tappedItem: ToDoItem = self.toDoItems[indexPath.row]
        tappedItem.completed = !tappedItem.completed
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    @IBAction func unwindToList(seque: UIStoryboardSegue) {
        var source: AddToDoItemViewController = seque.sourceViewController as AddToDoItemViewController
        var item = source.toDoItem
        if (item != nil) {
            self.toDoItems.append(item)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func startEdit(sender: UIBarButtonItem) {
        var blEditing = self.tableView.editing
        if (!blEditing) {
            self.navigationItem.leftBarButtonItem?.style = UIBarButtonItemStyle.Done
            self.navigationItem.leftBarButtonItem?.title = "Done"
        } else {
            self.navigationItem.leftBarButtonItem?.style = UIBarButtonItemStyle.Plain
            self.navigationItem.leftBarButtonItem?.title = "Edit"
        }
        self.navigationItem.rightBarButtonItem?.enabled = blEditing
        self.tableView.setEditing(!blEditing, animated: true)
    }
    
    func _loadInitialData() {
        toDoItems.append(ToDoItem(itemName: "Buy milk"))
        toDoItems.append(ToDoItem(itemName: "Drink coffee"))
        toDoItems.append(ToDoItem(itemName: "Read a book"))
    }
    
    func _relativeDateString(date: NSDate) -> String {
        var units: NSCalendarUnit = .SecondCalendarUnit | .MinuteCalendarUnit | .HourCalendarUnit | .DayCalendarUnit | .WeekOfYearCalendarUnit | .MonthCalendarUnit | .YearCalendarUnit
        var components = NSCalendar.currentCalendar().components(units, fromDate: date, toDate: NSDate(), options: nil)
        
        var result = ""
        if (components.year > 0) {
            result = String(components.year) + " years ago"
        } else if (components.month > 0) {
            result = String(components.month) + " months ago"
        } else if (components.weekOfYear > 0) {
            result = String(components.weekOfYear) + " weeks ago"
        } else if (components.day > 0) {
            result = String(components.day) + " days ago"
        } else if (components.hour > 0) {
            result = String(components.hour) + " hours ago"
        } else if (components.minute > 0) {
            result = String(components.minute) + " minutes ago"
        } else if (components.second > 0) {
            result = String(components.second) + " seconds ago"
        } else {
            result = "just now"
        }
        
        return result
    }
    
    func _reloadTableView() {
        self.tableView.reloadData()
    }
    
    func _printToDoItems() {
        for item in toDoItems {
            item.print()
        }
    }
    
    func saveToDoItems() {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        var data = NSKeyedArchiver.archivedDataWithRootObject(self.toDoItems)
        userDefaults.setObject(data, forKey: "toDoItems")
        userDefaults.synchronize()
    }
    
    func loadToDoItems() {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        var data: NSData? = userDefaults.objectForKey("toDoItems") as? NSData
        if (data != nil) {
            self.toDoItems = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as [ToDoItem]
        }
    }

}
