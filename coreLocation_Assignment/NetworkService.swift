//
//  NetworkServiceViewController.swift
//  coreLocation_Assignment
//
//  Created by Payal Kandlur on 24/08/21.
//

import UIKit

class NetworkService {
    
    static let sharedInstance = NetworkService()
    
    
    func post(withBaseURL: String,
              params: [String : String]? = nil,
              body: Any? = nil, headers: [String : String]? = nil,
              completion: @escaping (_ result:AnyObject?,_ error: Error?) -> Void) {
        if let components = self.createURLComponentWithParameter(baseURL: withBaseURL, params: params) {
            if let url2 = components.url {
                var request  = URLRequest(url: url2)
                let bodyData = try? JSONSerialization.data(
                    withJSONObject: body as Any,
                    options: []
                )
                request.httpMethod = "POST"
                request.httpBody = bodyData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                
                let task = URLSession.shared.dataTask(with: request) {(data, _, error) in
                    DispatchQueue.main.async {
                        
                        if error == nil {
                            
                            guard let resData = data else { return }
                            let responseJSON = try? JSONSerialization.jsonObject(with: resData, options: [])
                                if let responseJSON = responseJSON as? [String: Any] {
                                    print(responseJSON)
                                }
                        }
                        else {
                            if let err = error as NSError? {
                                completion(nil, err)
                            }
                        }
                    }
                }
                task.resume()
                
            }
        }
    }
    
    /// This function returns URLComponents from given `baseURL` and `params`.
    /// ```
    /// Creates a url component with baseURL and paramaters
    /// ```
    /// - Warning: If empty strings passed will create a empty component.
    /// - Parameters:
    ///       - baseURL: The string base url for the api.
    ///       - params: paramaters dictonary for the api.
    /// - Returns: url components from given `baseURL` and `params` .
    func createURLComponentWithParameter(baseURL: String, params: [String:String]? = nil) -> URLComponents? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = params?.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })
        return components
    }
    
    
}
