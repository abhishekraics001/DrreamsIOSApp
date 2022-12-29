//
//  CourseListTableViewCell.swift
//  Drreams
//
//  Created by sunil kumar on 09/12/22.
//

import UIKit
import Nuke

class CourseListTableViewCell: UITableViewCell {

    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var uixx: UIView!
    @IBOutlet weak var uscc: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var courseValidity: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var statusbg: UIView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var imagee: UIImageView!
    @IBOutlet weak var modules: UILabel!
    @IBOutlet weak var videos: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        uixx.mainShadow()
        uscc.innerShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data: Courses){
        title.text = String(data.v_name)
        subTitle.text = String(data.t_short_description)
        setImage(imageView: imagee, imageUrl: String(data.v_course_image_path))
        courseValidity.text = "Course valid for "+String(data.i_course_access_days)+" Days"
        price.text = String(data.d_original_amount)
        statusLbl.text = String(data.course_badge_type.v_name)
        modules.text = String(data.i_subject_count)+" Modules"
        videos.text = String(data.i_content_count)
        if statusLbl.text == "Trending"{
            statusbg.backgroundColor = UIColor(red: 0.20, green: 0.50, blue: 1.00, alpha: 1.00)
        }else{
            statusbg.backgroundColor = UIColor(red: 1.00, green: 0.20, blue: 0.82, alpha: 1.00)
        }
    }
    
    func makeRoundedAndShadowed(view: UIView) {
        let shadowLayer = CAShapeLayer()
        
        view.layer.cornerRadius = 20
        shadowLayer.path = UIBezierPath(roundedRect: view.bounds,
                                        cornerRadius: view.layer.cornerRadius).cgPath
        shadowLayer.fillColor = view.backgroundColor?.cgColor
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        shadowLayer.shadowOpacity = 0.70
        shadowLayer.shadowRadius = 20.0
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
    
}
