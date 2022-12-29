//
//  IntroVC.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 25/12/22.
//

import UIKit
import FSPagerView
import Nuke

class IntroVC: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {
    @IBOutlet weak var letsGo:CustomButton!
    @IBOutlet weak var slideBtn:CustomButton!
    @IBOutlet weak var pagerTitle:UILabel!
    @IBOutlet weak var pagerDesc:UILabel!
    
    var loaderView = LoaderView()
    var slider = [Slider]()
    var getData = StartUpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letsGo.dropShadow(color: .darkGray, offSet: .init(width: 2, height: 2))
        
        self.view.addSubview(pageControl)
        self.pageControl.numberOfPages = self.slider.count
        self.pageControl.contentHorizontalAlignment = .center
        self.pageControl.contentVerticalAlignment = .bottom
        self.pageControl.contentMode = .bottom
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 420, bottom: 100, right: 20)
        self.pageControl.setStrokeColor(.white, for: .normal)
        self.pageControl.setStrokeColor(.orange, for: .selected)
        self.pageControl.setFillColor(.white, for: .normal)
        self.pageControl.setFillColor(.orange, for: .selected)
        letsGo.isHidden = true
        getStartUp()
        pagerView.backgroundView?.largeContentImage = UIImage(named: "StartUpBg")
        pagerView.layer.repeatCount = 0
        
        
    }
    
    private func getStartUp(){
        self.loaderView.showLoader(view: self.view)
        
        let deviceToken = UIDevice.current.identifierForVendor!.uuidString
        Constants.deviceToken = deviceToken
        
        let parameters = ""
        let webService = WebService()
        let viewModel = HomeSliderViewModel(service: webService, parameters: parameters)
        
        viewModel.StartUpApi(parameters: parameters) { data in
            self.loaderView.hideLoader(view: self.view)
            
            if let startUpList = viewModel.modelDataForStartUp.data{
                debugPrint("viewModel", viewModel)
                if let slider = startUpList.app_startup_screen{
                    
                    self.getData = StartUpModel()
                    self.getData = startUpList
                    self.slider = slider
                    debugPrint("count",self.slider.count)
                    self.pagerView.reloadData()
                    
                }
            }
        }
    }
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            //self.pagerView.itemSize = FSPagerView.automaticSize
            self.pagerView.itemSize = CGSize(width: pagerView.frame.width,height: pagerView.frame.height)
//            pagerView.itemSize = CGSize(width: pagerView.frame.width, height: 180)
            self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
//            self.pagerView.automaticSlidingInterval = 2.0
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
//            cell.layer.shadowRadius = 10
//            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            cell.contentView.layer.masksToBounds = true
//            cell.layer.cornerRadius = 25
            cell.layer.masksToBounds = true
            
//            cell.imageView?.image = UIImage(named: self.imageNames[index])
            setImage(imageView: cell.imageView!, imageUrl: slider[index].v_app_startup_screens_image_path ?? "")
//            debugPrint("image:", slider[index].v_slider_mobile_image_path)
//            cell.imageView?.contentMode = .scaleAspectFill
//            cell.imageView?.clipsToBounds = true
            pagerTitle.text = slider[index].v_title ?? ""
            pagerDesc.text = slider[index].t_description ?? ""
            cell.imageView?.sizeToFit()
            // cell.imageView?.layer.cornerRadius = 12.0
           // cell.imageView?.layer.masksToBounds = true
            //cell.imageView?.layer.cornerRadius = cell.imageView?.frame.size.width ?? 200 / 2
            //cell.imageView?.clipsToBounds = true
//            cell.textLabel?.text = slider[index].v_title ?? ""
//            cell.textLabel?.widthAnchor.constraint(equalToConstant: 200)
//
//            cell.textLabel?.bottomAnchor.constraint(equalTo: 200).isActive = true
            if index == 1 {
                letsGo.isHidden = false
                slideBtn.isHidden = true
            }else{
                letsGo.isHidden = true
            }
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
                success: .scaleAspectFit,
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
    @IBAction func slide(_ : CustomButton){
        pagerView.isScrollEnabled = true
        pagerView.accessibilityScroll(.next)
        pagerView.scrollToItem(at: 1, animated: true)
    }
    @IBAction func go(_ : CustomButton){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc:HomeViewController = sb.instantiateViewController(withIdentifier: "HomeNavID") as! HomeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
