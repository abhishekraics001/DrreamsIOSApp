//
//  CountryListCell.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 05/01/23.
//

import UIKit

class CountryListCell: UITableViewCell {

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var countryName:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configurecell(data: Countries){
        countryName.text = data.v_name
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
