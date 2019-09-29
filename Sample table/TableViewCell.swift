//
//  TableViewCell.swift
//  Dynamic table
//
//  Created by Ashok Reddy G on 28/09/19.
//  Copyright © 2019 Ashok Reddy G. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var label: UILabel!
    
    @IBOutlet var displayImageView: UIImageView!
    
    @IBOutlet var date: UILabel!
    @IBOutlet var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
