//
//  CountryListViewModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 18/12/22.
//

import Foundation
import UIKit

class CountryListViewModel{
    private(set) var webservice: WebService!
    var statusCode: Int!
    var error: Error!
    let deviceToken = UIDevice.current.identifierForVendor!.uuidString
    
    //  code for Api Calling
    var modelData: ResponseModel<CountryListModel>!
    init(service : WebService, parameters: String) {
        self.webservice = service
    }
}
extension CountryListViewModel {
    
    func countryListApi(parameters: String, completion :@escaping (CountryListViewModel) -> ()) {
        Constants.deviceToken = deviceToken
        self.webservice.get(CountryListModel.self, urlString: Routes.countryCode, parameters: parameters){(response, error, statusCode)  in
            debugPrint("url:",Routes.slide)
            if let modelData = response as? ResponseModel<CountryListModel>{
                self.modelData = modelData
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}
