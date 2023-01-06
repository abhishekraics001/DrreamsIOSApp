//
//  SignInVC.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 17/12/22.
//

import UIKit

class SignInVC: UIViewController, UITextFieldDelegate {
    //SignUp View
    @IBOutlet weak var signUpScroll:UIScrollView!
    @IBOutlet weak var otpView:UIView!
    @IBOutlet weak var signUpUserName:UITextField!
    @IBOutlet weak var signUpEmail:UITextField!
    @IBOutlet weak var signUpCode:UITextField!
    @IBOutlet weak var signUpMobile:UITextField!
    @IBOutlet weak var signUpOTP:UITextField!
    @IBOutlet weak var checkForRadiology:UIButton!
    @IBOutlet weak var checkForPrivacy:UIButton!
    @IBOutlet weak var sendOTPBtn:CustomButton!
    @IBOutlet weak var varifyOTPBtn:CustomButton!
    @IBOutlet weak var SignUpBtn:CustomButton!
    //Login View
    @IBOutlet weak var loginView:UIView!
    @IBOutlet weak var countryCode:UITextField!
    @IBOutlet weak var phoneNumber:UITextField!
    @IBOutlet weak var emailAddress:UITextField!
    @IBOutlet weak var emailView:UIView!
    @IBOutlet weak var phoneNumberStack:UIStackView!
    @IBOutlet weak var loginMobileBtn:CustomButton!
    @IBOutlet weak var loginEmailBtn:CustomButton!
    @IBOutlet weak var loginBtn:CustomButton!
    
    //Country View
    @IBOutlet weak var countryView:UIView!
    @IBOutlet weak var countryCodetable:UITableView!
    
    //varifyOTP
    @IBOutlet weak var otp1:UITextField!
    @IBOutlet weak var otp2:UITextField!
    @IBOutlet weak var otp3:UITextField!
    @IBOutlet weak var otp4:UITextField!
    @IBOutlet weak var varifyOtpLoginBtn:CustomButton!
    
