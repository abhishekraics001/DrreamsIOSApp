//
//  FaqCell.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 05/01/23.
//

import UIKit

class FaqCell: UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureFaq(with model: FAQ) {
        titleLabel.text = model.v_question
        if let isSelected = model.isSelected, isSelected == true {
            descLabel.text = model.t_answer
            self.dropButton.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        } else {
            self.dropButton.imageView?.transform = .identity
            descLabel.text = ""
        }
    }
}
