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
    private var monsterCount = 75
    
    let dataPhylum = DataLoader().phylumData


    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in stride(from: 1, through: monsterCount + 1, by: 1) {
            getMonster(withID: i)
        }
        
    }

    // MARK: - Table view data source
    override func tableView(_ mytableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loading {
            return 1
        }
        else {
            return monsterArray.count
        }
    }
    
    override func tableView(_ mytableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mytableView.dequeueReusableCell(withIdentifier: "MonsterTableViewCell", for: indexPath) as! MonsterTableViewCell
        
        
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

    
    // Open the next view while passing information to it
    override func tableView(_ mytableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if loading {
            noConnectionAlert()
        } else {
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

        


        /*
        let Vc = storyboard?.instantiateViewController(withIdentifier: "monsterDetails") as! DetailsViewController
        
        Vc.passedImage = UIImage.init(named: "\(imageName).png")
        Vc.passedName = name
        self.navigationController?.pushViewController(Vc, animated: true)
        //performSegue(withIdentifier: "moveToDetails", sender: indexPath.row)*/
    }
    
    // Set table height to 80.0
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    

    // Networking
    func getMonster(withID id: Int) {
        guard let url = URL(string: "http://127.0.0.1:5000/app/monsterList/\(id)") else {
            fatalError("URL guard stmt failed")
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                guard let monsterJSONData = try? JSONDecoder().decode(Monster.self, from: data) else
                {
                    return // Return if the monster count is out of range
                }
                
                self?.monsterArray.append(monsterJSONData)
            }
            self?.loading = false
            DispatchQueue.main.async {
                self?.mytableView.reloadData()
            }
            
        }.resume()
    }
    
    // MARK: - Alerts

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
