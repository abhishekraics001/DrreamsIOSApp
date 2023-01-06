//
//  CourseContentVC.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 05/01/23.
//

import UIKit

class CourseContentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tablee:UITableView!
    @IBOutlet weak var headerView:UIView!
    
    var gradientLayer = CAGradientLayer()
    var courseContent = [Content]()
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
        
        tablee.delegate = self
        tablee.dataSource = self
        // Register TableView Cell
        self.tablee.register(CourseContentCell.nib, forCellReuseIdentifier: CourseContentCell.identifier)

        // Update TableView with the data
        self.tablee.reloadData()
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tablee.dequeueReusableCell(withIdentifier: CourseContentCell.identifier, for: indexPath) as? CourseContentCell else { fatalError("xib doesn't exist") }
        cell.title.text = courseContent[indexPath.row].v_name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tablee.cellForRow(at: indexPath)as! CourseContentCell
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc : CourseContentVC = storyboard.instantiateViewController(identifier: "CourseContentVC")
////        vc.courseContent = courseSubject
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backAction(_ sender:CustomButton){
        self.navigationController?.popViewController(animated: true)
    }
}
