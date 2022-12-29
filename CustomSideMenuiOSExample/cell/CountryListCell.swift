//
//  CountryListCell.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 18/12/22.
//

import UIKit

class CountryListCell: UITableViewCell {
    @IBOutlet weak var countryName:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configurecell(data: Countries){
        countryName.text = data.v_name
        
    }

}
