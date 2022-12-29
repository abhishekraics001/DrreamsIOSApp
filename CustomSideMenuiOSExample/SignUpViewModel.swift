//
//  SignUpViewModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 21/12/22.
//

import Foundation
import UIKit

//MARK: - SignUpViewModel
class SignUpViewModel{
    private(set) var webservice: WebService!
    var statusCode: Int!
    var error: Error!
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    
    var modelData: ResponseModel<SignUpModel>!
    
    init(service : WebService, parameters: [String: Any]) {
        self.webservice = service
    }
}
extension SignUpViewModel {
    
    func separateSignUpApi(parameters: [String: Any], completion :@escaping (SignUpViewModel) -> ()) {
        
        self.webservice.post(SignUpModel.self, urlString: Routes.seprateSignUp, parameters: parameters){(response, error, statusCode)  in
            
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
                        if let modelData = response as? ResponseModel<SignUpModel>{
                            self.modelData = modelData
                            Helper.app.showErrorAlert(title: "Alert", message: self.modelData.msg ?? Constants.serverError, vc: (self.sceneDelegate.window?.rootViewController)!)
                            return
                        }
                    }
                }
            }else{
                if let modelData = response as? ResponseModel<SignUpModel>{
                    self.modelData = modelData
                }
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}
