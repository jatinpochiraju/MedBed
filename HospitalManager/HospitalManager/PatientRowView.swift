import SwiftUI

struct PatientRowView: View {
@EnvironmentObject var manager: HospitalManager
var patient: Patient

var body: some View {
    VStack(alignment: .leading, spacing: 4) {
        Text("\(patient.name), Age: \(patient.age)")
            .font(.headline)
        Text("Dept: \(patient.department.rawValue)")
            .font(.subheadline)
            .foregroundColor(.blue)

        if patient.isAdmitted {
            Text("🛏️ Bed \(patient.bedNumber!) • Admitted")
                .foregroundColor(.green)
                .font(.caption)
        } else {
            HStack {
                Text("⛔ Not Admitted")
                    .foregroundColor(.red)
                    .font(.caption)
                Spacer()
                Button("Admit") {
                    manager.allotBed(to: patient)
                }
                .buttonStyle(.borderedProminent)
                .font(.caption)
            }
        }
    }
    .padding(.vertical, 4)
}
}
