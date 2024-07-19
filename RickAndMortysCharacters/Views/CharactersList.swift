import SwiftUI

struct CharactersList: View {
    @State private var characters : [Character] = []
    @State var nextPageURL: String? = startURL
    @State private var isLoading = false
    @State private var initialLoad = true
    @State private var searchTextField = ""
    @State private var notFoundAnything = false
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ZStack(alignment: .leading) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        TextField("Search", text: $searchTextField)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(10)
                            .padding(.leading, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.leading, 5)
                    }
                    .padding()
                    ForEach(characters) { character in
                        NavigationLink(destination: GeneralInfo(character: character)) {
                            CharacterRow(character: character)
                        }
                        .onAppear() {
                            if character == characters.last {
                                Task {
                                    await loadMoreCharacters()
                                }
                            }
                        }
                    }
                }
                
                if isLoading {
                    ProgressView()
                        .padding()
                }
                if notFoundAnything {
                    HStack {
                        Image("NothingFound")
                            .padding(.leading, 10)
                        Text("Try another name")
                    }
                    .padding()
                    .background(Color(red: 0.082, green: 0.082, blue: 0.082))
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }
            }
            .toolbar {
                ToolbarItem (placement: .principal) {
                    Text("Rick & Morty Characters")
                        .font(.title)
                }
            }
            .padding(.top, -20)
            
            .task {
                await loadMoreCharacters()
            }
            .onChange(of: searchTextField) {newValue in
                if newValue != "" || !notFoundAnything {
                    let url = "https://rickandmortyapi.com/api/character/?name=" + newValue
                    nextPageURL = url
                    characters = []
                    Task {
                        await loadMoreCharacters()
                    }
                } else {
                    nextPageURL = startURL
                }
            }
        }
    }
    private func loadMoreCharacters() async {
        guard !isLoading, let nextPage = nextPageURL else { return }
        isLoading = true
        
        if let newCharactersResponse = await loadData(nextPage) {
            characters.append(contentsOf: newCharactersResponse.results)
            nextPageURL = newCharactersResponse.info.next
            isLoading = false
            initialLoad = false
            notFoundAnything = false
        } else {
            characters = []
            isLoading = false
            notFoundAnything = true
        }
    }
}

#Preview {
    CharactersList()
    
}
