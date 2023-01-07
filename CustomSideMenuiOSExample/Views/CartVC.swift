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
    var getdetail = PopularModel()
    var couses = [Courses]()
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
        getCartCourses()
    }
    //Calling API
    
    private func getCartCourses(){
        self.loaderView.showLoader(view: self.view)
        let parameters = ""
        let webService = ApiService()
        webService.state = 1000
        let viewModel = CartGetViewModel(service: webService, parameters: parameters)
        
        viewModel.getCartApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            
            if let viewModel = viewModel.modelData?.data{
                debugPrint("viewModel", viewModel)
                if let data = viewModel.courses{
                    
                    self.getdetail = PopularModel()
                    self.getdetail = viewModel
                    self.couses = data
                    self.table.delegate = self
                    self.table.dataSource = self
                    self.table.reloadData()
                }
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CourseListTableViewCell.identifier, for: indexPath) as? CourseListTableViewCell
        cell?.addToCartBtn.titleLabel?.text = "Remove"
        
        cell?.addToCartBtn.backgroundColor = UIColor(red: 1, green: 0.5268970132, blue: 0.07959405333, alpha: 1)
        cell?.configureCell(data: couses[indexPath.row])
        return cell!
    }
    @IBAction func menu(_ sender:CustomButton){
        self.navigationController?.revealViewController()?.revealSideMenu()
    }
}
