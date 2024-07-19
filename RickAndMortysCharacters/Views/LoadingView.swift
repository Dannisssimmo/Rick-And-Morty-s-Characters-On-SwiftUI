import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Image("LoadingBackground")
            Image("LoadingTitle")
                .resizable()
                .frame(width: 320.0, height: 100.0)
        }
    }
}

#Preview {
    LoadingView()
}
