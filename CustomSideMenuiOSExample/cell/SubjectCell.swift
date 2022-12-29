//
//  SubjectCell.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 16/12/22.
//

import UIKit

class SubjectCell: UITableViewCell {
    @IBOutlet weak var view:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.mainShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
