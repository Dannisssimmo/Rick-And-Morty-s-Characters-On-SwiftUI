import Foundation
let startURL = "https://rickandmortyapi.com/api/character"
func loadData(_ url: String) async -> CharactersResponse? {
    
    guard let url = URL(string: url) else {
        fatalError("Failed to construct URL")
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let charactersResponse = try decoder.decode(CharactersResponse.self, from: data)
        
        return charactersResponse
    } catch {
        print("Error fetching data: \(error)")
        return nil
    }
}

func loadEpisode(_ link: String) async -> String? {
    guard let url = URL(string: link) else {
        fatalError("Failed to constract URL")
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let episodeName = try decoder.decode(EpisodeInfo.self, from: data)
        
        return episodeName.name
    } catch {
        print("Error fetching data: \(error)")
        return nil
    }
}

func getNames(character: Character) async -> [String] {
    var names : [String] = []
    for link in character.episode {
        await names.append(loadEpisode(link) ?? "Not found!")
    }
    return names
}
