//
//  RequestManager.swift
//  MVVMNewsFeedApp
//
//  Created by Vinayak Bhor on 19/05/20.
//  Copyright © 2020 Vinayak Bhor. All rights reserved.
//

import UIKit
//Step 2:
class RequestManager:NSObject{
    
    func post(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: Data?) -> ()) {
        dataTask(request: request, method: "POST", completion: completion)
    }
    
    func put(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: Data?) -> ()) {
        dataTask(request: request, method: "PUT", completion: completion)
    }
    
    func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: Data?) -> ()) {
        dataTask(request: request, method: "GET", completion: completion)
    }
    func get(requestString: String, completion: @escaping (_ success: Bool, _ object: Data?) -> ()) {
        Task(url: requestString, completion: completion)
    }
    
    func getClientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        
     //   let access_token =  UserDefaults.standard.value(forKey: "AccessToken") as! String
        
        var paramString = ""
        if let params = params {
            
            for (key, value) in params {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                paramString += "\(escapedKey)=\(escapedValue)&"
            }
        }
        let url = URL.init(string: path+"?"+paramString)! //else {return}
        let request = NSMutableURLRequest(url: url)
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")

        return request
    }
    
    func clientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        
        let access_token =  UserDefaults.standard.value(forKey: "AccessToken") as! String
        
        var paramString = ""
        if let params = params {
            
            for (key, value) in params {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                paramString += "\(escapedKey)=\(escapedValue)&"
            }
        }
        let url = URL.init(string: path)! //else {return}
        let request = NSMutableURLRequest(url: url)
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = paramString.data(using: .utf8)
        
        request.addValue("bearer "+access_token, forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func dataTask(request: NSMutableURLRequest, method: String, completion: @escaping (Bool, Data) -> ()) {
        request.httpMethod = method
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                
              //  let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion( true, data)
                } else {
                    completion(false, data)
                }
            }
            }.resume()
    }
    
    
    func Task(url:String, completion: @escaping (Bool, Data) -> ()) {
           //request.httpMethod = method
            if let url = URL(string: "\(url)"){
                
                let session = URLSession(configuration: .default)
                                      let task = session.dataTask(with: url) { (data, response, error) in
                                          if error == nil{
                                            completion( true, data!)
                                          }else{
                                            completion(false, data!)
                                        }
                                      }
                                      task.resume()
        }
           
       }

}
extension RequestManager {
    
    var rootView: UIViewController? {
        get {
            return UIApplication.shared.delegate?.window??.rootViewController
        }
    }
    
    func showAlert(message:String){
        
        let alertController = UIAlertController(title: "News App", message: message, preferredStyle: .alert)
        
        // Create OK button
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        alertController.addAction(OKAction)
        
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertController.addAction(cancelAction)
        
        // Present Dialog message
        
        rootView?.present(alertController, animated: true, completion:nil)
        
    }
    
    
    
    
    
    
}
