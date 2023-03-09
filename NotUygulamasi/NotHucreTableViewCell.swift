//
//  NotHucreTableViewCell.swift
//  NotUygulamasi
//
//  Created by Abdüssamed Söğüt on 24.02.2023.
//

import UIKit

class NotHucreTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDersAdi: UILabel!
    
    @IBOutlet weak var labelNot1: UILabel!
    
    @IBOutlet weak var labelNot2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
