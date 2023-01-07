//
//  ContactUsVC.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 05/01/23.
//

import UIKit

class ContactUsVC: UIViewController{
    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var nametxt:UITextField!
    @IBOutlet weak var emailtxt:UITextField!
    @IBOutlet weak var phonetxt:UITextField!
    @IBOutlet weak var countryCodetxt:UITextField!
    @IBOutlet weak var titletxt:UITextField!
    @IBOutlet weak var msgtxt:UITextView!
    @IBOutlet weak var sendBtn:CustomButton!
    //Country View
    @IBOutlet weak var countryView:UIView!
    @IBOutlet weak var countryCodetable:UITableView!
    @IBOutlet weak var searchBar:UISearchBar!
    
    var loaderView = LoaderView()
    var countryModel = CountryListModel()
    var countryList = [Countries]()
    var searchedCountry = [Countries]()
    var searching = false
    var gradientLayer = CAGradientLayer()
    let l = CAGradientLayer()
    var countryId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nametxt.text = Constants.userName ?? ""
        emailtxt.text = Constants.userEmail ?? ""
        phonetxt.text = Constants.userNumber ?? ""
        searchBar.searchTextField.backgroundColor = .white
        
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
        l.frame = self.sendBtn.bounds
        self.sendBtn.layer.insertSublayer(l, at: 0)
        self.sendBtn.innerShadow()
        mainView.mainShadow()
        
        countryView.isHidden = true

        self.searchBar.delegate = self
        countryCodetable.delegate = self
        countryCodetable.dataSource = self
        self.countryCodetable.register(CountryListCell.nib, forCellReuseIdentifier: CountryListCell.identifier)
        self.countryCodetable.reloadData()
    }
    private func getCountryList(){
        self.loaderView.showLoader(view: self.view)
        let parameters = ""
        let webService = ApiService()
        let viewModel = CountryListViewModel(service: webService, parameters: parameters)
        
        viewModel.countryListApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            
            if let countryList = viewModel.modelData.data{
                debugPrint("viewModel", viewModel)
                if let List = viewModel.modelData.data?.countries{
                    
                    self.countryModel = CountryListModel()
                    self.countryModel = countryList
                    self.countryList = List
                    debugPrint("count:",self.countryList.count)
                    self.countryCodetable.reloadData()
                    
                }
            }
        }
    }
    private func contact() {
        self.loaderView.showLoader(view: self.view)
        
//        let offset = TimeZone.current.offsetFromUTC() // Set Offset Time
        let parameters: [String: Any] = ["v_device_token": Constants.deviceToken, "e_device_type": Constants.deviceType, "t_comment": msgtxt.text!, "v_title": titletxt.text!, "v_user_name": nametxt.text!, "v_email_id": emailtxt.text!, "v_phone_number": phonetxt.text!]
        debugPrint("parameters:", parameters)
        let webservice = ApiService()
        let viewModel = ContactUsViewModel(service: webservice, parameters: parameters)
        
        viewModel.contactApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            //self.viewModel = data
            if let viewModel = viewModel.modelData{
                debugPrint("viewModel", viewModel)
                
                if viewModel.flag == true{
                    if let data = viewModel.data{
                        debugPrint("success...", data)
                        Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                        debugPrint(viewModel.msg)
                        
                    }
                }else{
                    Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    debugPrint(viewModel.msg)
                }
            }
            
            
        }
        
    }
    @IBAction func menu(_ sender:CustomButton){
        self.navigationController?.revealViewController()?.revealSideMenu()
    }
    @IBAction func sendAction(_ sender:CustomButton){
        contact()
    }
    @IBAction func countryCodeBtn(_ :CustomButton){
        countryView.isHidden = false
        getCountryList()
    }
    @IBAction func close(_ :CustomButton){
        countryView.isHidden = true
    }
}
extension ContactUsVC: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
                    return searchedCountry.count
                } else {
                    return countryList.count
                }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = countryCodetable.dequeueReusableCell(withIdentifier: CountryListCell.identifier, for: indexPath) as? CountryListCell else { fatalError("xib doesn't exist") }
        if searching {
            cell.countryName.text = searchedCountry[indexPath.row].v_name
                } else {
                    cell.countryName.text = countryList[indexPath.row].v_name
                }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if searching {
                let selectedCountry = searchedCountry[indexPath.row].v_name
                print(selectedCountry)
                countryCodetxt.text = "+"+String(searchedCountry[indexPath.row].i_phone_code)
                countryId = searchedCountry[indexPath.row].id
                countryView.isHidden = true
            } else {
                let selectedCountry = countryList[indexPath.row].v_name
                print(selectedCountry)
                countryCodetxt.text = "+"+String(countryList[indexPath.row].i_phone_code)
                countryId = countryList[indexPath.row].id
                countryView.isHidden = true
            }
            // Close keyboard when you select cell
            self.searchBar.searchTextField.endEditing(true)
        }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let filtered = self.countryList.filter { $0.v_name.uppercased().contains(searchText.uppercased())}
        self.searchedCountry = [Countries]()
        self.searchedCountry = filtered
            searching = true
        countryCodetable.reloadData()
        }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            
        searchBar.text = ""
        searching = false
        countryCodetable.reloadData()
        }
}
