//
//  PaymentViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 11/03/25.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientAgeLabel: UILabel!
    @IBOutlet weak var patientGenderLabel: UILabel!
    @IBOutlet weak var appointmentDateLabel: UILabel!
    
    var appointmentRequest: AppointmentBookingDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display the passed data
        patientNameLabel.text = appointmentRequest?.patientName
        patientAgeLabel.text = String(appointmentRequest!.patientsAge)
        patientGenderLabel.text = appointmentRequest?.patientGender
        appointmentDateLabel.text = appointmentRequest?.bookingdate
    }
    
    // Function for confirming the appointment
    @IBAction func confirmAppointment(_ sender: UIButton) {
        
        let reshceduleIndex = bookingList.firstIndex {
            $0.id == appointmentRequest?.id
        }
        
        if reshceduleIndex != nil {
            bookingList[reshceduleIndex!] = appointmentRequest!
        } else {
            bookingList.append(appointmentRequest!)
        }
        let jsonEncoder = JSONEncoder()
        do {
            let jsonResultData = try jsonEncoder.encode(bookingList)
            UserDefaults.standard.setValue(jsonResultData, forKey: "bookingData")
        } catch {
            print("Error encoding data: \(error)")
        }
        
       
        // Proceed to the next screen or handle the confirmation logic here
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppotmentConfirmedViewController") as! AppotmentConfirmedViewController
       // vc.appointmentData = appointmentRequest
         vc.modalPresentationStyle = .fullScreen
         self.present(vc, animated: true, completion: nil)
       // self.navigationController?.pushViewController(vc, animated: true)
        
        print("Appointment Confirmed!")
        // You can push to the next screen or perform other actions
        
    }
}
