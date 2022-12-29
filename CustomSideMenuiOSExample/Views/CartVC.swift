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
    @IBOutlet weak var tble: UITableView!
    let gradientLayer = CAGradientLayer()
    
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
//        self.table.delegate = self
//        self.table.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CourseListTableViewCell.identifier, for: indexPath) as? CourseListTableViewCell
        return cell!
    }
    @IBAction func menu(_ sender:CustomButton){
        self.navigationController?.revealViewController()?.revealSideMenu()
}
}
