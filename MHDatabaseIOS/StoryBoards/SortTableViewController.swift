//
//  SortTableViewController.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/29/22.
//

import UIKit

class SortTableViewController: UITableViewController {
    @IBOutlet weak var sorttableView: UITableView!

    var passedName : String! = "Detials"
    var passedType : String! = ""
    var passedSaved: [Int]!

    private var monsterArray = [Monster]()
    private var allMonsterArray = [Monster]()

    
    private var loading = true
    private var monsterCount = 100
    
    let dataPhylum = DataLoader().phylumData

    override func viewDidLoad() {
        super.viewDidLoad()
        title = passedName
        let query = passedName!
                
        // Give correct names
        dataPhylum.forEach { phylum in
            if query == phylum.category {
                passedName = phylum.codename
            }
        }
        getAllMonster()
    }
    
    /** Determines how the table will be sorted **/
    func searchType(search: String, query: String) {
        switch search {
        case "games":
            getMonsterData(withQuery: query)
            break
        case "species":
            monsterList(withQuery: query)
            break
        case "saved":
            navigationItem.hidesBackButton = true
            savedMonsterList(withQuery: passedSaved)
            reloadInputViews()
            break
        default:
            break
        }
    }

    // MARK: - Networking
    func getAllMonster() {
        guard let url = URL(string: "http://127.0.0.1:5000/app/monsterList") else {
            fatalError("URL guard stmt failed")
        }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                guard let monsterJSONData = try? JSONDecoder().decode(MonstersList.self, from: data) else
                {
                    return /** Return if the monster count is out of range */
                }
                
                for x in monsterJSONData.monsters {
                    self?.allMonsterArray.append(x)
                }
            }

            DispatchQueue.main.sync {
                self?.searchType(search: (self?.passedType)!, query: (self?.passedName)!)
                self?.sorttableView.reloadData()
            }
        }.resume()
    }
    
    
    func getMonsterData(withQuery query: String) {
        guard let url = URL(string: "http://127.0.0.1:5000/app/games") else {
            fatalError("URL guard stmt failed")
        }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                
                guard let monsterGameData = try? JSONDecoder().decode(AllGames.self, from: data) else
                { return /** Return if the monster count is out of range */ }
                
                // Filter data
                for x in monsterGameData.gamesList {
                    if x.games == query {
                        self?.allMonsterArray.forEach({ Monster in
                            if Monster.id == x.mon_id {
                                self?.monsterArray.append(Monster)
                            }
                        })
                    }
                }
            }
            self?.loading = false
            DispatchQueue.main.sync {
                self?.sorttableView.reloadData()
            }
            
        }.resume()
    }
    
    func monsterList(withQuery query: String) {
        print("monsterList2", query)
        for x in allMonsterArray {
            if x.group == query {
                monsterArray.append(x)
            }
        }
        self.loading = false
        self.sorttableView.reloadData()
    }/// monsterList

    func savedMonsterList(withQuery bookmarked: [Int]) {
        for id in bookmarked {
            
            for monstie in allMonsterArray {
                if monstie.id == id {
                    monsterArray.append(monstie)
                }
            }
        }
        self.loading = false
        self.sorttableView.reloadData()
    }/// monsterList
    
    // MARK: - Table view data source
    override func tableView(_ mytableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableView.dequeueReusableCell(withIdentifier: "SortTableViewCell", for: indexPath) as! MonsterTableViewCell
        
        if loading {
            cell.nameLabel.text = "Loading............"
        } else {
            let monstie = monsterArray[indexPath.row]
            cell.nameLabel.text = monstie.name
            let imageName = monstie.name.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
            cell.myTumbnail.image = UIImage(named: "\(imageName).png")
            
            // Give correct names
            dataPhylum.forEach { phylum in
                if monstie.group == phylum.codename {
                    cell.classLabel.text = phylum.category
                }
            }
        }
        return cell
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loading { return 1 }
        else { return monsterArray.count }
    }
    
    // Set table height to 80.0
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    // Open the next view while passing information to it
    override func tableView(_ mytableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if loading { noConnectionAlert() }
        else {
            let monstie = monsterArray[indexPath.row]
            let name = monstie.name
            
            let imageName = name.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
            print("\(imageName).png")
            
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Details", bundle: nil)
            let detailsVC = storyBoard.instantiateViewController(withIdentifier: "monsterDetails") as! DetailsViewController
            detailsVC.passedImage = UIImage.init(named: "\(imageName).png")
            detailsVC.passedName = name
            
            // Give correct names
            dataPhylum.forEach { phylum in
                if monstie.group == phylum.codename {
                    detailsVC.passedClass = phylum.category
                }
            }
            
            detailsVC.passedGen = monstie.generation
            detailsVC.passedVary = monstie.variation
            detailsVC.passedMonId = monstie.id
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }

    
    /// Show an alert with an "OK" button.
    func noConnectionAlert() {
        let title = NSLocalizedString("Error", comment: "")
        let message = NSLocalizedString("Cannot connect to server", comment: "")
        let cancelButtonTitle = NSLocalizedString("OK", comment: "")

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        // Create the action.
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            Swift.debugPrint("The simple alert's cancel action occurred.")
        }
        // Add the action.
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
