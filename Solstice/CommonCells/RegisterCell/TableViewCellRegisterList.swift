//
//  TableViewCellRegisterList.swift
//  Solstice
//
//  Created by iMac on 11/04/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import UIKit

class TableViewCellRegisterList: UITableViewCell {

    @IBOutlet weak var iconImageCell: UIImageView!
    @IBOutlet weak var starImageCell: UIImageView!
    @IBOutlet weak var nameCell: UILabel!
    @IBOutlet weak var companyNameCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var identifier : String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
