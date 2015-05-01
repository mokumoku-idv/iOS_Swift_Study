//
//  MySessionDelegate.swift
//  Web
//
//  Created by pomn on 4/17/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit

protocol CompletionHandlerForSession {
    //var data: NSDictionary {get set}
    func handleReceivedData()
}


class MySessionDelegate: NSObject,NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate {
    
    var backgroundSession: NSURLSession!
    var defaultSession: NSURLSession!
    var ephemeralSession: NSURLSession!
    
    var backgroundConfigObject: NSURLSessionConfiguration!
    var defaultConfigObject: NSURLSessionConfiguration!
    var ephemeralConfigObject: NSURLSessionConfiguration!
    
    var strUrl: String?
    var request: NSMutableURLRequest?
    var statusCode: Int?
    var receivedData: NSMutableData?
    var jsonData: NSDictionary?
    
    var delegate: CompletionHandlerForSession!
    
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
        
        //println(defaultConfigObject.timeoutIntervalForRequest)
        defaultConfigObject.timeoutIntervalForRequest = 15
        
        /* Configure caching behavior for the default session. */
        var cachePath = "/MyCacheDirectory"
        var myPathList = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
        var myPath = myPathList[0] as! String
        var bundleIdentifier = NSBundle.mainBundle().bundleIdentifier
        var fullCachePath = myPath.stringByAppendingPathComponent(bundleIdentifier!).stringByAppendingPathComponent(cachePath)
        
        //println(fullCachePath)
        
        var myCache = NSURLCache(memoryCapacity: 16384, diskCapacity: 268435456, diskPath: cachePath)
        self.defaultConfigObject.URLCache = myCache
        self.defaultConfigObject.requestCachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy
        
        /* Create a session for each configurations. */
        self.defaultSession = NSURLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        self.backgroundSession = NSURLSession(configuration: backgroundConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        self.ephemeralSession = NSURLSession(configuration: ephemeralConfigObject, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
    }
    
    convenience init(url: String, delegate: CompletionHandlerForSession) {
        self.init()
        self.strUrl = url
        self.delegate = delegate
    }
    
    func setUrl(url: String) {
        self.strUrl = url
    }
    
    func setDelegate(delegate: CompletionHandlerForSession) {
        self.delegate = delegate
    }
    
    func startHttpGetDataTask() {
        //var url = NSURL(string: self.strUrl!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        println(self.strUrl!)
        var encodeStrUrl = self.strUrl!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        println(encodeStrUrl)
        var url = NSURL(string: encodeStrUrl!)
        var task: NSURLSessionDataTask = self.defaultSession.dataTaskWithURL(url!)
        task.resume()
    }
    
    func invalidateAndCancel() {
        self.defaultSession.invalidateAndCancel()
    }
    
    /* NSURLSessionDelegate */
    func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
    }
    
    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void) {
    }
    
    func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession) {
    }
    
    /* NSURLSessionTaskDelegate */
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            println(error)
            println(error!.localizedDescription)
        }
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential!) -> Void) {
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, needNewBodyStream completionHandler: (NSInputStream!) -> Void) {
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, willPerformHTTPRedirection response: NSHTTPURLResponse, newRequest request: NSURLRequest, completionHandler: (NSURLRequest!) -> Void) {
    }
    
    /* NSURLSessionDataDelegate */
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void) {
        if response.isKindOfClass(NSHTTPURLResponse) {
            let httpURLResponse:NSHTTPURLResponse = response as! NSHTTPURLResponse
            
            self.statusCode = httpURLResponse.statusCode
            println(self.statusCode)
            
            if self.statusCode == 200 {
                println("success")
                let disposition: NSURLSessionResponseDisposition = NSURLSessionResponseDisposition.Allow
                completionHandler(disposition)
            }else{
            }
        }
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didBecomeDownloadTask downloadTask: NSURLSessionDownloadTask) {
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
        //println("Data: \(strData)")
        self.receivedData?.appendData(data)
        
        var err: NSError?
        self.jsonData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: &err) as? NSDictionary
        //println(self.jsonData)
        
        self.delegate.handleReceivedData()
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, willCacheResponse proposedResponse: NSCachedURLResponse, completionHandler: (NSCachedURLResponse!) -> Void) {
    }
    
    /* NSURLSessionDownloadDelegate ALL REQUIRED */
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        
    }
}
