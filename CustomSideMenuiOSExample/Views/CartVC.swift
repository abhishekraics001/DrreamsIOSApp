//
//  CartVC.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 28/12/22.
//

import UIKit

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    let gradientLayer = CAGradientLayer()
    var loaderView = LoaderView()
    var getdetail = DetailsModel()
    var couseDetail = CourseDetail()
    var courseSubject = [CourseSubject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.backgroundColor = .black
        headerView.layer.cornerRadius = 25
        gradientLayer.cornerRadius = 25
        gradientLayer.frame = headerView.bounds
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.blue.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.headerView.layer.insertSublayer(gradientLayer, at: 0)
        // Do any additional setup after loading the view.
        table.delegate = self
        table.dataSource = self
        // Register TableView Cell
        self.table.register(CourseListTableViewCell.nib, forCellReuseIdentifier: CourseListTableViewCell.identifier)

        // Update TableView with the data
        self.table.reloadData()
    }
    //Calling API
//    private func getCartCourses(){
//        self.loaderView.showLoader(view: self.view)
//        let parameters = ""
//        let webService = ApiService()
//        let viewModel = CartViewModel(service: webService, parameters: parameters)
//
//        viewModel.cartCoursesApi(parameters: parameters) { data in
//            self.loaderView.hideLoader(view: self.view)
//
//            if let viewModel = viewModel.modelData.data{
//                debugPrint("viewModel", viewModel)
//                if let data = viewModel.course_detail{
//                    debugPrint("data",data)
//                    if let courseList = data.course_subjects{
//                        debugPrint("subjectListCount", courseList.count)
//
//                        self.getdetail = DetailsModel()
//                        self.getdetail = viewModel
//                        self.couseDetail = data
//                        self.courseSubject = courseList
//                        self.table.delegate = self
//                        self.table.dataSource = self
//                        self.table.reloadData()
//                    }
//                }
//            }
//        }
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CourseListTableViewCell.identifier, for: indexPath) as? CourseListTableViewCell
        cell?.addToCartBtn.titleLabel?.text = "Remove"
        
        cell?.addToCartBtn.backgroundColor = UIColor(red: 1, green: 0.5268970132, blue: 0.07959405333, alpha: 1)
        return cell!
    }
    @IBAction func menu(_ sender:CustomButton){
        self.navigationController?.revealViewController()?.revealSideMenu()
    }
}
