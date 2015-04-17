//
//  MySessionDelegate.swift
//  Web
//
//  Created by pomn on 4/17/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit

class MySessionDelegate: NSObject,NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate {
    
    var backgroundSession: NSURLSession!
    var defaultSession: NSURLSession!
    var ephemeralSession: NSURLSession!
    
    var backgroundConfigObject: NSURLSessionConfiguration!
    var defaultConfigObject: NSURLSessionConfiguration!
    var ephemeralConfigObject: NSURLSessionConfiguration!
    
    var strUrl: String?
    
    var responseData: NSMutableData?
    
    func addCompleteionHandler(handler: Void, forSession identifier: String) {
    }
    
    func callCompletionHandlerForSession(identifier: String) {
    }
    
    override init(){
        super.init()
        
        /* Create some configuration objects. */
        self.backgroundConfigObject = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("myBackgroundSessionIdentifier")
        self.defaultConfigObject = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.ephemeralConfigObject = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        println(defaultConfigObject.timeoutIntervalForRequest)
        defaultConfigObject.timeoutIntervalForRequest = 15
        
        /* Configure caching behavior for the default session. */
        var cachePath = "/MyCacheDirectory"
        var myPathList = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
        var myPath = myPathList[0] as! String
        var bundleIdentifier = NSBundle.mainBundle().bundleIdentifier
        var fullCachePath = myPath.stringByAppendingPathComponent(bundleIdentifier!).stringByAppendingPathComponent(cachePath)
        
        println(fullCachePath)
        
        var myCache = NSURLCache(memoryCapacity: 16384, diskCapacity: 268435456, diskPath: cachePath)
        self.defaultConfigObject.URLCache = myCache
        self.defaultConfigObject.requestCachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
        
        /* Create a session for each configurations. */
        self.defaultSession = NSURLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        self.backgroundSession = NSURLSession(configuration: backgroundConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        self.ephemeralSession = NSURLSession(configuration: ephemeralConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
    }
    
    convenience init(url: String) {
        self.init()
        self.strUrl = url
    }
    
    func startDataTask() {
        var url = NSURL(string: self.strUrl!)
        var task: NSURLSessionDataTask = self.defaultSession.dataTaskWithURL(url!)
        task.resume()
    }
    
    func invalidateAndCancel() {
        self.defaultSession.invalidateAndCancel()
    }
    
    
    /* NSURLSessionTaskDelegate */
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            println(error)
        }
    }
    
    /* NSURLSessionDataDelegate */
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        
    }
}
