//
//  AddToDoItemViewController.swift
//  ToDoList
//
//  Created by zsun on 4/6/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit

class AddToDoItemViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var toDoItem: ToDoItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (sender as? UIBarButtonItem != self.saveButton) {
            return
        }
        if (count(self.textField.text) > 0) {
            self.toDoItem = ToDoItem(itemName: self.textField.text)
        }
    }


}
