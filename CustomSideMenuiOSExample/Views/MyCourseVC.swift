//
//  MyCourseVC.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 04/01/23.
//

import UIKit

class MyCourseVC: UIViewController {
    @IBOutlet weak var noDataStack:UIStackView!
    @IBOutlet weak var tablee:UITableView!
    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var filterBtn:CustomButton!
    
    var gradientLayer = CAGradientLayer()
    var myCourse = MyCourseModel()
    var coursesList = [Courses]()
    
    var loaderView = LoaderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        filterBtn.imageTintColor = UIImage(named: "filter-2-fill")?.withTintColor(.white)
        
        headerView.backgroundColor = .black
        headerView.layer.cornerRadius = 25
        gradientLayer.cornerRadius = 25
        gradientLayer.frame = headerView.bounds
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.blue.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.headerView.layer.insertSublayer(gradientLayer, at: 0)
        // Do any additional setup after loading the view.
        tablee.delegate = self
        tablee.dataSource = self
        self.tablee.register(CourseListTableViewCell.nib, forCellReuseIdentifier: CourseListTableViewCell.identifier)
        self.tablee.reloadData()
        myCoursesList()
        // Do any additional setup after loading the view.
    }
    private func myCoursesList(){
        self.loaderView.showLoader(view: self.view)
        let parameters = "users/\(Constants.userId)/my-course?v_device_token=\(Constants.deviceToken)&e_device_type=\(Constants.deviceType)&i_page_no=0&e_is_pagination=Yes&i_limit=5&v_search_keyword=&i_category_id=&i_course_badge_type_id=&e_course_content_type=&e_is_certificate=&e_course_access=&e_type=&e_is_featured_course=&i_course_limited_access_duration_id="
        let webService = ApiService()
        webService.state = 1000
        let viewModel = MyCourseViewModel(service: webService, parameters: parameters)
        
        viewModel.getApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            
            if let documentList = viewModel.modelData?.data{
                debugPrint("viewModel", documentList)
                if let courseList = documentList.my_courses{
                    debugPrint("list", courseList)
                    self.myCourse = MyCourseModel()
                    self.myCourse = documentList
                    self.coursesList = courseList
                    debugPrint("count:",self.coursesList.count)
                    self.tablee.reloadData()
                    
                }
            }
        }
    }

    @IBAction func menu(_ sender:CustomButton){
        self.navigationController?.revealViewController()?.revealSideMenu()
}

}
extension MyCourseVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if coursesList.count == 0 {
            tablee.isHidden = true
            return 0
        }else{
            return coursesList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: CourseListTableViewCell.identifier, for: indexPath) as? CourseListTableViewCell
        cell?.configureCell(data: coursesList[indexPath.row])
        return cell!
    }
}
