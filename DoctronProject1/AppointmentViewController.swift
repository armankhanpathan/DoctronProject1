//
//  AppointmentViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 27/02/25.
//

import UIKit

class AppointmentViewController: UIViewController {

    @IBOutlet weak var upcomingBtn: UIButton!
    @IBOutlet weak var completedBtn: UIButton!
    @IBOutlet weak var cancelledBtn: UIButton!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var filteredArray: [AppointmentBookingDetail] = []
  //  var appointmentConfirmData: AppointmentBookingDetail?
    
//    var patientName: String = ""
//    var patientAge: Int = 0
//    var patientGender: String = ""

    override func viewWillAppear(_ animated: Bool) {
      //  fetchDataFromLocal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register the table view cell
        let nib = UINib(nibName: "AppointmentTableViewCell", bundle: nil)
        tableViewOutlet.register(nib, forCellReuseIdentifier: "AppointmentTableViewCell")
        
        // Setup TableView
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        
        fetchDataFromLocal()
    }
    
    private func fetchDataFromLocal() {
        let fetchUserData = UserDefaults.standard.data(forKey: "bookingData")
        
        if fetchUserData != nil {
            let jsonData = fetchUserData!
            
            let decoder = JSONDecoder()
            
            do {
                let model = try decoder.decode([AppointmentBookingDetail].self, from: jsonData)
                print(model)
                bookingList = model
                if !bookingList.isEmpty {
                    filteredArray = bookingList.filter { $0.isUpcoming }
                    tableViewOutlet.reloadData()
                    
                    upcomingBtn.backgroundColor = .myPurple
                    upcomingBtn.setTitleColor(.white, for: .normal)
                }
            } catch {
                print(error.localizedDescription)
            }
        
        } else {
            if !bookingList.isEmpty {
                filteredArray = bookingList.filter { $0.isUpcoming }
                tableViewOutlet.reloadData()
                
                upcomingBtn.backgroundColor = .myPurple
                upcomingBtn.setTitleColor(.white, for: .normal)
            }
        }
    }

    // Button actions to filter doctor appointments
    @IBAction func upcomingFilterBtn(_ sender: UIButton) {
    
        filteredArray = bookingList.filter { $0.isUpcoming }
        tableViewOutlet.reloadData()
        upcomingBtn.backgroundColor = .myPurple
        upcomingBtn.setTitleColor(.white, for: .normal)
        
        completedBtn.backgroundColor = .white
       cancelledBtn.backgroundColor = .white
    }
    
    @IBAction func completedFilterBtn(_ sender: UIButton) {
        filteredArray = bookingList.filter { $0.isCompleted }
        tableViewOutlet.reloadData()
        completedBtn.backgroundColor = .myPurple
        completedBtn.setTitleColor(.white, for: .normal)
        
        upcomingBtn.backgroundColor = .white
        cancelledBtn.backgroundColor = .white
    }
    
    @IBAction func cancelledFilterBtn(_ sender: UIButton) {
        filteredArray = bookingList.filter { $0.isCancelled }
        tableViewOutlet.reloadData()
        cancelledBtn.backgroundColor = .myPurple
        
        upcomingBtn.backgroundColor = .white
        completedBtn.backgroundColor = .white
    }
    
    // Cancel button action for a specific doctor
    @objc func cancelBtn(_ sender: UIButton) {
        
        let indexNum = sender.tag
        let selectedAppointment = filteredArray[indexNum]
        let selectedAppointmentID = selectedAppointment.id
        
        let filteredIndex = doctorArray.firstIndex {
            $0.id == selectedAppointmentID
        }
        
        bookingList[filteredIndex!].isUpcoming = false
        bookingList[filteredIndex!].isCancelled = true
        
        filteredArray = bookingList.filter { $0.isUpcoming }
        tableViewOutlet.reloadData()
    }
    
    @objc func rescheduleBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
        vc.rescheduleDetail = filteredArray[sender.tag]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AppointmentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorProfileViewController") as? DoctorProfileViewController {
            let doctor = filteredArray[indexPath.row]
            vc.isNewBooking = false
            vc.history = doctor
          
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell", for: indexPath) as! AppointmentTableViewCell
        
        let doctor = filteredArray[indexPath.row]
        cell.cellNameLabel.text = doctor.doctorDetail?.name
        cell.cellspecializationLabel.text = doctor.doctorDetail?.specialization
        cell.cancelBtn.tag = indexPath.row
        cell.cancelBtn.addTarget(self, action: #selector(cancelBtn), for: .touchUpInside)
        cell.rescheduleBtn.tag = indexPath.row
        cell.rescheduleBtn.addTarget(self, action: #selector(rescheduleBtn), for: .touchUpInside)
        cell.cellTimeLabel.text = doctor.bookingdate
        cell.cellPatientLabel.text = doctor.patientName
        
        
        
        if doctor.isCancelled == true {
            cell.cancelBtn.isHidden = true
        } else if doctor.isCompleted == true {
            cell.rescheduleBtn.isHidden = true
            cell.cancelBtn.isHidden = true
        } else {
            
        }
         return cell
    }
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170 // Set the height you want for the cell
    } 
