//
//  GameViewController.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/22/22.
//

import UIKit

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let gameList = ["Freedom", "Freedom Unite", "Portable 3rd", "3 Ultimate", "4 Ultimate", "Generation Ultimate", "World & Iceborne", "Rise & Sunbreak"]
    let imageList = ["f", "fu", "3rd", "3u", "4u", "gu", "wi", "rs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Register Custom Table Cell
        let nib = UINib(nibName: "GameTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "GameTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    func nameCase(name: String) -> String {
        /**l["MHF", "MHFU", "MH3rd", "MH3U", "MH4U", "MHGU", "MHWI", "MHRS"]
         ["Freedom", "Freedom Unite", "Portable 3rd", "3 Ultimate", "4 Ultimate", "Generation Ultimate", "World & Iceborne", "Rise & Sunbreak"]  */
        var newName = ""
        
        switch name {
        case "Freedom":
            newName = "MHF"
            break
        case "Freedom Unite":
            newName = "MHFU"
            break
        case "Portable 3rd":
            newName = "MH3rd"
            break
        case "3 Ultimate":
            newName = "MH3U"
            break
        case "4 Ultimate":
            newName = "MH4U"
            break
        case "Generation Ultimate":
            newName = "MHGU"
            break
        case "World & Iceborne":
            newName = "MHWI"
            break
        case "Rise & Sunbreak":
            newName = "MHRS"
            break
        default:
            break
        }
        return newName
    }
    
    //Table Func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Touched")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Sort", bundle: nil)
        let sortedTableVC = storyBoard.instantiateViewController(withIdentifier: "SortTableView") as! SortTableViewController
        
        print(nameCase(name: gameList[indexPath.row]))
        sortedTableVC.passedName = nameCase(name: gameList[indexPath.row])
        sortedTableVC.passedType = "games"
        navigationController?.pushViewController(sortedTableVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell",
                                                 for: indexPath) as! GameTableViewCell
        cell.myLabel.text = gameList[indexPath.row]
        cell.myImageView.image = UIImage(named: imageList[indexPath.row])
        return cell
    }

}
