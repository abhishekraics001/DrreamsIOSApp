//
//  APIRequest.swift
//  Drreams
//
//  Created by sunil kumar on 11/12/22.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire


protocol APIRequestProtocol {
  func APIRequestSuccessResponseData(results: JSON)
  func APIRequestFailureResponseData(results: String)
}


class APIRequest {

    static let APIRequestInstance = APIRequest(baseURL: "");
    var baseURL =  "";
    
        //Initializer access level change now
    private init(baseURL: String){
        self.baseURL = baseURL;
    }
    
    
    func getMethod() {
        print("getMethod ")
        AF.request( baseURL, parameters: nil, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("getMethod Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("getMethod Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("getMethod Error: Could print JSON in String")
                            return
                        }
                        
                        print("getMethod  Sucess : \(prettyPrintedJson)")
                    } catch {
                        print("getMethod Error: Trying to convert JSON data to string")
                        return
                    }
                case .failure(let error):
                    print("getMethod Error: \(error)")
            }
        }
    }
    
    
    
    
    func postMethod() {
        let params: Parameters = [
            "name": "Jack",
            "salary": "3540",
            "age": "23"
        ]
        
        AF.request(baseURL , method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            return
                        }
                
                        print(prettyPrintedJson)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    
    func putMethod() {
        let params: Parameters = [
            "name": "Nicole",
            "job": "iOS Developer"
        ]
        
        AF.request("https://reqres.in/api/users/2", method: .put, parameters: params, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            return
                        }
                        
                        print(prettyPrintedJson)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
    
    
    func deleteMethod() {
        AF.request("https://my-json-server.typicode.com/typicode/demo/posts/1", method: .delete, parameters: nil, headers: nil).validate(statusCode: 200 ..< 299).responseData { response in
            switch response.result {
                case .success(let data):
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON object")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            return
                        }

                        print(prettyPrintedJson)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}


