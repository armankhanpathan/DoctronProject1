//
//  Appointment.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 13/03/25.
//

import Foundation

// Appointment.swift
class Appointment {
    var doctor: Doctor
    var appointmentTime: String
    
    init(doctor: Doctor, appointmentTime: String) {
        self.doctor = doctor
        self.appointmentTime = appointmentTime
    }
}
