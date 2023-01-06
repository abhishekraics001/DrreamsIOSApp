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
        // Do any additional setup after loading the view.
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
        tablee.isHidden = true
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablee.dequeueReusableCell(withIdentifier: CourseListTableViewCell.identifier, for: indexPath) as? CourseListTableViewCell
        return cell!
    }
}
