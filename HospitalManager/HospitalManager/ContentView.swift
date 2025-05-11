import SwiftUI

struct ContentView: View {
    @StateObject var manager = HospitalManager()
    @State private var showAddPatient = false
    @State private var showHospitals = false
    @State private var showChatGPT = false
    @State private var filter: FilterType = .all

    enum FilterType: String, CaseIterable, Identifiable {
        case all = "All"
        case admitted = "Admitted"
        case discharged = "Discharged"

        var id: String { self.rawValue }
    }

    var filteredPatients: [Patient] {
        switch filter {
        case .all:
            return manager.patients
        case .admitted:
            return manager.patients.filter { $0.isAdmitted }
        case .discharged:
            return manager.patients.filter { !$0.isAdmitted }
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Dashboard cards
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        StatCard(title: "Total", value: "\(manager.patients.count)", color: .blue)
                        StatCard(title: "Admitted", value: "\(manager.patients.filter { $0.isAdmitted }.count)", color: .green)
                        StatCard(title: "Available Beds", value: "\(totalAvailableBeds())", color: .orange)
                    }
                    .padding(.horizontal)
                }

                // Filter picker
                Picker("Filter", selection: $filter) {
                    ForEach(FilterType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // Patient list
                List {
                    ForEach(filteredPatients) { patient in
                        PatientRowView(patient: patient)
                    }
                }
                .listStyle(.inset)

                // Actions + Ask AI
                VStack(spacing: 12) {
                    HStack {
                        Button(action: {
                            showAddPatient = true
                        }) {
                            Label("Add Patient", systemImage: "plus.circle")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)

                        Button("Nearby Hospitals") {
                            showHospitals = true
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                    }

                    Divider()

                    Button {
                        showChatGPT = true
                    } label: {
                        Label("💬 Ask AI", systemImage: "sparkles")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
            .navigationTitle("🏥 MedBed v2")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if let url = URL(string: "tel://112") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.white)
                            Text("SOS")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .padding(8)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .shadow(radius: 4)
                    }
                }
            }
        }
        .sheet(isPresented: $showAddPatient) {
            AddPatientView().environmentObject(manager)
        }
        .sheet(isPresented: $showHospitals) {
            NearbyHospitalsView()
        }
        .sheet(isPresented: $showChatGPT) {
            ChatGPTView()
        }
        .environmentObject(manager)
    }

    func totalAvailableBeds() -> Int {
        manager.departmentBeds.map { (dept, capacity) in
            let used = manager.patients.filter { $0.department == dept && $0.isAdmitted }.count
            return capacity - used
        }.reduce(0, +)
    }
}

struct StatCard: View {
    var title: String
    var value: String
    var color: Color

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
        }
        .frame(width: 100)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
