import Foundation
import SwiftUI

let colorStatus = ["Alive" : SwiftUI.Color.green, "Dead" : .red, "unknown": .gray]

struct Character: Codable, Identifiable, Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let location: Location
    let episode: [String]
    
    struct Location: Codable {
        let name: String
    }
}
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
struct CharactersResponse: Codable {
    let results: [Character]
    let info: Info
}

struct EpisodeInfo : Codable {
    let name: String
}


let exampleCharacter = Character(
    id: 1,
    name: "Rick Sanchez",
    status: "Alive",
    species: "Human",
    gender: "Male",
    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
    location: Character.Location(name: "Earth (C-137)"),
    episode: [
        "https://rickandmortyapi.com/api/episode/1",
        "https://rickandmortyapi.com/api/episode/2",
        // ...
    ])

let exampleInfo = Info(
    count: 826,
    pages: 42,
    next: "https://rickandmortyapi.com/api/character/?page=20",
    prev: "https://rickandmortyapi.com/api/character/?page=18")

let exampleCharacterResponse = CharactersResponse(results: [exampleCharacter], info: exampleInfo)
