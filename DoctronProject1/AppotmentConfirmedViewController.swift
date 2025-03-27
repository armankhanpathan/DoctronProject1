//
//  AppotmentConfirmedViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 13/03/25.
//

import UIKit

class AppotmentConfirmedViewController: UIViewController {

    var appointmentData: AppointmentBookingDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToHomescreen(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        vc.isFromBooking = true
        //vc.appointmentConfirmData = appointmentData
        // self.navigationController?.pushViewController(vc, animated: true)
         vc.modalPresentationStyle = .fullScreen
         self.present(vc, animated: true, completion: nil)
    }
    
}


