import SwiftUI

struct ChatGPTView: View {
    @Environment(\.dismiss) var dismiss
    @State private var inputText = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(sender: .ai, text: "👋 Hello there! I’m your hospital assistant. Ask me anything.")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(messages) { msg in
                        HStack {
                            if msg.sender == .ai {
                                Text("🤖 " + msg.text)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                            } else {
                                Text("🧑 " + msg.text)
                                    .padding()
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
                
                HStack {
                    TextField("Ask about beds, departments, etc.", text: $inputText)
                        .textFieldStyle(.roundedBorder)
                    Button("Send") {
                        sendMessage()
                    }
                    .disabled(inputText.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding()
            }
            .navigationTitle("🧠 Ask AI")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
    
    func sendMessage() {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        messages.append(ChatMessage(sender: .user, text: trimmed))
        messages.append(ChatMessage(sender: .ai, text: simulateResponse(for: trimmed)))
        inputText = ""
    }
    
    func simulateResponse(for input: String) -> String {
        let lowercase = input.lowercased()
        
        if lowercase.contains("available beds") {
            return "We currently have beds available in ICU (100), OPD (200), Cardiology (150), Neurology (80), Pediatrics (100), and Orthopedic (60)."
        } else if lowercase.contains("discharge") {
            return "Patients can be discharged by selecting them from the list and confirming discharge after review."
        } else if lowercase.contains("symptom") || lowercase.contains("chest pain") {
            return "If someone has chest pain, they should visit the Cardiology department. Would you like to register them?"
        } else if lowercase.contains("departments") {
            return "Our departments include: ICU, OPD, Cardiology, Neurology, Pediatrics, and Orthopedic."
        } else if lowercase.contains("how to admit") || lowercase.contains("admit") {
            return "To admit a patient, go to the main list and tap 'Admit' next to the patient."
        } else if lowercase.contains("hi") || lowercase.contains("hello") {
            return "Hello! How can I assist you today?"
        } else if lowercase.contains("register patient") || lowercase.contains("registration") {
            return "To register a patient, please go to the Registration screen and fill out the required details like name, age, and department."
        } else if lowercase.contains("appointment") {
            return "To schedule an appointment, select a doctor from the Doctors section and choose an available time slot."
        } else if lowercase.contains("doctor availability") || lowercase.contains("available doctors") {
            return "Doctors are available from 9 AM to 5 PM in all departments. You can check specific availability in the Doctors tab."
        } else if lowercase.contains("timing") || lowercase.contains("hours") {
            return "The hospital operates 24/7. However, OPD services are available from 8 AM to 6 PM, Monday to Saturday."
        } else if lowercase.contains("emergency") {
            return "In case of emergency, please proceed to the Emergency department located on the ground floor. Emergency services operate round-the-clock."
        } else if lowercase.contains("thank you") {
            return "You're welcome 😉 Let me know if there's anything else I can help you with."
        } else if lowercase.contains("billing") || lowercase.contains("bill payment") {
            return "Billing can be done at the Billing section on the ground floor or online through the patient portal."
        } else if lowercase.contains("visiting hours") || lowercase.contains("visit patient") {
            return "Visiting hours are from 4 PM to 6 PM on weekdays, and 10 AM to 12 PM on Sundays."
        } else if lowercase.contains("test report") || lowercase.contains("lab result") {
            return "Lab results are available within 24 hours. You can view or download them from the Reports section."
        } else if lowercase.contains("ambulance") || lowercase.contains("emergency vehicle") {
            return "Ambulance services are available 24/7. Call our hotline at 102 for immediate support."
        } else if lowercase.contains("feedback") || lowercase.contains("complaint") {
            return "We value your feedback! Please go to the Feedback section in the app to submit your thoughts or complaints."
        } else if lowercase.contains("covid") || lowercase.contains("vaccination") {
            return "COVID-19 vaccinations are available in the OPD wing. Please carry a valid ID for registration."
        } else if lowercase.contains("diet recommendations") || lowercase.contains("food") {
            return "Dietary plans are managed by our nutrition team. Ask your assigned nurse for a consultation."
        } else if lowercase.contains("insurance claim") {
            return "We accept most major insurance providers. For claims, visit the Insurance Help Desk with your documents."
        } else if lowercase.contains("nearest pharmacy") || lowercase.contains("medicines") {
            return "The hospital pharmacy is located near the main entrance and is open 24/7."
        } else {
            return "I'm here to help with hospital-related queries like bed availability, departments, and patient flow."
        }
    }
    
    
    
    struct ChatMessage: Identifiable {
        let id = UUID()
        enum Sender {
            case user, ai
        }
        let sender: Sender
        let text: String
    }
}