    @IBOutlet weak var searchBar:UISearchBar!
//    @IBOutlet weak var otpStack:UIStackView!
    var loaderView = LoaderView()
    var countryModel = CountryListModel()
    var countryList = [Countries]()
    var searchedCountry = [Countries]()
    var searching = false
    var selectedFieldType = "Mobile"
    var checkMarkRadiology = false
    var checkMarkPrivacy = false
    let l = CAGradientLayer()
    let m = CAGradientLayer()
    let n = CAGradientLayer()
    let o = CAGradientLayer()
    let p = CAGradientLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.backgroundColor = .white
        l.colors = [UIColor.systemPink.cgColor, UIColor.purple.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.frame = self.loginBtn.bounds
        self.loginBtn.layer.insertSublayer(l, at: 0)
        self.loginBtn.innerShadow()
        
        m.colors = [UIColor.systemPink.cgColor, UIColor.purple.cgColor]
        m.startPoint = CGPoint(x: 0, y: 0.5)
        m.endPoint = CGPoint(x: 1, y: 0.5)
        m.frame = self.sendOTPBtn.bounds
        self.sendOTPBtn.layer.insertSublayer(m, at: 0)
        
        n.colors = [UIColor.systemPink.cgColor, UIColor.purple.cgColor]
        n.startPoint = CGPoint(x: 0, y: 0.5)
        n.endPoint = CGPoint(x: 1, y: 0.5)
        n.frame = self.varifyOTPBtn.bounds
        self.varifyOTPBtn.layer.insertSublayer(n, at: 0)
        
        o.colors = [UIColor.systemPink.cgColor, UIColor.purple.cgColor]
        o.startPoint = CGPoint(x: 0, y: 0.5)
        o.endPoint = CGPoint(x: 1, y: 0.5)
        o.frame = self.SignUpBtn.bounds
        self.SignUpBtn.layer.insertSublayer(o, at: 0)
        
        p.colors = [UIColor.systemPink.cgColor, UIColor.purple.cgColor]
        p.startPoint = CGPoint(x: 0, y: 0.5)
        p.endPoint = CGPoint(x: 1, y: 0.5)
        p.frame = self.varifyOtpLoginBtn.bounds
        self.varifyOtpLoginBtn.layer.insertSublayer(p, at: 0)
        
        signUpScroll.isHidden = true
        otpView.isHidden = true
        loginView.isHidden = false
        emailView.isHidden = true
        countryView.isHidden = true

//        otpStack.isHidden = true
//        otpStack.heightAnchor.constraint(equalToConstant: 0)
        self.searchBar.delegate = self
        countryCodetable.delegate = self
        countryCodetable.dataSource = self
        self.countryCodetable.register(CountryListCell.nib, forCellReuseIdentifier: CountryListCell.identifier)
        self.countryCodetable.reloadData()
        
        otp1.delegate = self
        otp2.delegate = self
        otp3.delegate = self
        otp4.delegate = self
        
        otp1.addTarget(self, action: #selector(self.textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        otp2.addTarget(self, action: #selector(self.textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        otp3.addTarget(self, action: #selector(self.textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        otp4.addTarget(self, action: #selector(self.textFieldDidChange(textfield:)), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func textFieldDidChange(textfield: UITextField) {
        let text = textfield.text
        if text?.count == 30 {
            switch textfield {
            case emailAddress:
                emailAddress.resignFirstResponder()
            case signUpEmail:
                emailAddress.resignFirstResponder()
            case signUpUserName:
                signUpUserName.resignFirstResponder()
            default:
                break
            }
        }
        if text?.count == 15 {
            switch textfield {
            case phoneNumber:
                phoneNumber.resignFirstResponder()
            case signUpMobile:
                signUpMobile.resignFirstResponder()
            default:
                break
            }
        }
        if text?.count == 4 {
            switch textfield {
            case signUpOTP:
                signUpOTP.resignFirstResponder()
            default:
                break
            }
        }
        if text?.count == 1 {
            switch textfield {
    case otp1:
    otp2.becomeFirstResponder()
    case otp2:
    otp3.becomeFirstResponder()
    case otp3:
    otp4.becomeFirstResponder()
    case otp4:
    otp4.resignFirstResponder()
    default:
            break
            }
        }
        if  text?.count == 0 {
            switch textfield{
    case otp1:
    otp1.becomeFirstResponder()
    case otp2:
    otp1.becomeFirstResponder()
    case otp3:
    otp2.becomeFirstResponder()
    case otp4:
    otp3.becomeFirstResponder()
    default:
            break
            }
        }else{
            
        }
    }
    
    private func sendLoginDetailsWithMobile() {
        self.loaderView.showLoader(view: self.view)
        
        let deviceToken = UIDevice.current.identifierForVendor!.uuidString
        Constants.deviceToken = deviceToken
//        let offset = TimeZone.current.offsetFromUTC() // Set Offset Time
        let parameters: [String: Any] = ["v_device_token": deviceToken, "e_device_type": Constants.deviceType, "v_phone_number": phoneNumber.text!, "v_phone_code": countryCode.text!, "e_otp_receive_type": self.selectedFieldType]
        debugPrint("parameters:", parameters)
        let webservice = ApiService()
        let viewModel = SignInViewModel(service: webservice, parameters: parameters)
        
        viewModel.loginApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            //self.viewModel = data
            if let viewModel = viewModel.modelData{
                debugPrint("viewModel", viewModel)
                
                if viewModel.flag == true{
                    if let data = viewModel.data{
                        debugPrint("success...", data)
                        self.otpView.isHidden = false
                        self.loginView.isHidden = true
                    }
                }else{
                    Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    debugPrint(viewModel.msg)
                }
            }
            
            
        }
        
    }
    private func sendLoginDetailsWithEmail() {
        self.loaderView.showLoader(view: self.view)
        
        let deviceToken = UIDevice.current.identifierForVendor!.uuidString
        Constants.deviceToken = deviceToken
//        let offset = TimeZone.current.offsetFromUTC() // Set Offset Time
        let parameters: [String: Any] = ["v_device_token": deviceToken, "e_device_type": Constants.deviceType, "v_email_id": emailAddress.text!, "v_phone_code": countryCode.text!, "e_otp_receive_type": self.selectedFieldType]
        debugPrint("parameters:", parameters)
        let webservice = ApiService()
        let viewModel = SignInViewModel(service: webservice, parameters: parameters)
        
        viewModel.loginApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            //self.viewModel = data
            if let viewModel = viewModel.modelData{
                debugPrint("viewModel", viewModel)
                
                if viewModel.flag == true{
                    if let data = viewModel.data{
                        debugPrint("success...", data)
                        self.otpView.isHidden = false
                        self.loginView.isHidden = true
                    }
                }else{
                    Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    debugPrint(viewModel.msg)
                }
            }
            
            
        }
        
    }
    private func sendloginOtpphone() {
        self.loaderView.showLoader(view: self.view)
        
//        let offset = TimeZone.current.offsetFromUTC() // Set Offset Time
        let parameters: [String: Any] = ["v_otp_id":otp1.text!+otp2.text!+otp3.text!+otp4.text!, "v_device_token": Constants.deviceToken, "e_device_type": Constants.deviceType, "v_otp": otp1.text!+otp2.text!+otp3.text!+otp4.text!, "v_phone_number": phoneNumber.text!, "e_otp_verify_type": self.selectedFieldType, "v_app_version": Constants.app_version]
        debugPrint("parameters:", parameters)
        let webservice = ApiService()
        let viewModel = SignInViewModel(service: webservice, parameters: parameters)
        
        viewModel.varifyOtpSigninApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            //self.viewModel = data
            if let viewModel = viewModel.model{
                debugPrint("viewModel", viewModel)
                
                if viewModel.flag == true{
                    if let data = viewModel.data{
                        debugPrint("success...", data)
                        Constants.userName = data.user_details.v_first_name!
                        Constants.userEmail = data.user_details.v_email_id!
                        Constants.userNumber = data.user_details.v_phone_number!
                        Constants.userId = String(data.user_details.id!)
                        Constants.token = data.user_details.api_token
                        self.dismiss(animated: true)
                        
                    }
                }else{
                    Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    debugPrint(viewModel.msg)
                }
            }
            
            
        }
        
    }
    private func sendloginOtpemail() {
        self.loaderView.showLoader(view: self.view)
        
//        let offset = TimeZone.current.offsetFromUTC() // Set Offset Time
        let parameters: [String: Any] = ["v_device_token": Constants.deviceToken, "e_device_type": Constants.deviceType, "v_otp": otp1.text!+otp2.text!+otp3.text!+otp4.text!, "v_email_id": emailAddress.text!, "e_otp_verify_type": self.selectedFieldType, "v_app_version": Constants.app_version]
        debugPrint("parameters:", parameters)
        let webservice = ApiService()
        let viewModel = SignInViewModel(service: webservice, parameters: parameters)
        
        viewModel.varifyOtpSigninApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            //self.viewModel = data
            if let viewModel = viewModel.model{
                debugPrint("viewModel", viewModel)
                
                if viewModel.flag == true{
                    if let data = viewModel.data{
                        debugPrint("success...", data)
                        self.dismiss(animated: true)
                        Constants.userName = data.user_details.v_first_name!
                        Constants.userEmail = data.user_details.v_email_id!
                        Constants.userNumber = data.user_details.v_phone_number!
                        Constants.userId = String(data.user_details.id!)
                        Constants.token = data.user_details.api_token
                    }
                }else{
                    Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    debugPrint(viewModel.msg)
                }
            }
            
            
        }
        
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
    private func sendSignUpDetails() {
        self.loaderView.showLoader(view: self.view)
        
        let deviceToken = UIDevice.current.identifierForVendor!.uuidString
        Constants.deviceToken = deviceToken
//        let offset = TimeZone.current.offsetFromUTC() // Set Offset Time
        let parameters: [String: Any] = ["v_device_token": deviceToken, "e_device_type": Constants.deviceType, "v_phone_number": signUpMobile.text!, "v_email_id": signUpEmail.text!, "v_phone_code": signUpCode.text!]
        debugPrint("parameters:", parameters)
        let webservice = ApiService()
        let viewModel = SignInViewModel(service: webservice, parameters: parameters)
        
        viewModel.signupApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            //self.viewModel = data
            if let viewModel = viewModel.modelData{
                debugPrint("viewModel", viewModel)
                
                if viewModel.flag == true{
                    if let data = viewModel.data{
                        debugPrint("success...", data)
                        self.otpView.isHidden = true
                        self.loginView.isHidden = true
                        Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    }
                }else{
                    Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    debugPrint(viewModel.msg)
                }
            }
            
            
        }
        
    }
    private func verifyOtpDetails() {
        self.loaderView.showLoader(view: self.view)
        
        let deviceToken = UIDevice.current.identifierForVendor!.uuidString
        Constants.deviceToken = deviceToken
//        let offset = TimeZone.current.offsetFromUTC() // Set Offset Time
        let parameters: [String: Any] = ["v_device_token": deviceToken, "e_device_type": Constants.deviceType, "v_otp":signUpOTP.text!, "v_phone_number": signUpMobile.text!,"v_app_version":Constants.app_version, "v_email_id": signUpEmail.text!]
        debugPrint("parameters:", parameters)
        let webservice = ApiService()
        let viewModel = SignInViewModel(service: webservice, parameters: parameters)
        
        viewModel.varifyOtpApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            //self.viewModel = data
            if let viewModel = viewModel.modelData{
                debugPrint("viewModel", viewModel)
                
                if viewModel.flag == true{
                    if let data = viewModel.data{
                        debugPrint("success...", data)
                        self.otpView.isHidden = true
                        self.loginView.isHidden = true
                        Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    }
                }else{
                    Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    debugPrint(viewModel.msg)
                }
            }
            
            
        }
        
    }
    private func SignUpDetail() {
        self.loaderView.showLoader(view: self.view)
        
        let deviceToken = UIDevice.current.identifierForVendor!.uuidString
        Constants.deviceToken = deviceToken
//        let offset = TimeZone.current.offsetFromUTC() // Set Offset Time
        let parameters: [String: Any] = ["v_first_name":signUpUserName.text!, "v_device_token": deviceToken, "e_device_type": Constants.deviceType, "v_email_id":signUpEmail.text!, "v_phone_number": signUpMobile.text!, "v_profile_pic": "1.jpeg", "i_country_id": Constants.countryId, "v_app_version":Constants.app_version, "specialities": "[1,2]"]
        debugPrint("parameters:", parameters)
        let webservice = ApiService()
        let viewModel = SignUpViewModel(service: webservice, parameters: parameters)
        
        viewModel.separateSignUpApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            //self.viewModel = data
            if let viewModel = viewModel.modelData{
                debugPrint("viewModel", viewModel)
                
                if viewModel.flag == true{
                    if let data = viewModel.data{
                        debugPrint("success...", data)
                        self.otpView.isHidden = true
                        self.loginView.isHidden = true
                        Constants.token = data.user_details.api_token
                        self.dismiss(animated: false, completion: nil)
                        Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    }
                }else{
                    Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    debugPrint(viewModel.msg)
                }
            }
            
            
        }
        
    }
    @IBAction func countryCodeBtn(_ :CustomButton){
        countryView.isHidden = false
        getCountryList()
    }
    @IBAction func login(_ :CustomButton){
        if selectedFieldType == "Mobile" && phoneNumber.text == "" {
            Helper.app.showErrorAlert(title: "Alert", message: "Please enter mobile number.", vc: self)
        }else if selectedFieldType == "Email" && emailAddress.text == "" {
            Helper.app.showErrorAlert(title: "Alert", message: "Please enter email address.", vc: self)
        }else{
            if selectedFieldType == "Mobile" {
                sendLoginDetailsWithMobile()
            }else{
                sendLoginDetailsWithEmail()
            }
        }
    }
    @IBAction func Register(_ :CustomButton){
        loginView.isHidden = true
        signUpScroll.isHidden = false
    }
    @IBAction func loginchangeBtn(_ :CustomButton){
        loginView.isHidden = false
        signUpScroll.isHidden = true
    }
    @IBAction func sendotp(_ :CustomButton){
        sendSignUpDetails()
//        otpStack.isHidden = false
//        otpStack.heightAnchor.constraint(equalToConstant: 88)
    }
    @IBAction func close(_ :CustomButton){
        countryView.isHidden = true
    }
    @IBAction func verifyOtp(_ :CustomButton){
        verifyOtpDetails()
    }
    @IBAction func varifyOtpLoginAction(_ :CustomButton){
        if selectedFieldType == "Mobile" {
            sendloginOtpphone()
        }else{
            sendloginOtpemail()
        }
    }
    @IBAction func signupAction(_ :CustomButton){
        if checkMarkRadiology == false {
            Helper.app.showErrorAlert(title: "Alert", message: "Select a speciality.", vc: self)
        }else if checkMarkPrivacy == false {
            Helper.app.showErrorAlert(title: "Alert", message: "Accept Privacy Policy.", vc: self)
        }else{
            SignUpDetail()
        }
    }
    @IBAction func selectFieldAction(sender: UIButton){
        switch(sender) {
        case loginMobileBtn:
            loginMobileBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            loginEmailBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            selectedFieldType = "Mobile"
            phoneNumberStack.isHidden = false
            emailView.isHidden = true
            break
        case loginEmailBtn:
            loginMobileBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            loginEmailBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            selectedFieldType = "Email"
            phoneNumberStack.isHidden = true
            emailView.isHidden = false
            break
        default:
            break
        }
    }
    @IBAction private func checkActionForRadiology(_ sender: Any) {
        checkForRadiology.setImage(UIImage(systemName:"square"), for: .normal)
        if checkMarkRadiology{
            checkMarkRadiology = false
            checkForRadiology.setImage(UIImage(systemName:"square"), for: .normal)
        }
        else{
            checkMarkRadiology = true
            checkForRadiology.setImage(UIImage(systemName:"checkmark.square"), for: .normal)
        }
    }
    @IBAction private func checkActionForPrivacy(_ sender: Any) {
        checkForPrivacy.setImage(UIImage(systemName:"square"), for: .normal)
        checkForPrivacy.tintColor = .systemOrange
        if checkMarkPrivacy{
            checkMarkPrivacy = false
            checkForPrivacy.setImage(UIImage(systemName:"square"), for: .normal)
        }
        else{
            checkMarkPrivacy = true
            checkForPrivacy.setImage(UIImage(systemName:"checkmark.square"), for: .normal)
        }
    }
    
}
extension SignInVC: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
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
                countryCode.text = "+"+String(searchedCountry[indexPath.row].i_phone_code)
                signUpCode.text = "+"+String(searchedCountry[indexPath.row].i_phone_code)
                Constants.countryId = searchedCountry[indexPath.row].id
                countryView.isHidden = true
            } else {
                let selectedCountry = countryList[indexPath.row].v_name
                print(selectedCountry)
                countryCode.text = "+"+String(countryList[indexPath.row].i_phone_code)
                signUpCode.text = "+"+String(countryList[indexPath.row].i_phone_code)
                Constants.countryId = countryList[indexPath.row].id
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
