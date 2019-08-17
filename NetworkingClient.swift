//
//  NetworkingClient.swift
//  Alamofire
//
//  Created by Lucas on 8/13/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation
import Alamofire

struct course {
    var postId:Int?
    var id:Int?
    var body:String?
}


class NetworkingClient{
    
    static let shared = NetworkingClient()
    typealias WebServiceResponse = ([[String:Any]]?,Error?) -> Void
    
    func execute(url:String,completion: @escaping WebServiceResponse){
       
        guard let urlString = URL(string: url) else {return}
      
        var urlRequest = URLRequest(url: urlString)
        urlRequest.httpMethod = "PUT"
        Alamofire.request(urlRequest)
        
        Alamofire.request(url).validate().responseJSON { (response) in
            if let error = response.error{
            completion(nil,error)
            }else if let jsonArray = response.result.value as? [[String:Any]]
            {
                completion(jsonArray,nil)
            }else if let jsonDict = response.result.value as? [String:Any]
            {
                completion([jsonDict],nil)
            }
        }
    }
    

    
}
