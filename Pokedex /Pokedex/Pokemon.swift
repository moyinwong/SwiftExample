import Foundation

struct PokemonListResults: Codable {
    let results: [PokemonListResult]
}

struct PokemonListResult: Codable {
    let name: String
    let url: String
}

struct PokemonResult: Codable {
    let id: Int
    let name: String
    let types: [PokemonTypeEntry]
    let sprites: PokemonImageEntry
}

struct PokemonTypeEntry: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}

struct PokemonImageEntry: Codable {
    let back_default: String
    let back_female: String?
    let back_shiny: String
    let back_shiny_female: String?
    let front_default: String
    let front_female: String?
    let front_shiny: String
    let front_shiny_female: String?
}

struct PokemonDetail: Codable {
    let flavor_text_entries: [PokemonDetailEntry]
}

struct PokemonDetailEntry: Codable {
    let flavor_text: String
    let language: PokemonDetailItem
    let version: PokemonDetailItem
}

struct PokemonDetailItem: Codable {
    let name: String
    let url: String
}
