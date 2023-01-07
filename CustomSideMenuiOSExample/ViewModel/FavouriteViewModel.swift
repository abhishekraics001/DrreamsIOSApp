//
//  FavouriteViewModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 07/01/23.
//

import Foundation
import UIKit

class FavouriteViewModel{
    private(set) var webservice: ApiService!
    var statusCode: Int!
    var error: Error!
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    
    var modelData: ResponseModel<HomeModel>!
    
    init(service : ApiService, parameters: [String: Any]) {
        self.webservice = service
    }
}
extension FavouriteViewModel {
    
    func postApi(parameters: [String: Any], completion :@escaping (FavouriteViewModel) -> ()) {
        
        self.webservice.post(HomeModel.self, urlString: Routes.signIn, parameters: parameters){(response, error, statusCode)  in
            
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
