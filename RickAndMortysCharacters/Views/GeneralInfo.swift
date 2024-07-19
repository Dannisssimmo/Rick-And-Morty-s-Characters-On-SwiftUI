import SwiftUI

struct GeneralInfo: View {
    
    let character : Character
    @State private var namesOfEpisodes : [String] = []
    @State private var isLoading = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: character.image)) {phase in
                    phase.image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    
                }
                Text(character.status.capitalized)
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colorStatus[character.status] ?? .blue))
                    .task {
                        await loadEpisodes()
                    }
                VStack(alignment: .leading) {
                    
                    Text("Species: ").bold() + Text("\(character.species)")
                    Text("Gender: ").bold() + Text("\(character.gender)")
                    Text("Episodes: ").bold() + Text("\(namesOfEpisodes.joined(separator: ", "))")
                    Text("Last known location: ").bold() + Text("\(character.location.name)")
                }
                if isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical)
            .navigationTitle(character.name)
            .background(Color(red: 0.082, green: 0.082, blue: 0.082))
            .navigationBarTitleDisplayMode(.inline)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .foregroundStyle(.white)
        }
    }
    private func loadEpisodes() async {
        isLoading = true
        await namesOfEpisodes = getNames(character: character)
        isLoading = false
    }
}

struct GeneralInfo_Previews: PreviewProvider {
    static var previews: some View {
        GeneralInfo(character: exampleCharacter)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
