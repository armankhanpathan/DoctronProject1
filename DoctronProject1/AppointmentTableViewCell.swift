//
//  AppointmentTableViewCell.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 27/02/25.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellspecializationLabel: UILabel!
    @IBOutlet weak var cellPatientCountLabel: UILabel!
    @IBOutlet weak var cellRatingLabel: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var rescheduleBtn: UIButton!
    
    @IBOutlet weak var cellPatientLabel: UILabel!
    @IBOutlet weak var cellTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellImage.layer.cornerRadius = cellImage.frame.size.width / 2
        cellImage.clipsToBounds = true
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 
}
    

    



