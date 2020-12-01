
import Combine
import SwiftUI
import Foundation

final class UserManager: ObservableObject {
    @Published
    var profile: Profile = Profile()
    
    @Published
    var settings: Settings = Settings()
    
    var isRegistered: Bool {
        return profile.name.isEmpty == false
    }
    
    init() {
    }
    
    init(name: String) {
        self.profile.name = name
    }
    
    func persistProfile() {
        if settings.rememberUser {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(profile), forKey: "user-profile")
        }
    }
    
    func persistSettings() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(settings), forKey: "user-settings")
    }
    
    func load() {
        if let data = UserDefaults.standard.value(forKey: "user-profile") as? Data {
            if let profile = try? PropertyListDecoder().decode(Profile.self, from: data) {
                self.profile = profile
            }
        }
        
        if let data = UserDefaults.standard.value(forKey: "user-settings") as? Data {
            if let settings = try? PropertyListDecoder().decode(Settings.self, from: data) {
                self.settings = settings
            }
        }
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: "user-profile")
    }
    
    func isUserNameValid() -> Bool {
        return profile.name.count >= 3
    }
}
