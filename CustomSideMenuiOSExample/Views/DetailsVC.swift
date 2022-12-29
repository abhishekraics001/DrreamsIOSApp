//
//  DetailsVC.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 25/12/22.
//

import UIKit
import Nuke
class DetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusView:UIView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var descLbl:UILabel!
    @IBOutlet weak var largedescLbl:UILabel!
    @IBOutlet weak var modulesLbl:UILabel!
    @IBOutlet weak var contentLbl:UILabel!
    @IBOutlet weak var validityLbl:UILabel!
    @IBOutlet weak var priceLbl:UILabel!
    @IBOutlet weak var totalEnrollLbl:UILabel!
    @IBOutlet weak var certificate:UILabel!
    @IBOutlet weak var courseAccessLbl:UILabel!
    @IBOutlet weak var imageforAccess:UIImageView!
    @IBOutlet weak var subjectTable:UITableView!
    
    var gradientLayer = CAGradientLayer()
    var loaderView = LoaderView()
    var getdetail = DetailsModel()
    var couseDetail = CourseDetail()
    var courseId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(courseId)
        subjectTable.register(UINib(nibName: "SubjectCell", bundle: nil), forCellReuseIdentifier: "SubjectCell")
//        self.subjectTable.delegate = self
//        self.subjectTable.dataSource = self
        imageforAccess.image = UIImage(named: "graduate-cap-svgrepo-com")?.withTintColor(.systemBlue)
        headerView.backgroundColor = .black
        headerView.layer.cornerRadius = 25
        gradientLayer.cornerRadius = 25
        gradientLayer.frame = headerView.bounds
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.blue.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.headerView.layer.insertSublayer(gradientLayer, at: 0)
        // Do any additional setup after loading the view.
        getData()
        
//        self.subjectTable.register(UINib(nibName: "SubjectCell", bundle: nil), forCellReuseIdentifier: "SubjectCell")
//        self.subjectTable.reloadData()
        
    }
    //API calling
    private func getData(){
        self.loaderView.showLoader(view: self.view)
        let parameters = ""
        let webService = WebService()
        let viewModel = DetailsViewModel(service: webService, parameters: parameters)
        
        viewModel.detailApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            
            if let viewModel = viewModel.modelData.data{
                debugPrint("viewModel", viewModel)
                if let data = viewModel.course_detail{
                    
                    self.getdetail = DetailsModel()
                    self.getdetail = viewModel
                    self.couseDetail = data
                    debugPrint("count",data)
                    self.titleLbl.text = String(data.v_name)
                    self.descLbl.text = String(data.t_short_description)
                    self.largedescLbl.text = String(data.t_long_description)
                    self.modulesLbl.text = String(data.i_subject_count) + " Modules"
                    self.contentLbl.text = String(data.i_content_count)
                    self.validityLbl.text = "Course valid for " + String(data.i_course_access_days) + " Days"
                    self.priceLbl.text = String(data.d_original_amount)
                    self.totalEnrollLbl.text = String(data.i_total_user_enroll)
                    self.statusLbl.text = String(data.course_badge_type.v_name)
                    if self.statusLbl.text == "Trending"{
                        self.statusView.backgroundColor = UIColor(red: 0.20, green: 0.50, blue: 1.00, alpha: 1.00)
                    }else{
                        self.statusView.backgroundColor = UIColor(red: 1.00, green: 0.20, blue: 0.82, alpha: 1.00)
                    }
                    self.setImage(imageView: self.courseImage, imageUrl: String(data.v_course_image_path))
                }
            }
        }
    }
    private func setImage(imageView: UIImageView, imageUrl: String){
        if let url = URL(string: imageUrl) {
            let contentModes = ImageLoadingOptions.ContentModes(
                success: .scaleAspectFill,
                failure: .scaleAspectFit,
                placeholder: .scaleAspectFit)
            var options = ImageLoadingOptions()
            options.contentModes = contentModes
            
            ImagePipeline.shared.loadImage(
                with: url) { [weak self] response in
                    guard self != nil else {
                        return
                    }
                    switch response {
                    case .failure:
                        imageView.image = UIImage(named: "")
                    case .success:
                        Nuke.loadImage(with: url, options: options, into: imageView)
                    }
                }
        }
    }
    @IBAction func backAction(_ :CustomButton){
        self.navigationController?.popViewController(animated: true)
        Routes.ser = "0"
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subjectTable.dequeueReusableCell(withIdentifier: "SubjectCell", for:indexPath) as! SubjectCell
        return cell
    }
}
