//
//  HomeSliderViewModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 17/12/22.
//

import Foundation
import UIKit

class HomeSliderViewModel{
    private(set) var webservice: WebService!
    var statusCode: Int!
    var error: Error!
    let deviceToken = UIDevice.current.identifierForVendor!.uuidString
    
    //  code for Api Calling
    var modelData: ResponseModel<HomeModel>!
    var modelDataa: ResponseModel<PopularModel>!
    var modelDataForStartUp: ResponseModel<StartUpModel>!
    init(service : WebService, parameters: String) {
        self.webservice = service
    }
}
extension HomeSliderViewModel {
    
    func serviceProviderApi(parameters: String, completion :@escaping (HomeSliderViewModel) -> ()) {
        Constants.deviceToken = deviceToken
        self.webservice.get(HomeModel.self, urlString: Routes.slide, parameters: parameters){(response, error, statusCode)  in
            debugPrint("url:",Routes.slide)
            if let modelData = response as? ResponseModel<HomeModel>{
                self.modelData = modelData
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
    func popularCourseApi(parameters: String, completion :@escaping (HomeSliderViewModel) -> ()) {
        self.webservice.get(PopularModel.self, urlString: Routes.popularCourse, parameters: parameters){(response, error, statusCode)  in
            debugPrint("url:",Routes.popularCourse)
            if let modelData = response as? ResponseModel<PopularModel>{
                self.modelDataa = modelData
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
    func StartUpApi(parameters: String, completion :@escaping (HomeSliderViewModel) -> ()) {
        self.webservice.get(StartUpModel.self, urlString: Routes.getStartup, parameters: parameters){(response, error, statusCode)  in
            debugPrint("url:",Routes.getStartup)
            if let modelData = response as? ResponseModel<StartUpModel>{
                self.modelDataForStartUp = modelData
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}
