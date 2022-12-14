//
//  CourseListTableViewCell.swift
//  Drreams
//
//  Created by sunil kumar on 09/12/22.
//

import UIKit

class CourseListTableViewCell: UITableViewCell {

    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var uixx: UIView!
    
    @IBOutlet weak var uscc: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Background
        //self.backgroundColor = .clear
        
        
        //makeRoundedAndShadowed(view: uixx);
        uixx.mainShadow()
        uscc.innerShadow()
        
        
        
       // uixx.XX()
       // uscc.dropShadow22()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    
}
