# SwiftUI Basics

What is SwiftUI? What is new, and how to use new tools to develop UI with new technology? You can find answers in a  [presentation](https://drive.google.com/file/d/1yIuvXiRWaWZ7rgrR5hdwUAEMPaVfXysx/view?usp=sharing) or [video](https://web.microsoftstream.com/video/a5c3f4be-a47e-4d3e-ab27-1f1b3fd66d50).

# View

**Example**
```Swift
import SwiftUI

struct WelcomeMessageView: View {
    var body: some View {
        VStack {
            LogoImage()
            VStack(alignment: .leading) {
                Text("Welcome to")
                    .font(.headline)
                    .bold()
                Text("Flight")
                    .font(.largeTitle)
                    .bold()
            }
            .foregroundColor(.red)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
        }
    }
}

struct WelcomeMessageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeMessageView()
    }
}
```

**Description**


The first thing to notice is that WelcomeView is a struct that implements the View protocol. Yes, View is now a protocol, and very simple. The only thing you have to do, WelcomeView, is to declare the body variable. All your subviews and custom views must support the View protocol, that is, they must have a body variable. The content of the body closure: some View {…} is the description of what will be displayed on the screen.

# Modifiers 

**Example**
```Swift
import SwiftUI

struct BorderedViewModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
      .background(Color.white)
      .overlay(
        RoundedRectangle(cornerRadius: 0)
          .stroke(lineWidth: 2)
          .foregroundColor(.blue)
      )
      .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2)
  }
}

extension View {
  func bordered() -> some View {
    ModifiedContent(content: self, modifier: BorderedViewModifier())
  }
}
```
**Description**

A modifier is a function of the View itself, which returns self, having previously performed some modifications. With this code, we have created a structure that conforms to the ViewModifier protocol. This protocol requires us to implement the body () function in this structure, at the input of which there will be some Content, and at the output - some View: the same type as the body parameter of our View.

# Stack

**Example**
```Swift
HStack {
    Image(systemName: "checkmark")
        .resizable()
        .frame(width: 16, height: 16, alignment: .center)
    
    Text("Ok")
        .font(.body)
        .bold()
}
```
**Description**

Containers are the same View, but they have a peculiarity. You pass some content to them that you want to display. The whole trick of the container is that it must somehow group and display the elements of this content. In this sense, containers are similar to modifiers, with the only difference that modifiers are intended to change one ready-made View, and containers build these Views (content elements, or blocks of declarative syntax) in a specific order, for example, vertically or horizontally (VStack {.. .} HStack {...}).


# Property Wrappers

Swift 5.1 introduces so-called property wrappers (or property delegates). In SwiftUI, property wrappers are used to update or bind one of the view parameters to our own variable.
@State
@Binding
@ObservedObject
@EnvironmentObject
@Environment

# @State 

**Example**
```Swift
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
```
**Description**

@State is a wrapper that we can use to indicate the state of the View. SwiftUI will store it in a special internal memory outside of the View structure. Only the associated View can access it. As soon as the @State property value changes, SwiftUI rebuilds the View to account for the state changes.


# @Binding 

**Example**
```Swift
struct FlightFilterView: View {
    
    @Binding var hideCanceled : Bool
    
    var body: some View {
        Toggle(isOn: $hideCanceled) {
            Text("Hide canceled")
        }
    }
}
```
**Description**

@Binding provides access by reference for a value type. Sometimes we need to make the state of our View available to its children. But we can't just take and pass that value, since it's a value type, and Swift will pass a copy of that value. This is where the @Binding property wrapper comes in handy.

# @ObservedObject

**Description**

@ObservedObject works similarly to @State, but the main difference is that we can split it between several independent Views that can subscribe and observe changes to this object, and as soon as changes appear, SwiftUI rebuilds all views associated with this object.

# @ENVIRONMENTOBJECT

**Description**

Instead of passing an ObservableObject through the init method of our View, we can implicitly inject it into the Environment of our View hierarchy. By doing this, we make it possible for all child views of the current Environment to access this ObservableObject.

# @Environment 

**Example**
```Swift
struct CalendarView: View {
    @Environment(\.calendar) var calendar: Calendar
    @Environment(\.locale) var locale: Locale
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        return Text(locale.identifier)
    }
}

```
**Description**

We can pass custom objects to Environment View hierarchies inside SwiftUI. But SwiftUI already has an Environment filled with system-wide settings. We can easily access them using the @Environment wrapper.
By tagging our properties with the @Environment wrapper, we access and subscribe to system-wide changes. As soon as the Locale, Calendar or ColorScheme system changes, SwiftUI recreates our CalendarView.


Developed By
------------

* Mykhailo Hetmanskyi, Vlad Kosyi, CHI Software

License
--------

Copyright 2020 CHI Software.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
