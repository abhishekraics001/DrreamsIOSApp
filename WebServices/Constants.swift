//
//  Constants.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 17/12/22.
//

import UIKit

struct Constants {
    static var token: String = ""
    static var isInvalidToken = false
    static var serverError = "Oops! Something went wrong."
    static var sessionError = "Session is expired, Please Login again."
    static var deviceType = "Ios"
    static var app_version = "v1.0"
    static var userName = ""
    static var userEmail = ""
    static var userNumber = ""
    static var userId = ""
    static var deviceToken: String = ""
    static var countryId = 0
    static var courseId = 0
    
    
}
class Helper {
    static var app: Helper = {
        return Helper()
    }()
    func showErrorAlert(title: String, message:String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message,    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAction)
//        alert.addAction(cancelAction)
        vc.present(alert, animated: true, completion: nil)
    }
    
}
