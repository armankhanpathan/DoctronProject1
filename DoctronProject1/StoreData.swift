//
//  StoreData.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 27/02/25.
//
import Foundation

// A global variable to store user data. This can be updated when a user logs in.
var storeUserData: UserDetail?
var storeAppointmentData: AppointmentBookingDetail?

struct Doctor: Codable {
    var id: Int
    var name: String
    var specialization: String
    var experience: Int?
    var patients: Int
    var image: String
    var ratings: String?
}

struct UserDetail: Codable {
    var id: Int
    var userName: String
    var userDOB: String
    var userGender: String
    let userEmail: String
    var userPassword: String
}

struct AppointmentBookingDetail: Codable {
    var id: Int
    var userContact: String
    let userEmail: String
    
    var isCompleted: Bool
    var isCancelled: Bool
    var isUpcoming: Bool
    var patientName: String
    var patientsAge: Int
    var patientGender: String
    var doctorDetail: Doctor?
    var bookingdate: String
}

import UIKit

let doctorArray: [Doctor] = [
    // Ophthalmologists
    Doctor(id: 1, name: "Dr. Alice Johnson", specialization: "Ophthalmologist", patients: 1200, image: "doctor"),
    Doctor(id: 2, name: "Dr. Bob Smith", specialization: "Ophthalmologist", patients: 1000, image: "doctor"),
    Doctor(id: 3, name: "Dr. Claire Brown", specialization: "Ophthalmologist", patients: 800, image: "doctor"),
    
    // Physiotherapists
    Doctor(id: 4, name: "Dr. Firdaus Pathan", specialization: "Physiotherapist", patients: 7860, image: "doctor"),
    Doctor(id: 5, name: "Dr. Emma Wilson", specialization: "Physiotherapist", patients: 300, image: "doctor"),
    Doctor(id: 6, name: "Dr. Fred Thomas", specialization: "Physiotherapist", patients: 900, image: "doctor"),
    
    // Cardiologists
    Doctor(id: 7, name: "Dr. George Martin", specialization: "Cardiologist", patients: 1500, image: "doctor"),
    Doctor(id: 8, name: "Dr. Hannah Clark", specialization: "Cardiologist", patients: 1600, image: "doctor"),
    Doctor(id: 9, name: "Dr. Ian Lewis", specialization: "Cardiologist", patients: 700, image: "doctor"),
    
    // Dentists
    Doctor(id: 10, name: "Dr. Ayman Pathan", specialization: "Dentist", patients: 7860, image: "doctor"),
    Doctor(id: 11, name: "Dr. Karen Davis", specialization: "Dentist", patients: 1100, image: "doctor"),
    Doctor(id: 12, name: "Dr. Laura Evans", specialization: "Dentist", patients: 300, image: "doctor"),
    
    // Psychiatrists
    Doctor(id: 13, name: "Dr. Michael Harris", specialization: "Psychiatrist", patients: 2000, image: "doctor"),
    Doctor(id: 14, name: "Dr. Natalie Robinson", specialization: "Psychiatrist", patients: 1000, image: "doctor"),
    Doctor(id: 15, name: "Dr. Olivia Walker", specialization: "Psychiatrist", patients: 400, image: "doctor"),
    
    // ENT Specialists
    Doctor(id: 16, name: "Dr. Peter Wright", specialization: "ENT", patients: 950, image: "doctor"),
    Doctor(id: 17, name: "Dr. Quinton King", specialization: "ENT", patients: 700, image: "doctor"),
    Doctor(id: 18, name: "Dr. Rachel Scott", specialization: "ENT", patients: 850, image: "doctor"),
    
    // Surgeons
    Doctor(id: 19, name: "Dr. Samuel Green", specialization: "Surgeon", patients: 1300, image: "doctor"),
    Doctor(id: 20, name: "Dr. Tiffany Adams", specialization: "Surgeon", patients: 1100, image: "doctor"),
    Doctor(id: 21, name: "Dr. Victor Hall", specialization: "Surgeon", patients: 600, image: "doctor"),
    
    // Hematologists
    Doctor(id: 22, name: "Dr. William White", specialization: "Hematologist", patients: 1800, image: "doctor"),
    Doctor(id: 23, name: "Dr. Xavier Young", specialization: "Hematologist", patients: 900, image: "doctor"),
    Doctor(id: 24, name: "Dr. Yvonne Martinez", specialization: "Hematologist", patients: 450, image: "doctor")
]

var bookingList: [AppointmentBookingDetail] = []
