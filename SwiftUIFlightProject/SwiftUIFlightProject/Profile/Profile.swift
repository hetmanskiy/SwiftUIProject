/// Profile of the user using the app.
struct Profile : Codable {
  /// (Selected) name) of the user.
  var name: String
  
  /// Initializes a new `Profile` with an empty `name`.
  init() {
    self.name = ""
  }
  
  /// Initializes a new `Profile` with a specified name.
  ///  - Parameters:
  ///     - name Name of the user profile.
  init(named name: String) {
    self.name = name
  }
}
