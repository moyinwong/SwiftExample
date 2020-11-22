import UIKit

class PokemonViewController: UIViewController {
    var url: String!
    var isCaught = false
    var pokemonName: String!
    var pokemonId: Int!

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    @IBOutlet var catchButton: UIButton!
    @IBOutlet var pokemonImage: UIImageView!

    @IBOutlet var descrip: UITextView!

    @IBAction func toggleCatch() {
        if isCaught {
            UserDefaults.standard.set(false, forKey: pokemonName)
            catchButton.setTitle("Catch", for: .normal)
        } else {
            UserDefaults.standard.set(true, forKey: pokemonName)
            catchButton.setTitle("Release", for: .normal)
        }
    }
    
    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        descrip.text = ""
        nameLabel.text = ""
        numberLabel.text = ""
        type1Label.text = ""
        type2Label.text = ""
        catchButton.setTitle("Catch", for: .normal)

        loadPokemon()
    }

    func loadPokemonDetail(pokemonId: Int) {
        URLSession.shared.dataTask(with: URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(pokemonId)/")!) { (data, response, error) in

            guard let data = data else {
                return
            }

            do {
                let result = try JSONDecoder().decode(PokemonDetail.self, from: data)
                let description = result.flavor_text_entries[0].flavor_text
                print(description)
                DispatchQueue.main.async {
                    self.descrip.text = description
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
    
    func loadPokemon() {
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else {
                return
            }

            do {
                let result = try JSONDecoder().decode(PokemonResult.self, from: data)
                guard let imageURL = URL(string: result.sprites.front_default) else {
                    return
                }
                let imageData = try Data(contentsOf: imageURL)
                self.loadPokemonDetail(pokemonId: result.id)
                
                
                DispatchQueue.main.async {
                    self.pokemonImage.image = UIImage(data: imageData)
                    self.navigationItem.title = self.capitalize(text: result.name)
                    self.nameLabel.text = self.capitalize(text: result.name)
                    self.numberLabel.text = String(format: "#%03d", result.id)
                    self.pokemonName = result.name
                    if UserDefaults.standard.bool(forKey: result.name) {
                        self.isCaught = true
                        self.catchButton.setTitle("Release", for: .normal)
                    } else {
                        self.isCaught = false
                        self.catchButton.setTitle("Catch", for: .normal)
                    }
                    
                    for typeEntry in result.types {
                        if typeEntry.slot == 1 {
                            self.type1Label.text = typeEntry.type.name
                        }
                        else if typeEntry.slot == 2 {
                            self.type2Label.text = typeEntry.type.name
                        }
                    }
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
}
