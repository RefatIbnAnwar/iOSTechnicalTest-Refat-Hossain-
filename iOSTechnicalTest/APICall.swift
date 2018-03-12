//
//  APICall.swift
//  iOSTechnicalTest
//
//  Created by iMac on 12/3/18.
//  Copyright © 2018 mcc. All rights reserved.
//

import Foundation

class APICall {
    
    
    func getDataFromJson(url: String, parameter: String, completion: @escaping (_ success: [String : Any]) -> Void) {
        
        //@escaping...If a closure is passed as an argument to a function and it is invoked after the function returns, the closure is @escaping.
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        let postString = parameter
        
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { Data, response, error in
            
            guard let data = Data, error == nil else {  // check for fundamental networking error
                
                print("error=\(error ?? "error" as! Error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {  // check for http errors
                
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
                return
                
            }
            
            let responseString  = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
            completion(responseString)
            
            
            
        }
        task.resume()
    }
    
    
}
