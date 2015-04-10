//
//  ToDoItem.swift
//  ToDoList
//
//  Created by zsun on 4/6/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit

let kItemName = "itemName"
let kCompleted = "completed"
let kCreationDate = "creationDate"

class ToDoItem: NSObject, NSCoding {
    var itemName:String!
    var completed:Bool = false
    var creationDate:NSDate!
    
    override init() {
        super.init()
        creationDate = NSDate()
    }
    
    init(itemName:String) {
        super.init()
        self.itemName = itemName
        self.creationDate = NSDate()
    }
    
    init(itemName:String, completed:Bool, creationDate:NSDate) {
        super.init()
        self.itemName = itemName
        self.completed = completed
        self.creationDate = creationDate
    }
    
    required init(coder decoder: NSCoder) {
        super.init()
        itemName = decoder.decodeObjectForKey(kItemName) as! String
        completed = decoder.decodeBoolForKey(kCompleted)
        creationDate = decoder.decodeObjectForKey(kCreationDate) as! NSDate
    }
    
    func encodeWithCoder(encoder: NSCoder) {
        encoder.encodeObject(itemName, forKey: kItemName)
        encoder.encodeBool(completed, forKey: kCompleted)
        encoder.encodeObject(creationDate, forKey: kCreationDate)
    }
    
    func print() {
        println("\(itemName) \(completed) \(creationDate)")
    }
}
