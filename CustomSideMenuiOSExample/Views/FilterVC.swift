//
//  FilterVC.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 21/12/22.
//

import UIKit

class FilterVC: UIViewController{
    //Content Type
    @IBOutlet weak var contentTypeAllBtn:CustomButton!
    @IBOutlet weak var contentTypeVideoBtn:CustomButton!
    @IBOutlet weak var contentTypePDFBtn:CustomButton!
    var contentType = ""
    //Certificate
    @IBOutlet weak var certificateAllBtn:CustomButton!
    @IBOutlet weak var certificateYesBtn:CustomButton!
    @IBOutlet weak var certificateNoBtn:CustomButton!
    var certificate = ""
    //Course Access
    @IBOutlet weak var accessAllBtn:CustomButton!
    @IBOutlet weak var accessLimitedBtn:CustomButton!
    @IBOutlet weak var accessUnlimitedBtn:CustomButton!
    var courseAccess = ""
    //Course Type
    @IBOutlet weak var courseTypeAllBtn:CustomButton!
    @IBOutlet weak var courseTypeFreeBtn:CustomButton!
    @IBOutlet weak var courseTypePaidBtn:CustomButton!
    var courseType = ""
    //Featured Courses
    @IBOutlet weak var featuredAllBtn:CustomButton!
    @IBOutlet weak var featuredYesBtn:CustomButton!
    @IBOutlet weak var featuredNoBtn:CustomButton!
    var featuredCourses = ""
    //Course Duration
    @IBOutlet weak var durationAllBtn:CustomButton!
    @IBOutlet weak var duration6monthBtn:CustomButton!
    @IBOutlet weak var duration3yearBtn:CustomButton!
    @IBOutlet weak var duration2yearBtn:CustomButton!
    @IBOutlet weak var duration1yearBtn:CustomButton!
    var duration = ""
    //Categories
    @IBOutlet weak var radiologyBtn:CustomButton!
    var radiologyBool = false
    var radiology = ""
    //Badge Type
    @IBOutlet weak var badgeBstSellerBtn:CustomButton!
    @IBOutlet weak var badgeNewBtn:CustomButton!
    @IBOutlet weak var badgeTrendingBtn:CustomButton!
    var bestSellerBool = false
    var bestSeller = ""
    var newBool = false
    var new = ""
    var trendingBool = false
    var trending = ""
    
