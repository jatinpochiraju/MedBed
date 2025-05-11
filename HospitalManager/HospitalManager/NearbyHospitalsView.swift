//
//  NearbyHospitalsView.swift
//  HospitalManager
//
//  Created by Vandan Pochiraju on 04/05/25.
//


import SwiftUI

struct NearbyHospitalsView: View {
    let hospitals = [
        "SRM Global Hospital, Chennai",
            "Kauvery Hospital, Tambaram",
            "Hindu Mission Hospital, Tambaram",
            "Dr. Kamakshi Memorial Hospital, Pallikaranai",
            "Vijaya Health Centre, Vadapalani",
            "MIOT International, Manapakkam",
            "Gleneagles Global Health City, Perumbakkam",
            "Apollo Hospitals, Greams Road",
            "Fortis Malar Hospital, Adyar",
            "Chettinad Hospital and Research Institute, Kelambakkam",
            "Madha Medical College and Hospital, Thandalam",
            "Apollo Hospitals, Hyderabad",
            "Fortis Hospital, Delhi",
            "Yashoda Hospital, Secunderabad",
            "Max Hospital, Gurgaon",
            "KIMS Hospital, Bangalore",
            "AIIMS, New Delhi"
    ]

    var body: some View {
        NavigationView {
            List(hospitals, id: \.self) { hospital in
                Label(hospital, systemImage: "cross.case.fill")
            }
            .navigationTitle("Nearby Hospitals")
        }
    }
}
