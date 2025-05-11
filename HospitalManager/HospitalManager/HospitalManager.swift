import Foundation

class HospitalManager: ObservableObject {
    @Published var patients: [Patient] = []

    let departmentBeds: [Department: Int] = [
        .icu: 100,
        .opd: 200,
        .cardiology: 150,
        .neurology: 80,
        .pediatric: 100,
        .orthopedic: 60,
        .hematology: 50,
        .endocrinology: 40,
        .gastroenterology: 30,
        .internalMedicine: 25,
        .obstetricsAndGynecology: 20,
        .oncology: 15,
        .ophthalmology: 10
        
    ]

    init() {
        load()
    }

    func register(name: String, age: Int, department: Department) {
        let newPatient = Patient(name: name, age: age, department: department)
        patients.append(newPatient)
        save()
    }

    func allotBed(to patient: Patient) {
        guard let index = patients.firstIndex(where: { $0.id == patient.id }),
              !patients[index].isAdmitted else { return }

        let dept = patients[index].department
        let capacity = departmentBeds[dept] ?? 0
        let usedBeds = Set(patients.filter { $0.department == dept }.compactMap { $0.bedNumber })
        let availableBeds = Set(1...capacity).subtracting(usedBeds)

        if let bed = availableBeds.first {
            patients[index].bedNumber = bed
            patients[index].isAdmitted = true
            save()
        }
    }

    func discharge(_ patient: Patient) {
        guard let index = patients.firstIndex(where: { $0.id == patient.id }) else { return }
        patients[index].isAdmitted = false
        patients[index].bedNumber = nil
        save()
    }

    func save() {
        if let data = try? JSONEncoder().encode(patients) {
            UserDefaults.standard.set(data, forKey: "patients")
        }
    }

    func load() {
        if let data = UserDefaults.standard.data(forKey: "patients"),
           let decoded = try? JSONDecoder().decode([Patient].self, from: data) {
            patients = decoded
        } else {
            preloadSamplePatients()
        }
    }

    func preloadSamplePatients() {
        let names = [
            "Rahul Sharma", "Priya Mehta", "Anjali Reddy", "Rohan Iyer",
            "Sneha Kapoor", "Vikram Das", "Kavya Singh", "Manish Verma",
        ]
        for name in names {
            let age = Int.random(in: 5...75)
            let dept = Department.allCases.randomElement()!
            let patient = Patient(name: name, age: age, department: dept)
            patients.append(patient)
        }
        save()
    }
}
