//
//  Services.swift
//  Solstice
//
//  Created by iMac on 11/04/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import UIKit
import Foundation

class ServiceManager {
    //variable for storing images in cache, to improve performance and efficiency.
    static var imageCache = NSCache<AnyObject, AnyObject>()
    
    private static let endopoint = "https://s3.amazonaws.com/technical-challenge/v3/contacts.json"
   
    static let sharedInstance = ServiceManager()
    
    static func retrieveData(onSuccess: @escaping([[String: Any]]) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = endopoint
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                onFailure(error!)
                return
            }
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String : Any]]
                onSuccess(json ?? [[:]])
            
        })
        task.resume()
    }
    
    
    
    static func downloadImageFromUrl(url: String, result: @escaping (UIImage?) -> Void, fail: @escaping (Error?) -> Void) {
        
        //if I have already loaded the image, there's no need to load it again.
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            //return the image previously loaded
            result(imageFromCache)
            return
            
        }
        
        let dataTask: URLSessionDataTask = URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { (
            data, response, error) -> Void in
            
            if error != nil {
                fail(error)
                return
            }
            if data != nil {
                if let image = UIImage(data: data!) {
                    DispatchQueue.main.async {
                        //save loaded image to cache
                        let imageToCache = image
                        imageCache.setObject(imageToCache, forKey: url as AnyObject)
                        result(imageToCache)
                        return
                        
                    }
                    
                }
            }
            result(nil)
            
        }
        dataTask.resume()
        
    }
    
    
}
