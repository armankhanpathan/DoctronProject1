//
//  DoctorsViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 07/03/25.
//

import UIKit

class DoctorsViewController: UIViewController {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var buttonTappedArray = [Doctor]()
    private var filteredDoctors = [Doctor]()
    var isSearching = false
    
    // Search controller
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let nib = UINib(nibName: "DoctorTableViewCell", bundle: nil)
        tableViewOutlet.register(nib, forCellReuseIdentifier: "doctorCell")
        
        // Setup TableView
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        
        // Setup Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a doctor"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    @objc func makeAppointment(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DoctorsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DoctorProfileViewController") as? DoctorProfileViewController {
            if filteredDoctors.isEmpty {
                let doctor = buttonTappedArray[indexPath.row]
             
                vc.doctorData = doctor
            } else {
                let doctor = filteredDoctors[indexPath.row]
                vc.history?.doctorDetail = doctor
            }
            
            vc.isNewBooking = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredDoctors.count
        }
        return buttonTappedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let doctorCell = tableView.dequeueReusableCell(withIdentifier: "doctorCell", for: indexPath) as! DoctorTableViewCell
        
        let doctor: Doctor
        if isSearching {
            doctor = filteredDoctors[indexPath.row]
        } else {
            doctor = buttonTappedArray[indexPath.row]
        }
        
        doctorCell.doctorNameLabel.text = doctor.name
        doctorCell.doctorSpecialtyLabel.text = doctor.specialization
        doctorCell.doctorImageView.image = UIImage(named: doctor.image)
        doctorCell.doctorExperienceLabel.text = "Experience: \(doctor.experience ?? 0) years"
        doctorCell.doctorReviewsLabel.text = "Patients: \(doctor.patients)"
        doctorCell.makeAppointment.addTarget(self, action: #selector(makeAppointment), for: .touchUpInside)
        
        return doctorCell
    }
   
}

extension DoctorsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        if searchText.isEmpty {
            isSearching = false
            filteredDoctors.removeAll()
        } else {
            isSearching = true
            filteredDoctors = buttonTappedArray.filter { doctor in
                doctor.name.lowercased().contains(searchText.lowercased())
            }
        }

        tableViewOutlet.reloadData()
    }
}
