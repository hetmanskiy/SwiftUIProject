import SwiftUI

struct CheckInInfo: Identifiable {
  let id = UUID()
  let airline: String
  let flight: String
}

struct FlightBoardInformation: View {
  var flight: FlightInformation
  @Binding var showModal: Bool
  @State private var rebookAlert = false
  @State private var checkInFlight: CheckInInfo?
  @State private var showFlightHistory = false
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack{
        Text("\(flight.airline) Flight \(flight.number)")
          .font(.largeTitle)
        Spacer()
        Button("Done") {
          self.showModal = false
        }
      }
      Text("\(flight.direction == .arrival ? "From: " : "To: ") \(flight.otherAirport)")
      Text(flight.flightStatus)
        .foregroundColor(Color(flight.timelineColor))
      // 1
      if flight.status == .cancelled {
        // 2
        Button("Rebook Flight") {
          self.rebookAlert = true
        }
          // 3
          .alert(isPresented: $rebookAlert) {
            // 4
            Alert(title: Text("Contact Your Airline"),
                  message: Text("We cannot rebook this flight. Please contact the airline to reschedule this flight."))
        }
      }
      if flight.direction == .departure &&
        (flight.status == .ontime || flight.status == .delayed) {
        Button("Check In for Flight") {
          // 2
          self.checkInFlight =
            CheckInInfo(airline: self.flight.airline, flight: self.flight.number)
        }
          // 3
          .actionSheet(item: $checkInFlight) { flight in
            // 4
            ActionSheet(title: Text("Check In"),
                        message: Text("Check in for \(flight.airline) Flight \(flight.flight)"),
                        // 5
              buttons: [
                // 6
                .cancel(Text("Not Now")),
                // 7
                .destructive(Text("Reschedule"), action: {
                  print("Reschedule flight.")
                }),
                // 8
                .default(Text("Check In"), action: {
                  print("Do check-in for \(flight.airline) \(flight.flight).")
                })
            ])
        }
      }
      Button("On-Time History") {
        self.showFlightHistory.toggle()
      }.sheet(isPresented: $showFlightHistory, onDismiss: {
        // 3
        print("Modal dismissed. State now: \(self.showFlightHistory)")
      }) {
        // 4
        FlightTimeHistory(flight: self.flight)
      }
      Spacer()
    }.font(.headline).padding(10)
  }
}

struct FlightBoardInformation_Previews: PreviewProvider {
  static var previews: some View {
    FlightBoardInformation(flight: FlightInformation.generateFlight(0),
                           showModal: .constant(false))
  }
}
