//
//  ApiService.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 17/12/22.
//

import Foundation
import UIKit
import Alamofire

var Timestamp: Int64 {
    return Int64(NSDate().timeIntervalSince1970*1000)
}
class ApiService {
    var state = uint()
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    
    
    // Post Api Call
    func post<T: Decodable>(_ objectType: T.Type, urlString: String, parameters: [String: Any], onCompletion: @escaping (Any?, Any?, Any?)-> Void){
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
            onCompletion("No Internet Connection", "No Internet Connection", "No Internet Connection")
            return
        case .online(.wwan):
            debugPrint("Connected via WWAN")
        case .online(.wiFi):
            debugPrint("Connected via WiFi")
        }
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        
        if self.state == 1000{
            request.setValue("\(Constants.token)", forHTTPHeaderField: "token")
        }
    else{
    request.setValue("Bearer \(Constants.token)", forHTTPHeaderField: "Authorization")
    }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {  // check for fundamental networking error
                debugPrint("error=\(error ?? "" as! Error)")
                onCompletion("Error", error, 0)
                return
            }
            if let httpStatus = response as? HTTPURLResponse { // check for http errors
                if httpStatus.statusCode == 200{
                    // Success
                    do {
                        if let jsonDic = try? JSONDecoder().decode(ResponseModel<T>.self, from: data){
                            onCompletion(jsonDic, error, httpStatus.statusCode)
                        } else {
                            debugPrint("bad json")
                            onCompletion("Bad Json", error, httpStatus.statusCode)
                        }
                    }
                }
                else{
                    // Error
                    onCompletion("Error", error, httpStatus.statusCode)
                }
            }
            else{
                // Error
                onCompletion("Error", error, 0)
            }
        }
        task.resume()
    }
    // Get Api Call
    func get<T: Decodable>(_ objectType: T.Type, urlString: String, parameters: String, onCompletion: @escaping (Any?, Any?, Any?)-> Void){
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
            onCompletion("No Internet Connection", "No Internet Connection", "No Internet Connection")
            return
        case .online(.wwan):
            debugPrint("Connected via WWAN")
        case .online(.wiFi):
            debugPrint("Connected via WiFi")
        }
        
        let finalStr = (urlString + parameters).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: finalStr)!
        var request = URLRequest(url: url)
//        Constants.token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyMTQ3ZjVlZmQ5NDE1ZjA3MjE0ZDU4OCIsImlhdCI6MTY1MDk2MTAzNSwiZXhwIjoxNjUxMDQ3NDM1fQ.mnkg56khI07JQoRXUHNGjWOnjOk4RpAzo_StC--y2SU"
        
        
        if self.state == 1000{
            request.setValue("\(Constants.token)", forHTTPHeaderField: "token")
        }
        else{
            request.setValue("Bearer \(Constants.token)", forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {  // check for fundamental networking error
                debugPrint("error=\(error ?? "" as! Error)")
                onCompletion("Error", error, 0)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse { // check for http errors
                if httpStatus.statusCode == 200{
                    // Success
                    do {
                        if let jsonDic = try? JSONDecoder().decode(ResponseModel<T>.self, from: data){
                            onCompletion(jsonDic, error, httpStatus.statusCode)
                        } else {
                            debugPrint("bad json")
                            onCompletion("Bad Json", error, httpStatus.statusCode)
                        }
                    }
                }
                else{
                    // Error
                    onCompletion("Error", error, httpStatus.statusCode)
                }
            }
            else{
                // Error
                onCompletion("Error", error, 0)
            }
        }
        task.resume()
    }
    // Upload File Calling
    func uploadFile(urlString: String, dataDic: NSDictionary, onCompletion: @escaping (Any?, Any?)-> Void ){
            //https://fluffy.es/upload-image-to-server/
            
            let status = Reach().connectionStatus()
            switch status {
            case .unknown, .offline:
                let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                sceneDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
                onCompletion("No Internet Connection", "No Internet Connection")
                return
            case .online(.wwan):
                debugPrint("Connected via WWAN")
            case .online(.wiFi):
                debugPrint("Connected via WiFi")
            }
            
            // generate boundary string using a unique per-app string
            let boundary = UUID().uuidString
            
            let uploadImage = dataDic.value(forKey:"file") as? UIImage
            
            // the image in UIImage type
            guard let image = uploadImage else { return }
            
            let filename = "\(boundary)-\(Timestamp)-ios_profile_image.jpg"
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: URL(string: Routes.url + urlString)!)
            urlRequest.httpMethod = "POST"
            
            // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
            // And the boundary is also set here
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            var data = Data()
            
            // Add the image data to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            //data.append(UIImagePNGRepresentation(image)!)
            data.append(image.pngData()!)
            
            // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
            // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            // Send a POST request to the URL, with the data we created earlier
            session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
                
                if(error != nil){
                    
                    onCompletion("Error", error!.localizedDescription)
                }
                
                guard let responseData = responseData else {
                    
                    onCompletion("Error", "Something went wrong, Please try again!")
                    return
                }
                let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    //print(json)
                    debugPrint("Request Url = \(Routes.url + urlString)")
                    debugPrint("Request Paramter = \(dataDic)")
                    
                    onCompletion(json as NSDictionary, error as? String)
                }
            }).resume()
        }
    // Upload Image using Alamofire
    func uploadImageByAlamofire(urlString: String, image: UIImage, fileKey: String, onCompletion: @escaping (Any?)-> Void ){
                let status = Reach().connectionStatus()
                switch status {
                case .unknown, .offline:
                    let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                    sceneDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    onCompletion("No Internet Connection")
                    return
                case .online(.wwan):
                    debugPrint("Connected via WWAN")
                case .online(.wiFi):
                    debugPrint("Connected via WiFi")
                }
        let apiUrl = Routes.url + urlString
                guard let url = URL(string: apiUrl) else {
                    return
                }
                var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
                urlRequest.httpMethod = "POST"
                urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
                let headers: [String: String] = [
                    :
                ]
                urlRequest.allHTTPHeaderFields = headers
                let fileName = "\(Timestamp)-ios_profile_image.jpg"
                AF.upload(multipartFormData: { multiPart in
                    guard let imgData = image.jpegData(compressionQuality: 0.7) else { return }
                    multiPart.append(imgData, withName: fileKey, fileName: fileName, mimeType: "image/png")
                }, with: urlRequest)
                .uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                }).responseJSON(completionHandler: { data in
                    switch data.result {
                    case .success(_):
                        do {
                            let dict = try JSONSerialization.jsonObject(
                                    with: data.data!,
                                    options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                            print("Success!", dict ?? [:])
                            onCompletion(dict ?? [:])
                        }
                        catch {
                            // catch error.
                            print("catch error")
                            onCompletion(error.localizedDescription)
                        }
                        break
                    case .failure(let error):
                        print("failure")
                        onCompletion(error.localizedDescription)
                        break
                    }
                })

            }

}

