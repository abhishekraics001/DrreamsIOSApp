//
//  FaqViewModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 05/01/23.
//

import Foundation
import UIKit

class FaqViewModel{
    private(set) var webservice: ApiService!
    var statusCode: Int!
    var error: Error!
    let deviceToken = UIDevice.current.identifierForVendor!.uuidString
    
    //  code for Api Calling
    var modelData: ResponseModel<FaqModel>!
    
    init(service : ApiService, parameters: String) {
        self.webservice = service
    }
}
extension FaqViewModel {
    
    func faqApi(parameters: String, completion :@escaping (FaqViewModel) -> ()) {
        Constants.deviceToken = deviceToken
        self.webservice.get(FaqModel.self, urlString: Routes.faq, parameters: parameters){(response, error, statusCode)  in
            debugPrint("url:",Routes.slide)
            if let modelData = response as? ResponseModel<FaqModel>{
                self.modelData = modelData
            }
            DispatchQueue.main.async {
                completion(self)
            }
        }
    }
}


struct FaqModel: Decodable{
    var faqs: [FAQ]!
}
struct FAQ: Decodable {
    var id: Int!
    var v_question: String!
    var t_answer: String!
    var i_order: Int!
    var e_type: String!
    var e_status: String!
    var created_at: String!
    var updated_at: String!
    var isSelected: Bool? = false
}
