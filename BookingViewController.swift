





import UIKit

class BookingViewController: UIViewController {

    @IBOutlet weak var patientsAge: UITextField!
    @IBOutlet weak var patientsGender: UITextField!
    @IBOutlet weak var patientsName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var rescheduleDetail: AppointmentBookingDetail?
    var drName: String = ""
    var doctorDetail: Doctor?
    var bookingId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the datePicker to start from the next possible 15-minute interval
        setDatePickerToNextFifteenMinuteInterval()
        
        if rescheduleDetail != nil {
            patientsName.text = rescheduleDetail?.patientName
            patientsAge.text = String(rescheduleDetail!.patientsAge)
            patientsGender.text = rescheduleDetail?.patientGender
            doctorDetail = rescheduleDetail?.doctorDetail
            bookingId = rescheduleDetail!.id
        } else {
            bookingId = bookingList.count + 1
        }
    }

    @IBAction func selectPayment(_ sender: UIButton) {
        // Check if all input fields have values
        guard let name = patientsName.text, !name.isEmpty else {
            showAlert(message: "Please enter the patient's name.")
            return
        }
        guard let age = patientsAge.text, !age.isEmpty else {
            showAlert(message: "Please enter the patient's age.")
            return
        }
        guard let gender = patientsGender.text, !gender.isEmpty else {
            showAlert(message: "Please enter the patient's gender.")
            return
        }

        // Check if a valid date is selected
        if datePicker.date < Date() {
            showAlert(message: "Please select a valid date (can't be in the past).")
            return
        }

        // Instantiate PaymentViewController
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
        
        let appointmentBooking = AppointmentBookingDetail(id: bookingId, userContact: "", userEmail: "", isCompleted: false, isCancelled: false, isUpcoming: true, patientName: patientsName.text!, patientsAge: Int(patientsAge.text!) ?? 0, patientGender: patientsGender.text!, doctorDetail: doctorDetail ?? nil,bookingdate: formatDate(datePicker.date))
        
        vc.appointmentRequest = appointmentBooking
    
        // Push to PaymentViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // Helper function to show an alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Missing Information", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // Function to set the datePicker to start from the next 15-minute interval
    func setDatePickerToNextFifteenMinuteInterval() {
        let calendar = Calendar.current
        
        // Get the current time and round it to the next 15 minutes
        let now = Date()
        let minute = calendar.component(.minute, from: now)
        
        // Calculate the next 15-minute interval
        let nextRoundedMinute = (minute / 15 + 1) * 15
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: now)
        
        // If the minute is exactly at a 15-minute interval, we should move to the next one
        if nextRoundedMinute == 60 {
            components.hour! += 1
            components.minute = 0
        } else {
            components.minute = nextRoundedMinute
        }
        
        // Set the datePicker's date to the next rounded time
        if let nextAvailableDate = calendar.date(from: components) {
            datePicker.date = nextAvailableDate
        }

        // Optionally, disable the datePicker's minute component to only show 15-minute intervals
        datePicker.minuteInterval = 15
    }

    // Function to format the date into a string
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
}
