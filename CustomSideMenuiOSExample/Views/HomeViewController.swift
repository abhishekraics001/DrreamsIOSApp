//
//  ViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by John Codeos on 2/§/21.
//

import UIKit
import FSPagerView
import Nuke

class HomeViewController: UIViewController, FSPagerViewDataSource,FSPagerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var bar : UINavigationBar!
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var rightNavBar: UIBarButtonItem!
    @IBOutlet weak var headerView: CustomView!
    @IBOutlet weak var sideBtn:CustomButton!
    @IBOutlet weak var filterBtn:CustomButton!
    @IBOutlet weak var cartBtn:BadgedButtonItem!
//    let btn = BadgedButtonItem(with: UIImage(systemName: "cart.fill")!)
    var courseID = 0
    @IBOutlet weak var tableView: UITableView!
    var userIdForCart = 0
    var courseid = SendDetailId()
    var loaderView = LoaderView()
    var getList = HomeModel()
    var slider = [Slider]()
    var populardata = PopularModel()
    var courseList = [Courses]()
    var addedData = Courses()
    var favData = Courses()
    let gradientLayer = CAGradientLayer()
    var addCartBool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu Button Tint Color
//        self.cartBtn.setBadge(with: 2)
        navigationController?.navigationBar.tintColor = .white
//        bar.barTintColor = .blue
        filterBtn.imageTintColor = UIImage(named: "filter-2-fill")?.withTintColor(.white)
        
        headerView.backgroundColor = .black
        headerView.layer.cornerRadius = 25
        gradientLayer.cornerRadius = 25
        gradientLayer.frame = headerView.bounds
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.blue.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.headerView.layer.insertSublayer(gradientLayer, at: 0)
       

        let searchImage  = UIImage(named: "filter-2-fill")!
        let editButton   = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: nil)
        
        //self.navigationItem.rightBarButtonItem = btn
//        self.navigationItem.rightBarButtonItems = [editButton, btn ]
//        self.btn.setBadge(with: 10)
//        btn.tapAction = {
            //self.btn.setBadge(with: 1)
