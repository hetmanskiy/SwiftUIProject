
import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var userManager: UserManager
    @ObservedObject var keyboardHandler: KeyboardFollower
    @State var finishRegistration: Int? = nil
    
    init(keyboardHandler: KeyboardFollower) {
        self.keyboardHandler = keyboardHandler
    }
    
    var body: some View {
        
        NavigationView {
            VStack(content: {
                WelcomeMessageView()
                TextField("Type your name...", text: $userManager.profile.name)
                    .bordered()
                HStack {
                    Spacer()
                    Text("\(userManager.profile.name.count)")
                        .font(.caption)
                        .foregroundColor(userManager.isUserNameValid() ? .green : .red)
                        .padding(.trailing)
                }
                .padding(.bottom)
                
                HStack {
                    Spacer()
                    
                    Toggle(isOn: $userManager.settings.rememberUser) {
                        Text("Remember me")
                            .font(.subheadline)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.blue)
                    }
                }
                
                
                NavigationLink(destination: FlightView(), tag: 1, selection: $finishRegistration) {
                    Button(action: {
                        if userManager.isUserNameValid() {
                            self.registerUser()
                            self.finishRegistration = 1
                        }
                    }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 16, height: 16, alignment: .center)
                            
                            Text("Ok")
                                .font(.body)
                                .bold()
                        }.bordered()
                         .disabled(!userManager.isUserNameValid())
                    }
                }
            })
            .padding(.bottom, keyboardHandler.keyboardHeight)
            .padding(.leading)
            .padding(.trailing)
            .background(WelcomeBackgroundImage())
            .onAppear { self.keyboardHandler.subscribe() }
            .onDisappear { self.keyboardHandler.unsubscribe() }
        }
    }
}

extension RegisterView {
    func registerUser() {
        if userManager.settings.rememberUser {
            userManager.persistProfile()
        } else {
            userManager.clear()
        }
        
        userManager.persistProfile()
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static let user = UserManager(name: "")
    
    static var previews: some View {
        
        RegisterView(keyboardHandler: KeyboardFollower())
            .environmentObject(user)
    }
}
