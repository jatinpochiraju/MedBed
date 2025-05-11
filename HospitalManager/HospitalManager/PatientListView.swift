//
//  PatientListView.swift
//  HospitalManager
//
//  Created by Vandan Pochiraju on 04/05/25.
//


import SwiftUI

struct PatientListView: View {
    @EnvironmentObject var manager: HospitalManager
    @State private var showAddPatient = false
    @State private var searchText = ""

    var filteredPatients: [Patient] {
        if searchText.isEmpty {
            return manager.patients
        }
        return manager.patients.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        List {
            ForEach(filteredPatients) { patient in
                PatientRowView(patient: patient)
            }
        }
        .searchable(text: $searchText)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    showAddPatient = true
                }
            }
        }
        .sheet(isPresented: $showAddPatient) {
            AddPatientView()
                .environmentObject(manager)
        }
    }
}
