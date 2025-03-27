//
//  DoctorProfileViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 07/03/25.
//

import UIKit

protocol DoctorProfileViewControllerDelegate: AnyObject {
    func reloadTableData()
}

class DoctorProfileViewController: UIViewController {
    
    @IBOutlet weak var detailedImage: UIImageView!
    @IBOutlet weak var detailedName: UILabel!
    @IBOutlet weak var detailedSpecialization: UILabel!
    @IBOutlet weak var detailedRating: UILabel!
    @IBOutlet weak var bookingBtnOutlet: UIButton!
    
    var history: AppointmentBookingDetail?
    var doctorData: Doctor?
    var isNewBooking = false
    
    weak var delegate: DoctorProfileViewControllerDelegate? // Delegate property
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Set the button title based on whether it's a new booking or not
        if isNewBooking {
            bookingBtnOutlet.setTitle("Book Appointment", for: .normal)
            detailedName.text = doctorData?.name
            detailedImage.image = UIImage(named: doctorData?.image ?? "" )
            detailedSpecialization.text = doctorData?.specialization
            detailedRating.text = doctorData?.ratings ?? ""
        } else {
            bookingBtnOutlet.setTitle("Mark as completed", for: .normal)
            detailedName.text = history?.doctorDetail?.name
            detailedImage.image = UIImage(named: history?.doctorDetail!.image ?? "" ) // getting error here
            detailedSpecialization.text = history?.doctorDetail?.specialization
            detailedRating.text = history?.doctorDetail?.ratings ?? ""
        }
    }
    
    @IBAction func bookAppointmentBtn(_ sender: UIButton) {
        if isNewBooking {
            // Navigate to the BookingViewController
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingViewController") as? BookingViewController {
                vc.doctorDetail = doctorData
                self.navigationController?.pushViewController(vc, animated: true)
               // vc.modalPresentationStyle = .fullScreen
                //self.present(vc, animated: true, completion: nil)
                
            }
        } else {
            // for update appointment
            // Safely find the index of history in the booking list
            
            if let historyIndex = bookingList.firstIndex(where: { $0.id == history?.id }) {
                history?.isCompleted = true
                history?.isUpcoming = false
                bookingList[historyIndex] = history!
                
            }
            let jsonEncoder = JSONEncoder()
            do {
                let jsonResultData = try jsonEncoder.encode(bookingList)
                UserDefaults.standard.setValue(jsonResultData, forKey: "bookingData")
            } catch {
                print("Error encoding data: \(error)")
            }
            
            if let appointment = history {
                            delegate?.reloadTableData() // Reload table data in the first view controller
                        }
            
            navigationController?.popViewController(animated: true)
            
        }
    }
}
