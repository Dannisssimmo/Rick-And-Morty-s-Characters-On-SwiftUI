import SwiftUI

struct ContentView: View {
    @State private var showLoadWiew = true
    
    var body: some View {
        
        ZStack {
            CharactersList()
                .preferredColorScheme(.dark)
            if showLoadWiew {
                LoadingView()
                    .task {
                        hideLoadView()
                    }
            }
        }
    }
    private func hideLoadView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                showLoadWiew = false
            }
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
