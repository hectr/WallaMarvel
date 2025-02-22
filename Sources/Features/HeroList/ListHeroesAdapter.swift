import Foundation
import UIKit
import CoreDomainContracts

final class ListHeroesAdapter: NSObject, UITableViewDataSource {
    var heroes: [CharacterModel] {
        didSet {
            Task { @MainActor in
                self.tableView.reloadData()
            }
        }
    }
    
    private let tableView: UITableView
    
    init(tableView: UITableView, heroes: [CharacterModel] = []) {
        self.tableView = tableView
        self.heroes = heroes
        super.init()
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListHeroesTableViewCell", for: indexPath) as! ListHeroesTableViewCell
        
        let model = heroes[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
}