    var loaderview = LoaderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func backAction(_ sender: UIButton){
        dismiss(animated: true)
    }
    @IBAction func applyAction(_ sender: UIButton){
        self.loaderview.showLoader(view: self.view)
        dismiss(animated: true)
        self.loaderview.hideLoader(view: self.view)
//        var contentType = ""
//        var certificate = ""
//        var courseAccess = ""
//        var courseType = ""
//        var featuredCourses = ""
//        var duration = ""
//        var radiology = ""
//        var bestSeller = ""
//        var new = ""
//        var trending = ""
    }
    @IBAction func selectContentTypeAction(sender: CustomButton){
        switch(sender) {
        case contentTypeAllBtn:
            contentTypeAllBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            contentTypeAllBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            contentTypeVideoBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            contentTypeVideoBtn.tintColor = .lightGray
            contentTypePDFBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            contentTypePDFBtn.tintColor = .lightGray
            contentType = ""
            
            break
        case contentTypeVideoBtn:
            contentTypeAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            contentTypeAllBtn.tintColor = .lightGray
            contentTypeVideoBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            contentTypeVideoBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            contentTypePDFBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            contentTypePDFBtn.tintColor = .lightGray
            contentType = "Video"
            break
        case contentTypePDFBtn:
            contentTypeAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            contentTypeAllBtn.tintColor = .lightGray
            contentTypeVideoBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            contentTypeVideoBtn.tintColor = .lightGray
            contentTypePDFBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            contentTypePDFBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            contentType = "PDF"
            break
        default:
            break
        }
    }
    @IBAction func certificateAction(sender: CustomButton){
        switch(sender) {
        case certificateAllBtn:
            certificateAllBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            certificateAllBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            certificateYesBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            certificateYesBtn.tintColor = .lightGray
            certificateNoBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            certificateNoBtn.tintColor = .lightGray
            certificate = ""
            
            break
        case certificateYesBtn:
            certificateAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            certificateAllBtn.tintColor = .lightGray
            certificateYesBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            certificateYesBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            certificateNoBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            certificateNoBtn.tintColor = .lightGray
            certificate = "Yes"
            break
        case certificateNoBtn:
            certificateAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            certificateAllBtn.tintColor = .lightGray
            certificateYesBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            certificateYesBtn.tintColor = .lightGray
            certificateNoBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            certificateNoBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            certificate = "No"
            break
        default:
            break
        }
    }
    @IBAction func courseAccessAction(sender: CustomButton){
        switch(sender) {
        case accessAllBtn:
            accessAllBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            accessAllBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            accessLimitedBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            accessLimitedBtn.tintColor = .lightGray
            accessUnlimitedBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            accessUnlimitedBtn.tintColor = .lightGray
            courseAccess = ""
            
            break
        case accessLimitedBtn:
            accessAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            accessAllBtn.tintColor = .lightGray
            accessLimitedBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            accessLimitedBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            accessUnlimitedBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            accessUnlimitedBtn.tintColor = .lightGray
            courseAccess = "Limited"
            break
        case accessUnlimitedBtn:
            accessAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            accessAllBtn.tintColor = .lightGray
            accessLimitedBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            accessLimitedBtn.tintColor = .lightGray
            accessUnlimitedBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            accessUnlimitedBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            courseAccess = "Unlimited"
            break
        default:
            break
        }
    }
    @IBAction func courseTypeAction(sender: CustomButton){
        switch(sender) {
        case courseTypeAllBtn:
            courseTypeAllBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            courseTypeAllBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            courseTypeFreeBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            courseTypeFreeBtn.tintColor = .lightGray
            courseTypePaidBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            courseTypePaidBtn.tintColor = .lightGray
            courseType = ""
            
            break
        case courseTypeFreeBtn:
            courseTypeAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            courseTypeAllBtn.tintColor = .lightGray
            courseTypeFreeBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            courseTypeFreeBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            courseTypePaidBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            courseTypePaidBtn.tintColor = .lightGray
            courseType = "Free"
            break
        case courseTypePaidBtn:
            courseTypeAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            courseTypeAllBtn.tintColor = .lightGray
            courseTypeFreeBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            courseTypeFreeBtn.tintColor = .lightGray
            courseTypePaidBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            courseTypePaidBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            courseType = "Paid"
            break
        default:
            break
        }
    }
    @IBAction func featuredCoursesAction(sender: CustomButton){
        switch(sender) {
        case featuredAllBtn:
            featuredAllBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            featuredAllBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            featuredYesBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            featuredYesBtn.tintColor = .lightGray
            featuredNoBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            featuredNoBtn.tintColor = .lightGray
            featuredCourses = ""
            
            break
        case featuredYesBtn:
            featuredAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            featuredAllBtn.tintColor = .lightGray
            featuredYesBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            featuredYesBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            featuredNoBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            featuredNoBtn.tintColor = .lightGray
            featuredCourses = "Yes"
            break
        case featuredNoBtn:
            featuredAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            featuredAllBtn.tintColor = .lightGray
            featuredYesBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            featuredYesBtn.tintColor = .lightGray
            featuredNoBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            featuredNoBtn.tintColor = #colorLiteral(red: 0.0182696674, green: 0.3785366714, blue: 0.417830646, alpha: 1)
            featuredCourses = "No"
            break
        default:
            break
        }
    }
    @IBAction func courseDurationAction(sender: CustomButton){
        switch(sender) {
        case durationAllBtn:
            durationAllBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            duration6monthBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration3yearBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration2yearBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration1yearBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration = ""
            
            break
        case duration6monthBtn:
            durationAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration6monthBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            duration3yearBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration2yearBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration1yearBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration = "6month"
            break
        case duration3yearBtn:
            durationAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration6monthBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration3yearBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            duration2yearBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration1yearBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration = "3year"
            break
        case duration2yearBtn:
            durationAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration6monthBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration3yearBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration2yearBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            duration1yearBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration = "2year"
            break
        case duration1yearBtn:
            durationAllBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration6monthBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration3yearBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration2yearBtn.setImage(UIImage(systemName:"circle"), for: .normal)
            duration1yearBtn.setImage(UIImage(systemName:"circle.inset.filled"), for: .normal)
            duration = "1year"
            break
        default:
            break
        }
    }
    @IBAction private func checkCategoriesAction(_ sender: CustomButton) {
        radiologyBtn.setImage(UIImage(systemName:"square"), for: .normal)
        if radiologyBool{
            radiologyBool = false
            radiology = ""
            radiologyBtn.setImage(UIImage(systemName:"square"), for: .normal)
        }
        else{
            radiologyBool = true
            radiology = "1"
            radiologyBtn.setImage(UIImage(systemName:"checkmark.square"), for: .normal)
        }
    }
    @IBAction private func checkBestSellerAction(_ sender: CustomButton) {
        badgeBstSellerBtn.setImage(UIImage(systemName:"square"), for: .normal)
        if bestSellerBool{
            bestSellerBool = false
            bestSeller = ""
            badgeBstSellerBtn.setImage(UIImage(systemName:"square"), for: .normal)
        }
        else{
            bestSellerBool = true
            bestSeller = "1"
            badgeBstSellerBtn.setImage(UIImage(systemName:"checkmark.square"), for: .normal)
        }
    }
    @IBAction private func checkNewAction(_ sender: CustomButton) {
        badgeNewBtn.setImage(UIImage(systemName:"square"), for: .normal)
        if newBool{
            newBool = false
            new = ""
            badgeNewBtn.setImage(UIImage(systemName:"square"), for: .normal)
        }
        else{
            newBool = true
            new = "2"
            badgeNewBtn.setImage(UIImage(systemName:"checkmark.square"), for: .normal)
        }
    }
    @IBAction private func checkTrendingAction(_ sender: CustomButton) {
        badgeTrendingBtn.setImage(UIImage(systemName:"square"), for: .normal)
        if trendingBool{
            trendingBool = false
            trending = ""
            badgeTrendingBtn.setImage(UIImage(systemName:"square"), for: .normal)
        }
        else{
            trendingBool = true
            trending = "3"
            badgeTrendingBtn.setImage(UIImage(systemName:"checkmark.square"), for: .normal)
        }
    }
}