//        }
        
        editButton.action = #selector(barButtonAction)
        
        self.view.addSubview(pageControl)
        self.pageControl.numberOfPages = self.imageNames.count
        self.pageControl.contentHorizontalAlignment = .center
        self.pageControl.contentVerticalAlignment = .bottom
        self.pageControl.contentMode = .bottom
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        self.pageControl.contentInsets = UIEdgeInsets(top: 580, left: 420, bottom: 0, right: 20)
        self.pageControl.setStrokeColor(.white, for: .normal)
        self.pageControl.setStrokeColor(.orange, for: .selected)
        self.pageControl.setFillColor(.white, for: .normal)
        self.pageControl.setFillColor(.orange, for: .selected)
        self.pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 6, height: 6)), for: .normal)
        self.pageControl.setPath(UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 6, height: 6), cornerRadius: 3), for: .selected)
        self.pageControl.itemSpacing = 5
        
        tableView.delegate = self
        tableView.dataSource = self
       
        // Register TableView Cell
        self.tableView.register(CourseListTableViewCell.nib, forCellReuseIdentifier: CourseListTableViewCell.identifier)

        // Update TableView with the data
        self.tableView.reloadData()
        
        
        getDataURL();
        
        getServiceProvider()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        Constants.courseId = 0
        getPopularList()
    }
    @objc func barButtonAction() {
       print("Button pressed")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:FilterVC = storyboard.instantiateViewController(identifier: "FilterVC")
        self.navigationController?.present(vc, animated: true)
    }
    //API calling
    private func getServiceProvider(){
        self.loaderView.showLoader(view: self.view)
        let parameters = ""
        let webService = ApiService()
        let viewModel = HomeSliderViewModel(service: webService, parameters: parameters)
        
        viewModel.serviceProviderApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            
            if let documentList = viewModel.modelData.data{
                debugPrint("viewModel", viewModel)
                if let slider = viewModel.modelData.data?.sliders{
                    
                    self.getList = HomeModel()
                    self.getList = documentList
                    self.slider = slider
                    debugPrint("count",self.slider.count)
                    self.pagerView.reloadData()
                    
                }
            }
        }
    }
    private func getPopularList(){
        self.loaderView.showLoader(view: self.view)
        let parameters = "&i_page_no=0&e_is_pagination=Yes&i_limit=5&v_search_keyword=&i_category_id=&i_course_badge_type_id=&e_course_content_type=&e_is_certificate=&e_course_access=&e_type=&e_is_featured_course=&i_course_limited_access_duration_id="
        let webService = ApiService()
        let viewModel = HomeSliderViewModel(service: webService, parameters: parameters)
        
        viewModel.popularCourseApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            
            if let documentList = viewModel.modelDataa?.data{
                debugPrint("viewModel", viewModel)
                if let courseList = viewModel.modelDataa.data?.courses{
                    
                    self.populardata = PopularModel()
                    self.populardata = documentList
                    self.courseList = courseList
                    debugPrint("count:",self.courseList.count)
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
    private func addCart() {
        self.loaderView.showLoader(view: self.view)

        let parameters: [String: Any] = ["v_device_token": Constants.deviceToken, "e_device_type": Constants.deviceType, "i_course_id": userIdForCart, "e_operation": "add","i_course_duration_price_id": "0"]
        debugPrint("parameters:", parameters)
        let webservice = ApiService()
        webservice.state = 1000
        let viewModel = CartViewModel(service: webservice, parameters: parameters)
        
        viewModel.postCartApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            //self.viewModel = data
            if let viewModel = viewModel.modelData{
                debugPrint("viewModel", viewModel)
                
                if viewModel.flag == true{
                    if let data = viewModel.data{
                        debugPrint("success...", data)
                        Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    }
                }else{
                    Helper.app.showErrorAlert(title: "Alert", message: viewModel.msg!, vc: self)
                    debugPrint(viewModel.msg)
                }
            }
            
            
        }
        
    }
    func getDataURL(){
        print("getMethod ")
        let req = APIRequest.APIRequestInstance.getMethod();
        
        let reqr = APIRequest.APIRequestInstance.postMethod();
        print(req)
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280.0
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseList.count
    }
   
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CourseListTableViewCell.identifier, for: indexPath) as? CourseListTableViewCell else { fatalError("xib doesn't exist") }
        cell.configureCell(data: courseList[indexPath.row])
        
//        if courseList[indexPath.row].id == 0 {
//            if checkMarkPrivacy{
//                checkMarkPrivacy = false
//                checkForPrivacy.setImage(UIImage(systemName:"square"), for: .normal)
//            }
//            else{
//                checkMarkPrivacy = true
//                checkForPrivacy.setImage(UIImage(systemName:"checkmark.square"), for: .normal)
//            }
//        }else{
//
//        }
        cell.addToCartBtn.addTarget(self, action: #selector(self.selectAction(_:)), for: .touchUpInside)
        addedData.id = courseList[indexPath.row].id
//        courseList[indexPath.row].id = addedData.id
        
//            cell.addToCartBtn.backgroundColor = UIColor.systemOrange
//
//        }else{
//            cell.addToCartBtn.backgroundColor = UIColor.systemGreen
//        }
        cell.favouriteBtn.addTarget(self, action: #selector(self.favouriteAction(_:)), for: .touchUpInside)
        if courseList[indexPath.row].id == favData.id{
            
            cell.favouriteBtn.tintColor = #colorLiteral(red: 0.9138749242, green: 0.1091875806, blue: 0.2408354878, alpha: 1)
            
        }else{
            cell.favouriteBtn.tintColor = UIColor.lightGray
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)as! CourseListTableViewCell
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : DetailsVC = storyboard.instantiateViewController(identifier: "DetailsVC")
        vc.courseId = courseList[indexPath.row].id
        debugPrint(vc.courseId)
//        Routes.ser = String(courseList[indexPath.row].id)
//        debugPrint(String(courseList[indexPath.row].id))
//        debugPrint(Routes.ser)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func selectAction (_ sender: CustomButton){
        if addCartBool{
            addCartBool = true
            addedData = courseList[sender.tag]
             tableView.reloadData()
            debugPrint("buttontapped")
             userIdForCart = addedData.id
             addCart()
        }else{
            addCartBool = false
            addedData = courseList[sender.tag]
            tableView.reloadData()
            debugPrint("buttontappedagain")
            userIdForCart = addedData.id
            addCart()
        }

       }
    @objc func favouriteAction (_ sender: CustomButton){
           
           favData = courseList[sender.tag]
            tableView.reloadData()
           debugPrint("buttontapped")
            userIdForCart = favData.id
            addCart()

       }
    
    
        fileprivate let sectionTitles = ["Configurations", "Decelaration Distance", "Item"]
        fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg"]
        fileprivate var numberOfItems = 3
        
    
        @IBOutlet weak var pagerView: FSPagerView! {
            didSet {
                
                self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
                //self.pagerView.itemSize = FSPagerView.automaticSize
                //self.pagerView.itemSize = CGSize(width: pagerView.frame.width,height: pagerView.frame.height)
                pagerView.itemSize = CGSize(width: pagerView.frame.width, height: 180)
                self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
                self.pagerView.automaticSlidingInterval = 2.0
                pagerView.isInfinite = true
                
                
                
                //let pageControl = FSPageControl(frame: frame2)
                
                
            }
        }
        
    let pageControl = FSPageControl(frame: CGRect(x:0, y: 0, width:0, height:0))
        
        // MARK:- FSPagerView DataSource
        
        public func numberOfItems(in pagerView: FSPagerView) -> Int {
            return self.slider.count
            
        }
        
        public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
            //cell.layer.shadowOffset = CGSizeMake(0, 0)
            //cell.layer.shadowColor = UIColor.blackColor.CGColor
            //cell.layer.shadowOpacity = 0.23
            cell.layer.shadowRadius = 10
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            cell.contentView.layer.masksToBounds = true
            cell.layer.cornerRadius = 25
            cell.layer.masksToBounds = true
            
//            cell.imageView?.image = UIImage(named: self.imageNames[index])
            setImage(imageView: cell.imageView!, imageUrl: slider[index].v_slider_mobile_image_path)
//            debugPrint("image:", slider[index].v_slider_mobile_image_path)
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
           // cell.imageView?.layer.cornerRadius = 12.0
           // cell.imageView?.layer.masksToBounds = true
            //cell.imageView?.layer.cornerRadius = cell.imageView?.frame.size.width ?? 200 / 2

            //cell.imageView?.clipsToBounds = true
            cell.textLabel?.text = String(slider[index].v_title)+"\n"+String(slider[index].t_description ?? "")
            return cell
        }
        
       
    // MARK:- FSPagerView Delegate
        
        func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
            pagerView.deselectItem(at: index, animated: true)
            pagerView.scrollToItem(at: index, animated: true)
        }
        
        func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
            self.pageControl.currentPage = targetIndex
        }
        
        func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
            self.pageControl.currentPage = pagerView.currentIndex
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
    @IBAction func menu(_ sender:CustomButton){
        self.navigationController?.revealViewController()?.revealSideMenu()
}
    @IBAction func filterAction(_ sender:UIButton){
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let vc:FilterVC = storyboard.instantiateViewController(identifier: "FilterVC")
        self.navigationController?.present(vc, animated: true)
    }
    @IBAction func cartAction(_ sender:UIButton){
//        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CartVC") as! UINavigationController
//        navigationController?.pushViewController(vc, animated: true)
        view.insertSubview(vc.view, at: 4)
        addChild(vc)
        vc.didMove(toParent: self)
//        let vc:CartVC = storyboard.instantiateViewController(identifier: "CartVC")
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func viewAllAction(_ sender:UIButton){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CourseVC") as! UINavigationController
        view.insertSubview(vc.view, at: 4)
        addChild(vc)
        vc.didMove(toParent: self)
    }
    

class BadgedButtonItem: UIButton {

    public func setBadge(with value: Int) {
        self.badgeValue = value
    }

     var badgeValue: Int? {
        didSet {
            if let value = badgeValue,
                value > 0 {
                lblBadge.isHidden = false
                lblBadge.text = "\(value)"
            } else {
                lblBadge.isHidden = true
            }
        }
    }

    var tapAction: (() -> Void)?

    private let filterBtn = UIButton()
    private let lblBadge = UILabel()

//    override init() {
//        super.init()
//        setup()
//    }

//    init(with image: UIImage?) {
//        super.init()
//        setup(image: image)
//    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup(image: UIImage? = nil) {

        self.filterBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.filterBtn.adjustsImageWhenHighlighted = false
        self.filterBtn.setImage(image, for: .normal)
        self.filterBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        self.lblBadge.frame = CGRect(x: 20, y: 0, width: 15, height: 15)
        self.lblBadge.backgroundColor = .red
        self.lblBadge.clipsToBounds = true
        self.lblBadge.layer.cornerRadius = 7
        self.lblBadge.textColor = UIColor.white
        self.lblBadge.font = UIFont.systemFont(ofSize: 10)
        self.lblBadge.textAlignment = .center
        self.lblBadge.isHidden = true
        self.lblBadge.minimumScaleFactor = 0.1
        self.lblBadge.adjustsFontSizeToFitWidth = true
        self.filterBtn.addSubview(lblBadge)
//        self.customView = filterBtn
    }

    @objc func buttonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:SignInVC = storyboard.instantiateViewController(identifier: "SignInVC")
        UIPresentationController(presentedViewController: vc, presenting: vc)
    }
    
    
    
    }
    
    
    
  
    
    
    

}


