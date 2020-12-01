import SwiftUI

struct FlightBoard: View {
    var boardName: String
    var flightData: [FlightInformation]
    @State private var hideCancelled = false
    
    var showFlights: [FlightInformation] {
        hideCancelled ?
            flightData.filter { $0.status != .cancelled } :
            flightData
    }
    
    var body: some View {
        List(showFlights) { fl in
            FlightRow(flight: fl)
        }.navigationBarTitle(boardName)
        .navigationBarItems(trailing:
                                FlightFilterView(hideCanceled: $hideCancelled))
    }
}

struct FlightBoard_Previews: PreviewProvider {
    static var previews: some View {
        FlightBoard(boardName: "Test", flightData: FlightInformation.generateFlights())
    }
}
