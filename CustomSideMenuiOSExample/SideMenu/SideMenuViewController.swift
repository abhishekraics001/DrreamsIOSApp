//
//  SideMenuViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by John Codeos on 2/7/21.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}
    func selectLoginBtn(_ login:UIButton){
    
}
class SideMenuViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var loginsignup: UILabel!
    @IBOutlet var userEmail: UILabel!
    @IBOutlet var userNumber: UILabel!
    @IBOutlet var userStack: UIStackView!
    @IBOutlet var sideMenuTableView: UITableView!
    @IBOutlet var footerLabel: UILabel!
    @IBOutlet weak var loginBtn:CustomButton!

    var delegate: SideMenuViewControllerDelegate?
    var defaultHighlightedCell: Int = 0
    let gradientLayer = CAGradientLayer()
    
    var menu: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(systemName: "house.fill")!, title: "Home"),
        SideMenuModel(icon: UIImage(systemName: "graduationcap.fill")!, title: "Course"),
        SideMenuModel(icon: UIImage(systemName: "heart.fill")!, title: "My Favoruite Course"),
        SideMenuModel(icon: UIImage(systemName: "doc.on.doc.fill")!, title: "Order"),
        SideMenuModel(icon: UIImage(systemName: "book.closed.fill")!, title: "My Course"),
        SideMenuModel(icon: UIImage(systemName: "book.closed.fill")!, title: "My Course"),
        SideMenuModel(icon: UIImage(systemName: "headphones.circle.fill")!, title: "Contact US"),
        SideMenuModel(icon: UIImage(systemName: "questionmark.circle.fill")!, title: "FAQ"),
        SideMenuModel(icon: UIImage(systemName: "arrowshape.zigzag.right.fill")!, title: "Logout")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
//        loginBtn.addTarget(self, action: #selector(selectLoginBtn(loginBtn)), for: .touchUpInside)
//        selectLoginBtn(loginBtn)
        
        
        
        // TableView
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.sideMenuTableView.separatorStyle = .none
//        headerView.backgroundColor = .black
//        gradientLayer.frame = self.headerView.layer.bounds.standardized
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.blue.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.headerView.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: 260, height: self.headerView.frame.size.height)

        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }

        // Footer
        self.footerLabel.textColor = UIColor.white
        self.footerLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.footerLabel.text = "Developed by John Codeos"

        // Register TableView Cell
        self.sideMenuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)

        // Update TableView with the data
        self.sideMenuTableView.reloadData()
        self.userName.text = Constants.userName
        self.userEmail.text = Constants.userEmail
        self.userNumber.text = Constants.userNumber
        print(Constants.userNumber)
        if userName.text == "" {
            headerImageView.isHidden = true
            userStack.isHidden = true
            loginsignup.isHidden = false
        }else{
            headerImageView.isHidden = false
            userStack.isHidden = false
            loginsignup.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.userName.text = Constants.userName
        self.userEmail.text = Constants.userEmail
        self.userNumber.text = Constants.userNumber
        print(Constants.userNumber)
        if userName.text == "" {
            headerImageView.isHidden = true
            userStack.isHidden = true
            loginsignup.isHidden = false
        }else{
            headerImageView.isHidden = false
            userStack.isHidden = false
            loginsignup.isHidden = true
        }
    }
    
}

// MARK: - UITableViewDelegate

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}

// MARK: - UITableViewDataSource

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }

        cell.iconImageView.image = self.menu[indexPath.row].icon
        cell.titleLabel.text = self.menu[indexPath.row].title
        if indexPath.row == 5 {
            cell.iconImageView.isHidden = true
            cell.titleLabel.isHidden = true
            cell.communicate.isHidden = false
            cell.saparator.isHidden = false
        }else{
            cell.iconImageView.isHidden = false
            cell.titleLabel.isHidden = false
            cell.communicate.isHidden = true
            cell.saparator.isHidden = true
        }
        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath.row)
        // Remove highlighted color when you press the 'Profile' and 'Like us on facebook' cell
        if indexPath.row == 4 || indexPath.row == 6 {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    @IBAction func Login(_: CustomButton){

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:SignInVC = storyboard.instantiateViewController(identifier: "SignInVC")
        present(vc, animated: true)
//        self.navigationController?.present(vc, animated: true)
    }
}