/*
extension UIBarButtonItem {
  func setBadge(with value: Int) {
    guard let lblBadge = customView?.viewWithTag(100) as? UILabel else { return }
    if value > 0 {
      lblBadge.isHidden = false
      lblBadge.text = "\(value)"
    } else {
      //lblBadge.isHidden = true
    }
  }
  
  func setup(image: UIImage? = nil) {
    customView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    let lblBadge = UILabel()
    lblBadge.frame = CGRect(x: 20, y: 0, width: 15, height: 15)
    lblBadge.backgroundColor = .red
    lblBadge.tag = 100
    lblBadge.clipsToBounds = true
    lblBadge.layer.cornerRadius = 7
    lblBadge.textColor = UIColor.white
    lblBadge.font = UIFont.systemFont(ofSize: 10)
    lblBadge.textAlignment = .center
    lblBadge.isHidden = true
    lblBadge.minimumScaleFactor = 0.1
    lblBadge.adjustsFontSizeToFitWidth = true
    customView?.addSubview(lblBadge)
  }
}
*/
extension UINavigationBar
{
    /// Applies a background gradient with the given colors
    func applyNavigationGradient( colors : [UIColor]) {
        var frameAndStatusBar: CGRect = self.bounds
        frameAndStatusBar.size.height += 20 // add 20 to account for the status bar
        
        setBackgroundImage(UINavigationBar.gradient(size: frameAndStatusBar.size, colors: colors), for: .default)
    }
    
    /// Creates a gradient image with the given settings
    static func gradient(size : CGSize, colors : [UIColor]) -> UIImage?
    {
        // Turn the colors into CGColors
        let cgcolors = colors.map { $0.cgColor }
        
        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        // If no context was retrieved, then it failed
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // From now on, the context gets ended if any return happens
        defer { UIGraphicsEndImageContext() }
        
        // Create the Coregraphics gradient
        var locations : [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        
        // Draw the gradient
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])
        
        // Generate the image (the defer takes care of closing the context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
