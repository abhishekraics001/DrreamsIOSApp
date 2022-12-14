//
//  CartViewModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 02/01/23.
//

import Foundation
import UIKit

class CartViewModel{
    private(set) var webservice: ApiService!
    var statusCode: Int!
    var error: Error!
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    
    var modelData: ResponseModel<HomeModel>!
    
    init(service : ApiService, parameters: [String: Any]) {
        self.webservice = service
    }
}
extension CartViewModel {
    
    func postCartApi(parameters: [String: Any], completion :@escaping (CartViewModel) -> ()) {
        
        self.webservice.post(HomeModel.self, urlString: Routes.addCartCourses, parameters: parameters){(response, error, statusCode)  in
            
            self.statusCode = statusCode as? Int
            self.error = error as? Error
            
            if let statusCode = self.statusCode, statusCode != 200{
                var errorStr = ""
                if let error = self.error{
                    errorStr = "\(error)"
                }else{
                    errorStr = Constants.serverError
                }
                if statusCode == 0{
                    DispatchQueue.main.async {
                        Helper.app.showErrorAlert(title: "Error", message: errorStr, vc: (self.sceneDelegate.window?.rootViewController)!)
                    }
                }else{
                    DispatchQueue.main.async {
                        if let modelData = response as? ResponseModel<HomeModel>{
                            self.modelData = modelData
                            Helper.app.showErrorAlert(title: "Alert", message: self.modelData.msg ?? Constants.serverError, vc: (self.sceneDelegate.window?.rootViewController)!)
                            return
                        }
                    }
                }
            }else{
                if let modelData = response as? ResponseModel<HomeModel>{
                    self.modelData = modelData
                }
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}
class CartGetViewModel{
    private(set) var webservice: ApiService!
    var statusCode: Int!
    var error: Error!
    let deviceToken = UIDevice.current.identifierForVendor!.uuidString
    
    //  code for Api Calling
    var modelData: ResponseModel<PopularModel>!
    
    init(service : ApiService, parameters: String) {
        self.webservice = service
    }
}
extension CartGetViewModel {
    
    func getCartApi(parameters: String, completion :@escaping (CartGetViewModel) -> ()) {
        self.webservice.get(PopularModel.self, urlString: Routes.getCartCourses, parameters: parameters){(response, error, statusCode)  in
            debugPrint("url:",Routes.getCartCourses)
            if let modelData = response as? ResponseModel<PopularModel>{
                self.modelData = modelData
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}
