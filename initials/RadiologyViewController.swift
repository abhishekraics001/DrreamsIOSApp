//
//  RadiologyViewController.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 05/01/23.
//

import UIKit

class RadiologyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var pageIndex: Int!
    var userIdForCart = 0
    var populardata = PopularModel()
    var courseList = [Courses]()
    var addedData = Courses()
    var favData = Courses()
    var loaderView = LoaderView()
    var addCartBool = false
    var categoryId = 1
        override func viewDidLoad() {
        super.viewDidLoad()
            tableView.delegate = self
            tableView.dataSource = self
           
            // Register TableView Cell
            self.tableView.register(CourseListTableViewCell.nib, forCellReuseIdentifier: CourseListTableViewCell.identifier)

            // Update TableView with the data
            self.tableView.reloadData()
        // Do any additional setup after loading the view.
            getPopularList()
    }
    
    private func getPopularList(){
        self.loaderView.showLoader(view: self.view)
        let parameters = "&i_page_no=0&e_is_pagination=Yes&i_limit=5&v_search_keyword=&i_category_id=\(categoryId)&i_course_badge_type_id=&e_course_content_type=&e_is_certificate=&e_course_access=&e_type=&e_is_featured_course=&i_course_limited_access_duration_id="
        let webService = ApiService()
        let viewModel = HomeSliderViewModel(service: webService, parameters: parameters)
        
        viewModel.popularCourseApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            
            if let documentList = viewModel.modelDataa?.data{
                debugPrint("viewModel", viewModel)
                if let courseList = viewModel.modelDataa.data?.courses{
                    
                    self.populardata = PopularModel()
                    self.populardata = documentList
                    self.courseList = courseList
                    debugPrint("count:",self.courseList.count)
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    private func addCart() {
        self.loaderView.showLoader(view: self.view)

        let parameters: [String: Any] = ["v_device_token": Constants.deviceToken, "e_device_type": Constants.deviceType, "i_course_id": userIdForCart, "e_operation": "add","i_course_duration_price_id": "0"]
        debugPrint("parameters:", parameters)
        let webservice = ApiService()
        webservice.state = 1000
        let viewModel = CartViewModel(service: webservice, parameters: parameters)
        
        viewModel.postCartApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            //self.viewModel = data
            if let viewModel = viewModel.modelData{
                debugPrint("viewModel", viewModel)
                
                if viewModel.flag == true{
                    if let data = viewModel.data{
                        debugPrint("success...", data)
                        Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    }
                }else{
                    Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    debugPrint(viewModel.msg)
                }
            }
            
            
        }
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280.0
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseList.count
    }
   
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CourseListTableViewCell.identifier, for: indexPath) as? CourseListTableViewCell else { fatalError("xib doesn't exist") }
        cell.configureCell(data: courseList[indexPath.row])
        
//        if courseList[indexPath.row].id == 0 {
//            if checkMarkPrivacy{
//                checkMarkPrivacy = false
//                checkForPrivacy.setImage(UIImage(systemName:"square"), for: .normal)
//            }
//            else{
//                checkMarkPrivacy = true
//                checkForPrivacy.setImage(UIImage(systemName:"checkmark.square"), for: .normal)
//            }
//        }else{
//
//        }
        cell.addToCartBtn.addTarget(self, action: #selector(self.selectAction(_:)), for: .touchUpInside)
        addedData.id = courseList[indexPath.row].id
//        courseList[indexPath.row].id = addedData.id
        
//            cell.addToCartBtn.backgroundColor = UIColor.systemOrange
//
//        }else{
//            cell.addToCartBtn.backgroundColor = UIColor.systemGreen
//        }
        cell.favouriteBtn.addTarget(self, action: #selector(self.favouriteAction(_:)), for: .touchUpInside)
        if courseList[indexPath.row].id == favData.id{
            
            cell.favouriteBtn.tintColor = #colorLiteral(red: 0.9138749242, green: 0.1091875806, blue: 0.2408354878, alpha: 1)
            
        }else{
            cell.favouriteBtn.tintColor = UIColor.lightGray
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)as! CourseListTableViewCell
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : DetailsVC = storyboard.instantiateViewController(identifier: "DetailsVC")
        vc.courseId = courseList[indexPath.row].id
        debugPrint(vc.courseId)
//        Routes.ser = String(courseList[indexPath.row].id)
//        debugPrint(String(courseList[indexPath.row].id))
//        debugPrint(Routes.ser)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func selectAction (_ sender: CustomButton){
        if addCartBool{
            addCartBool = true
            addedData = courseList[sender.tag]
             tableView.reloadData()
            debugPrint("buttontapped")
             userIdForCart = addedData.id
             addCart()
        }else{
            addCartBool = false
            addedData = courseList[sender.tag]
            tableView.reloadData()
            debugPrint("buttontappedagain")
            userIdForCart = addedData.id
            addCart()
        }

       }
    @objc func favouriteAction (_ sender: CustomButton){
           
           favData = courseList[sender.tag]
            tableView.reloadData()
           debugPrint("buttontapped")
            userIdForCart = favData.id
            addCart()

       }
}
