//
//  ContactUsViewModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 05/01/23.
//

import Foundation
import UIKit

//MARK: - ContactUsViewModel
class ContactUsViewModel{
    private(set) var webservice: ApiService!
    var statusCode: Int!
    var error: Error!
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    
    var modelData: ResponseModel<ContactUsModel>!
    
    init(service : ApiService, parameters: [String: Any]) {
        self.webservice = service
    }
}
extension ContactUsViewModel {
    
    func contactApi(parameters: [String: Any], completion :@escaping (ContactUsViewModel) -> ()) {
        
        self.webservice.post(ContactUsModel.self, urlString: Routes.contactUs, parameters: parameters){(response, error, statusCode)  in
            
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
                        if let modelData = response as? ResponseModel<ContactUsModel>{
                            self.modelData = modelData
                            Helper.app.showErrorAlert(title: "Alert", message: self.modelData.msg ?? Constants.serverError, vc: (self.sceneDelegate.window?.rootViewController)!)
                            return
                        }
                    }
                }
            }else{
                if let modelData = response as? ResponseModel<ContactUsModel>{
                    self.modelData = modelData
                }
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}
