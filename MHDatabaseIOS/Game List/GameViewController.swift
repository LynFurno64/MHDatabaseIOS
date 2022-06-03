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
    

    
    //Table Func
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "monDetails", sender: indexPath.row)

        print("Touched")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell",
                                                 for: indexPath) as! GameTableViewCell
        cell.myLabel.text = gameList[indexPath.row]
        cell.myImageView.image = UIImage(named: imageList[indexPath.row])
        return cell
    }

}