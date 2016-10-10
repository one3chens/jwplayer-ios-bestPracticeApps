//
//  JWFairPlayDrmViewController.swift
//  JWBestPracticeApps
//
//  Created by Karim Mourra on 9/26/16.
//  Copyright © 2016 Karim Mourra. All rights reserved.
//

class JWFairPlayDrmViewController: JWBasicVideoViewController, JWDrmDataSource, NSURLSessionDelegate {
    
    let encryptedFile = "http://fps.ezdrm.com/demo/video/ezdrm.m3u8"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.player.drmDataSource = self
    }
    
    override func onReady() {
        self.player.load(encryptedFile)
    }
    
    func fetchContentIdentifierForRequest(_ loadingRequestURL: NSURL!, forEncryption encryption: JWEncryption, withCompletion completion: ((NSData?) -> Void)!) {
        if encryption == JWFairPlay {
            let assetId = loadingRequestURL.parameterString
            let asssetIdData = NSData.init(bytes: (assetId?.cStringUsingEncoding(NSUTF8StringEncoding))!, length: (assetId?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))!)
            completion(asssetIdData)
        }
    }
    
    func fetchAppIdentifierForRequest(_ loadingRequestURL: NSURL!, forEncryption encryption: JWEncryption, withCompletion completion: ((NSData?) -> Void)!) {
        if encryption == JWFairPlay {
            let request = NSMutableURLRequest.init()
            request.URL = NSURL.init(string: "http://fps.ezdrm.com/demo/video/eleisure.cer")
            request.HTTPMethod = "GET"
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession.init(configuration: configuration, delegate: self, delegateQueue: nil)
            let getDataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                completion(data)
                session.finishTasksAndInvalidate()
            })
            getDataTask.resume()
        }
    }
    
    func fetchContentKeyWithRequest(_ requestBytes: NSData!, forEncryption encryption: JWEncryption, withCompletion completion: ((NSData?, NSDate?, String?) -> Void)!) {
        if encryption == JWFairPlay {
            let currentTime = NSTimeIntervalSince1970 * 1000
            let keyServerAddress = String.init(format: "http://fps.ezdrm.com/api/licenses/09cc0377-6dd4-40cb-b09d-b582236e70fe?p1=\(currentTime)")
            let ksmURL = NSURL.init(string: keyServerAddress)
            let request = NSMutableURLRequest.init(URL: ksmURL!)
            request.HTTPMethod = "POST"
            request.setValue("application/octet-stream", forHTTPHeaderField: "Content-type")
            request.HTTPBody = requestBytes
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession.init(configuration: configuration, delegate: self, delegateQueue: nil)
            let postDataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                completion(data, nil, nil)
            })
            postDataTask.resume()
        }
    }
}
