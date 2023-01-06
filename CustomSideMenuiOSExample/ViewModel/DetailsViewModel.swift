//
//  DetailsViewModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 25/12/22.
//

import Foundation
import UIKit

class DetailsViewModel{
    private(set) var webservice: ApiService!
    var statusCode: Int!
    var error: Error!
    let deviceToken = UIDevice.current.identifierForVendor!.uuidString
    //  code for Api Calling
    var modelData: ResponseModel<DetailsModel>!
    init(service : ApiService, parameters: String) {
        self.webservice = service
    }
}
extension DetailsViewModel {
    
    func detailApi(parameters: String, completion :@escaping (DetailsViewModel) -> ()) {
        Constants.deviceToken = deviceToken
        self.webservice.get(DetailsModel.self, urlString: Routes.getDetails, parameters: parameters){(response, error, statusCode)  in
            debugPrint("url:",Routes.getDetails)
            if let modelData = response as? ResponseModel<DetailsModel>{
                self.modelData = modelData
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}
