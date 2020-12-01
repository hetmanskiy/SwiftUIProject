import SwiftUI

struct FlightView: View {
    
    @EnvironmentObject var userManager: UserManager
    
    var flightInfo: [FlightInformation] = FlightInformation.generateFlights()
    
    var body: some View {
        ZStack {
            Image(systemName: "airplane").resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250, alignment: .center)
                .opacity(0.1).rotationEffect(.degrees(-90))
            VStack(alignment: .leading, spacing: 5) {
                // 2
                NavigationLink(destination: FlightBoard(boardName: "Arrivals",
                                                        flightData: self.flightInfo
                                                            .filter { $0.direction == .arrival })) {
                    // 3
                    Text("Arrivals")
                }
                NavigationLink(destination: FlightBoard(boardName: "Departures",
                                                        flightData: self.flightInfo
                                                            .filter { $0.direction == .departure })) {
                    Text("Departures")
                }
                Spacer()
            }.font(.title).padding(20)
            Spacer()
            // 4
        }.navigationBarTitle(Text("Welcome to Airport"))
        .navigationBarBackButtonHidden(true)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FlightView()
    }
}
#endif


