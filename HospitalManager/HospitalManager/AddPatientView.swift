import SwiftUI

struct AddPatientView: View {
    @EnvironmentObject var manager: HospitalManager
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var age = ""
    @State private var selectedDepartment: Department = .icu

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Age", text: $age).keyboardType(.numberPad)
                Picker("Department", selection: $selectedDepartment) {
                    ForEach(Department.allCases) { dept in
                        Text(dept.rawValue).tag(dept)
                    }
                }
            }
            .navigationTitle("Register Patient")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let ageInt = Int(age), !name.isEmpty {
                            manager.register(name: name, age: ageInt, department: selectedDepartment)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
