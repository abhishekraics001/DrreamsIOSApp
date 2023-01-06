//
//  FaqVC.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 05/01/23.
//

import UIKit

class FaqVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table:UITableView!
    @IBOutlet weak var headerView:UIView!
    
    var gradientLayer = CAGradientLayer()
    var loaderView = LoaderView()
    var model = FaqModel()
    var faqList = [FAQ]()
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
        
        table.delegate = self
        table.dataSource = self
        self.table.register(FaqCell.nib, forCellReuseIdentifier: FaqCell.identifier)
        self.table.reloadData()
        getList()
    }
    //calling API
    private func getList(){
        self.loaderView.showLoader(view: self.view)
        let parameters = ""
        let webService = ApiService()
        let viewModel = FaqViewModel(service: webService, parameters: parameters)
        
        viewModel.faqApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            
            if let Data = viewModel.modelData.data{
                debugPrint("viewModel", viewModel)
                if let List = Data.faqs{
                    
                    self.model = FaqModel()
                    self.model = Data
                    self.faqList = List
                    debugPrint("count:",self.faqList.count)
                    self.table.reloadData()
                    
                }
            }
        }
    }
    @IBAction func menu(_ sender:CustomButton){
        self.navigationController?.revealViewController()?.revealSideMenu()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqList.count//tableView.getNumberOfRow(numberofRow: 10, message: "No domains list found!!!")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: FaqCell.identifier, for: indexPath) as? FaqCell else { fatalError("xib doesn't exist") }
        let item = faqList[indexPath.row]
        cell.configureFaq(with: item)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isSelected = faqList[indexPath.row].isSelected ?? false
        faqList[indexPath.row].isSelected = !isSelected
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
