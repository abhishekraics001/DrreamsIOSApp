//
//  ViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by John Codeos on 2/§/21.
//

import UIKit
import FSPagerView


class HomeViewController: UIViewController, FSPagerViewDataSource,FSPagerViewDelegate, UITableViewDelegate, UITableViewDataSource {
  

    
   
    
  
    
    
    
    
 
    
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var rightNavBar: UIBarButtonItem!
    let btn = BadgedButtonItem(with: UIImage(systemName: "cart.fill")!)
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Menu Button Tint Color
        navigationController?.navigationBar.tintColor = .white

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        
        self.title = "Home"
        
       

        let searchImage  = UIImage(systemName: "house.fill")!
        let editButton   = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: "didTapEditButton:")
        
        //self.navigationItem.rightBarButtonItem = btn
        self.navigationItem.rightBarButtonItems = [editButton, btn ]
        self.btn.setBadge(with: 10)
        btn.tapAction = {
            //self.btn.setBadge(with: 1)
        }
        
        
        self.view.addSubview(pageControl)
        self.pageControl.numberOfPages = self.imageNames.count
        self.pageControl.contentHorizontalAlignment = .center
        self.pageControl.contentMode = .bottom
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        self.pageControl.contentInsets = UIEdgeInsets(top: 360, left: 420, bottom: 0, right: 20)
        self.pageControl.setStrokeColor(.green, for: .normal)
        self.pageControl.setStrokeColor(.yellow, for: .selected)
        self.pageControl.setFillColor(.gray, for: .normal)
        self.pageControl.setFillColor(.white, for: .selected)
        
        
        
        tableView.delegate = self
                tableView.dataSource = self
       
        // Register TableView Cell
        self.tableView.register(CourseListTableViewCell.nib, forCellReuseIdentifier: CourseListTableViewCell.identifier)

        // Update TableView with the data
        self.tableView.reloadData()
        
        
        getDataURL();
        
        

        
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
        return 200.0
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
   
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CourseListTableViewCell.identifier, for: indexPath) as? CourseListTableViewCell else { fatalError("xib doesn't exist") }
        
        return cell
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
            return self.imageNames.count
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
            
            cell.imageView?.image = UIImage(named: self.imageNames[index])
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
           // cell.imageView?.layer.cornerRadius = 12.0
           // cell.imageView?.layer.masksToBounds = true
            //cell.imageView?.layer.cornerRadius = cell.imageView?.frame.size.width ?? 200 / 2

            //cell.imageView?.clipsToBounds = true
            cell.textLabel?.text = index.description+index.description
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
        
      
    
}


class BadgedButtonItem: UIBarButtonItem {

    public func setBadge(with value: Int) {
        self.badgeValue = value
    }

    private var badgeValue: Int? {
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

    override init() {
        super.init()
        setup()
    }

    init(with image: UIImage?) {
        super.init()
        setup(image: image)
    }

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
        self.customView = filterBtn
    }

    @objc func buttonPressed() {
        if let action = tapAction {
            action()
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
