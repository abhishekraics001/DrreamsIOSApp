//
//  SignInViewModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 17/12/22.
//

import Foundation
import UIKit

//MARK: - SignInViewModel
class SignInViewModel{
    private(set) var webservice: ApiService!
    var statusCode: Int!
    var error: Error!
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    
    var modelData: ResponseModel<SignInModel>!
    var model: ResponseModel<VarifyOtpModel>!
    
    init(service : ApiService, parameters: [String: Any]) {
        self.webservice = service
    }
}
extension SignInViewModel {
    
    func loginApi(parameters: [String: Any], completion :@escaping (SignInViewModel) -> ()) {
        
        self.webservice.post(SignInModel.self, urlString: Routes.signIn, parameters: parameters){(response, error, statusCode)  in
            
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
                        if let modelData = response as? ResponseModel<SignInModel>{
                            self.modelData = modelData
                            Helper.app.showErrorAlert(title: "Alert", message: self.modelData.msg ?? Constants.serverError, vc: (self.sceneDelegate.window?.rootViewController)!)
                            return
                        }
                    }
                }
            }else{
                if let modelData = response as? ResponseModel<SignInModel>{
                    self.modelData = modelData
                }
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
    func signupApi(parameters: [String: Any], completion :@escaping (SignInViewModel) -> ()) {
        
        self.webservice.post(SignInModel.self, urlString: Routes.signUp, parameters: parameters){(response, error, statusCode)  in
            
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
                        if let modelData = response as? ResponseModel<SignInModel>{
                            self.modelData = modelData
                            Helper.app.showErrorAlert(title: "Alert", message: self.modelData.msg ?? Constants.serverError, vc: (self.sceneDelegate.window?.rootViewController)!)
                            return
                        }
                    }
                }
            }else{
                if let modelData = response as? ResponseModel<SignInModel>{
                    self.modelData = modelData
                }
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
    func varifyOtpApi(parameters: [String: Any], completion :@escaping (SignInViewModel) -> ()) {
        
        self.webservice.post(SignInModel.self, urlString: Routes.varifyOtp, parameters: parameters){(response, error, statusCode)  in
            
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
                        if let modelData = response as? ResponseModel<SignInModel>{
                            self.modelData = modelData
                            Helper.app.showErrorAlert(title: "Alert", message: self.modelData.msg ?? Constants.serverError, vc: (self.sceneDelegate.window?.rootViewController)!)
                            return
                        }
                    }
                }
            }else{
                if let modelData = response as? ResponseModel<SignInModel>{
                    self.modelData = modelData
                }
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
    func varifyOtpSigninApi(parameters: [String: Any], completion :@escaping (SignInViewModel) -> ()) {
        
        self.webservice.post(VarifyOtpModel.self, urlString: Routes.varifyOtpSignIn, parameters: parameters){(response, error, statusCode)  in
            
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
                        if let modelData = response as? ResponseModel<VarifyOtpModel>{
                            self.model = modelData
                            Helper.app.showErrorAlert(title: "Alert", message: self.modelData.msg ?? Constants.serverError, vc: (self.sceneDelegate.window?.rootViewController)!)
                            return
                        }
                    }
                }
            }else{
                if let modelData = response as? ResponseModel<VarifyOtpModel>{
                    self.model = modelData
                }
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}
