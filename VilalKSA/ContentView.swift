import SwiftUI
import LanguageManagerSwiftUI

struct ContentView: View {
    @EnvironmentObject var languageSettings: LanguageSettings

    var body: some View {
        
        VStack {
            Button("change") {
                
                if languageSettings.selectedLanguage == .ar {
                    languageSettings.selectedLanguage = .en
                }else{
                    languageSettings.selectedLanguage = .ar
                }
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
