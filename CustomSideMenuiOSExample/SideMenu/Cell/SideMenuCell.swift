//
//  SideMenuCell.swift
//  CustomSideMenuiOSExample
//
//  Created by John Codeos on 2/7/21.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var saparator: UIView!
    @IBOutlet weak var communicate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Saparator
        communicate.text = "Communicate"
        self.saparator.isHidden = true
        self.communicate.isHidden = true
        // Background
        self.backgroundColor = .clear
        
        // Icon
        self.iconImageView.tintColor = .darkGray
        
        // Title
        self.titleLabel.textColor = .darkGray
    }
    
}
