//
//  MonsterTableViewController.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/25/22.
//

import UIKit

class MonsterTableViewController: UITableViewController {
    @IBOutlet weak var mytableView: UITableView!

    private var monsterArray = [Monster]()
    private var loading = true
    private var monsterCount = 52

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in stride(from: 1, through: monsterCount + 1, by: 1) {
            print(i)
            getMonster(withID: i)
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ mytableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Loading in Numrow ",loading)

        if loading {
            return 1
        }
        else {
            return monsterArray.count
        }
    }
    
    override func tableView(_ mytableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        mytableView.register(UITableViewCell.self, forCellReuseIdentifier: "monCell")

        let cell = mytableView.dequeueReusableCell(withIdentifier: "monCell", for: indexPath)
        
        print("Loading in Cell at row ",loading, "cell:\n  ", cell)
        if loading {
            cell.textLabel?.text = "Loading...."
        } else {
            let monstie = monsterArray[indexPath.row]
            cell.textLabel?.text = monstie.name
        }
        return cell
    }
    
    
    
    override func tableView(_ mytableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // pass any object as parameter, i.e. the tapped row
        
        performSegue(withIdentifier: "moveToDetails", sender: indexPath.row)
    }
    
    /*
    override func tableView(_ mytableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mytableView.deselectRow(at: indexPath, animated: false)

        print("Touched")

    }*/

    // Networking
    
    func getMonster(withID id: Int) {
        guard let url = URL(string: "http://127.0.0.1:5000/app/monsterList/\(id)") else {
            fatalError("URL guard stmt failed")
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                guard let monsterJSONData = try? JSONDecoder().decode(Monster.self, from: data) else
                {
                    fatalError("Error decoding data \(error!)")
                }
                self?.monsterArray.append(monsterJSONData)

            }
            self?.loading = false
            DispatchQueue.main.async {
                self?.mytableView.reloadData()
            }
            
        }.resume()
    }

        
        /*
        URLSession.shared.dataTask(with: url) { [weak self](data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            do {
                //Decode data
                let monsterJSONData = try JSONDecoder().decode(Monster.self, from: data)
                //Get back to the main queue
                
                self?.monsterArray.append(monsterJSONData)
            } catch let jsonError {print(jsonError)}
            self?.loading = false
            DispatchQueue.main.async {
                self?.mytableView.reloadData()
            }
            
        }.resume()*/
}
