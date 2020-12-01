import SwiftUI

struct FlightRow: View {
  var flight: FlightInformation
  @State private var isPresented = false
  
  var body: some View {
    Button(action: {
      // 1
      self.isPresented.toggle()
    }) {
      HStack {
        Text("\(flight.airline) \(flight.number)")
          .frame(width: 120, alignment: .leading)
        Text(flight.otherAirport).frame(alignment: .leading)
        Spacer()
        Text(flight.flightStatus).frame(alignment: .trailing)
        // 2
      }.sheet(isPresented: $isPresented, onDismiss: {
        // 3
        print("Modal dismissed. State now: \(self.isPresented)")
      }) {
        // 4
        FlightBoardInformation(flight: self.flight, showModal: self.$isPresented)
      }
    }
  }
}

struct FlightRow_Previews: PreviewProvider {
  static var previews: some View {
    FlightRow(flight: FlightInformation.generateFlight(0))
  }
}
