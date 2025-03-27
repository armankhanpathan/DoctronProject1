//
//  DoctorTableViewCell.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 07/03/25.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var doctorSpecialtyLabel: UILabel!
    @IBOutlet weak var doctorExperienceLabel: UILabel!
    @IBOutlet weak var doctorRatingLabel: UIImageView! 
    @IBOutlet weak var doctorReviewsLabel: UILabel!
    @IBOutlet weak var makeAppointment: UIButton!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

}





