//
//  ServiceManagers.swift
//  Users
//
//  Created by Pedro Andres Villamil on 19/07/20.
//  Copyright © 2020 Pedro Andres Villamil. All rights reserved.
//

import Foundation
import Alamofire

struct ServiceManger {
    
    struct Response {
        let value: Any?
        let headers: [AnyHashable: Any]?
        let error: Error?
        let code: Int
    }
    
    public static func request<T: Codable> (to endpoint: String, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil,encoding: ParameterEncoding = URLEncoding.default, keypath: String? = nil, completionHandler: ((T?, Error?) -> Void)? = nil) {
        
        rawRequest(to: endpoint, method: method, parameters: parameters, headers: headers, encoding: encoding) { (response) in
            
            guard var json: Any = response.value else {
                completionHandler?(nil, response.error)
                return
            }
            
            if let keyPath = keypath, let outterJson = json as? [String: Any], let innerJson = outterJson[keyPath] {
                json = innerJson
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: json, options: [])
                let entries = try JSONDecoder().decode(T.self, from: data as Data)
                completionHandler?(entries, nil)
            } catch {
                print("[ServiceManager] Codable decoding error: \(error)")
                completionHandler?(nil, error)
            }
        }
    }
       
    public static func rawRequest(to endpoint: String, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding = URLEncoding.default, completionHandler: ((Response) -> Void)? = nil) {
        
        guard let url = URL(string: endpoint) else {
            completionHandler?(Response(value: nil, headers: nil, error: nil, code: -1 ))
            return
        }
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding).responseJSON { (response) in
        
            completionHandler?(Response(value: response.value, headers: response.response?.allHeaderFields, error: nil, code: response.response?.statusCode ?? -1 ))
        }
    }
}

