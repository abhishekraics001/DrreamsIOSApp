//
//  MyCourseViewModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 07/01/23.
//

import Foundation
import UIKit

class MyCourseViewModel{
    private(set) var webservice: ApiService!
    var statusCode: Int!
    var error: Error!
    let deviceToken = UIDevice.current.identifierForVendor!.uuidString
    
    //  code for Api Calling
    var modelData: ResponseModel<MyCourseModel>!
    
    init(service : ApiService, parameters: String) {
        self.webservice = service
    }
}
extension MyCourseViewModel {
    
    func getApi(parameters: String, completion :@escaping (MyCourseViewModel) -> ()) {
        self.webservice.get(MyCourseModel.self, urlString: Routes.mycourses, parameters: parameters){(response, error, statusCode)  in
            debugPrint("url:")
            if let modelData = response as? ResponseModel<MyCourseModel>{
                self.modelData = modelData
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}

