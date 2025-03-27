//
//  HomeTabViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 03/03/25.
//

import UIKit

class HomeTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    private func filterSpecialization(by specialization: String) -> [Doctor] {
        return doctorArray.filter { $0.specialization == specialization }
    }
 
    @IBAction func viewAllAppointments(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentViewController") as! AppointmentViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func searchBarButton(_ sender: UIButton) {
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
        vc.buttonTappedArray = doctorArray
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func neurologistBtn(_ sender: UIButton) {
        let doctorType = filterSpecialization(by: "Cardiologist")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
            vc.buttonTappedArray = doctorType
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func blood(_ sender: UIButton) {
        let doctorType = filterSpecialization(by: "Hematologist")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
            vc.buttonTappedArray = doctorType
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func nose(_ sender: UIButton) {
        let doctorType = filterSpecialization(by: "Surgeon")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
            vc.buttonTappedArray = doctorType
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func cardiologist(_ sender: UIButton) {
        let doctorType = filterSpecialization(by: "Cardiologist")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
            vc.buttonTappedArray = doctorType
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func head(_ sender: UIButton) {
        let doctorType = filterSpecialization(by: "Psychiatrist")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
            vc.buttonTappedArray = doctorType
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func eye(_ sender: UIButton) {
        let doctorType = filterSpecialization(by: "Ophthalmologis")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
            vc.buttonTappedArray = doctorType
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func wheelchair(_ sender: UIButton) {
        let doctorType = filterSpecialization(by: "Physiotherapis")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
            vc.buttonTappedArray = doctorType
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func ear(_ sender: UIButton) {
        let doctorType = filterSpecialization(by: "ENT")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
            vc.buttonTappedArray = doctorType
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func dentistBtn(_ sender: UIButton) {
    let doctorType = filterSpecialization(by: "Dentist")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController") as! DoctorsViewController
        vc.buttonTappedArray = doctorType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
