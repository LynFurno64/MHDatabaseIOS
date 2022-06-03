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

    private var monsterArray = [Monster]()
    private var loading = true
    private var monsterCount = 58
    
    let dataPhylum = DataLoader().phylumData



    override func viewDidLoad() {
        super.viewDidLoad()
        title = passedName

        var check = passedName!
        
        // Give correct names
        dataPhylum.forEach { phylum in
            if check == phylum.category {
                check = phylum.codename
            }
        }
        
        for i in stride(from: 1, through: monsterCount + 1, by: 1) {
            getMonster(withID: i, withString: check)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ mytableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //mytableView.register(UITableViewCell.self, forCellReuseIdentifier: "MonsterTableViewCell")
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
        if loading {
            return 1
        }
        else {
            return monsterArray.count
        }
    }
    
    // Set table height to 80.0
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    // Open the next view while passing information to it
    override func tableView(_ mytableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let monstie = monsterArray[indexPath.row]
        let name = monstie.name
        
        let imageName = name.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        print("\(imageName).png")
        
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Details", bundle: nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "monsterDetails") as! DetailsViewController
        detailsVC.passedImage = UIImage.init(named: "\(imageName).png")
        detailsVC.passedName = name
        self.navigationController?.pushViewController(detailsVC, animated: true)

    }
    
    
    

    // Networking
    func getMonster(withID id: Int, withString check: String) {
        guard let url = URL(string: "http://127.0.0.1:5000/app/monsterList/\(id)") else {
            fatalError("URL guard stmt failed")
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                guard let monsterJSONData = try? JSONDecoder().decode(Monster.self, from: data) else
                {
                    return // Return if the monster count is out of range
                }
                
                // Filter data
                if  monsterJSONData.group == check {
                    self?.monsterArray.append(monsterJSONData)
                }
                
                if  check == "normal" {
                    self?.monsterArray.append(monsterJSONData)
                }
                
                
            }
            self?.loading = false
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }.resume()
    }

}
