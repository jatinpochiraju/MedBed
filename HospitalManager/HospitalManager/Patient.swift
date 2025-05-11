import Foundation

enum Department: String, CaseIterable, Codable, Identifiable {
    case icu = "ICU"
    case opd = "OPD"
    case cardiology = "Cardiology"
    case neurology = "Neurology"
    case pediatric = "Pediatric"
    case orthopedic = "Orthopedic"
    case oncology = "Oncology"
    case urology = "Urology"
    case nephrology = "Nephrology"
    case pulmonology = "Pulmonology"
    case endocrinology = "Endocrinology"
    case rheumatology = "Rheumatology"
    case ophthalmology = "Ophthalmology"
    case gastroenterology = "Gastroenterology"
    case internalMedicine = "Internal Medicine"
    case obstetricsAndGynecology = "Obstetrics & Gynecology"
    case psychiatry = "Psychiatry"
    case internalMedicineAndPediatrics = "Internal Medicine & Pediatrics"
    case hematology    = "Hematology"
    case radiology = "Radiology"



    var id: String { self.rawValue }
}

struct Patient: Identifiable, Codable {
    let id: UUID
    var name: String
    var age: Int
    var bedNumber: Int?
    var department: Department
    var isAdmitted: Bool

    init(id: UUID = UUID(), name: String, age: Int, department: Department, bedNumber: Int? = nil, isAdmitted: Bool = false) {
        self.id = id
        self.name = name
        self.age = age
        self.department = department
        self.bedNumber = bedNumber
        self.isAdmitted = isAdmitted
    }
}
