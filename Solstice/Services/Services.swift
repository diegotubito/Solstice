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
        
        let dataTask: URLSessionDataTask = URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { (
            data, response, error) -> Void in
            
            if error != nil {
                fail(error)
                return
            }
            if data != nil {
                if let image = UIImage(data: data!) {
                    result(image)
                    return
                }
            }
            result(nil)
            
        }
        dataTask.resume()
        
    }
    
    
}
