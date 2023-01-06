//
//  ProfileVC.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 05/01/23.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var nametxt:UITextField!
    @IBOutlet weak var emailtxt:UITextField!
    @IBOutlet weak var phonetxt:UITextField!
    
    @IBOutlet weak var updateBtn:CustomButton!
    
    var gradientLayer = CAGradientLayer()
    let l = CAGradientLayer()
    
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
        l.colors = [UIColor.systemPink.cgColor, UIColor.purple.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.frame = self.updateBtn.bounds
        self.updateBtn.layer.insertSublayer(l, at: 0)
        self.updateBtn.innerShadow()
        mainView.mainShadow()
    }
    
    @IBAction func menu(_ sender:CustomButton){
        self.navigationController?.revealViewController()?.revealSideMenu()
    }

}
