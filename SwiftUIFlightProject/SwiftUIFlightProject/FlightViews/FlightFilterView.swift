import SwiftUI

struct FlightFilterView: View {
    
    @Binding var hideCanceled : Bool
    
    var body: some View {
        Toggle(isOn: $hideCanceled) {
            Text("Hide canceled")
        }
    }
}
