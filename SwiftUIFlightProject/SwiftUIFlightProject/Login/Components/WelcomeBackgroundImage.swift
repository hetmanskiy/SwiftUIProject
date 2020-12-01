import SwiftUI

struct WelcomeBackgroundImage: View {
  var body: some View {
    Image("chi")
      .resizable()
        .scaledToFill()
      .aspectRatio(1 / 1, contentMode: .fill)
      .edgesIgnoringSafeArea(.all)
    
  }
}

#if DEBUG
struct WelcomeBackgroundImage_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeBackgroundImage()
  }
}
#endif
