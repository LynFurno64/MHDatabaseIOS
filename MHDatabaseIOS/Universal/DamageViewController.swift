//
//  DamageViewController.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/27/22.
//

import UIKit

class DamageViewController: UIViewController {
    static let identifier = "DamageViewController"
    
    private var itemArray = [String]()
    private var weaknessArray = [String]()


    @IBOutlet weak var trapCollectionView: UICollectionView!
    @IBOutlet weak var weaknessCollectionView: UICollectionView!

    
    var passedMonId : Int! = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let layout1 = UICollectionViewFlowLayout()
        let layout2 = UICollectionViewFlowLayout()

        trapCollectionView.collectionViewLayout = layout1
        weaknessCollectionView.collectionViewLayout = layout2
        //layout.itemSize = CGSize(width: 120, height: 120)
        
        trapCollectionView.register(TrapCollectionViewCell.nib(), forCellWithReuseIdentifier: TrapCollectionViewCell.identifier)
        weaknessCollectionView.register(TrapCollectionViewCell.nib(), forCellWithReuseIdentifier: TrapCollectionViewCell.identifier)
       
        
        trapCollectionView.delegate = self
        weaknessCollectionView.delegate = self

        
        trapCollectionView.dataSource = self
        weaknessCollectionView.dataSource = self
       
        
        print("To Get Data I:")
        //getMonsterItem(withID: passedMonId)
        getMonsterData(withID: "itemWeakness", id: passedMonId)
        print("To Get Data W:")
        //getMonsterWeakness(withID: passedMonId)
        getMonsterData(withID: "weakness", id: passedMonId)
    }
    

    /*
    // MARK: - Navigation
    */
    
    // MARK: - Networking
    // itemWeakness
    
    
    func getMonsterData(withID name: String, id: Int) {
        
        guard let url = URL(string: "http://127.0.0.1:5000/app/\(name)/\(id)") else {
            fatalError("URL guard stmt failed")
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            switch name {
            case "itemWeakness":
                print("In Case I:")
                self.items(with: data)
                break
            case "weakness":
                print("In Case W:")
                self.weakness(with: data)
                break
            default:
                break
            }

        }//.cancel()
        .resume()
    }// getMonsterData
    
    
    
    
    func getMonsterItem(withID id: Int) {
        
        guard let url = URL(string: "http://127.0.0.1:5000/app/itemWeakness/\(id)") else {
            fatalError("URL guard stmt failed")
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            self.items(with: data)

            }.resume()
    }// getMonsterItem
    
    
    func items(with data: Data) {
        do {
            //Decode data
            print("In Items:")
            let monData = try JSONDecoder().decode(ItemWeakness.self, from: data)
            print(monData)
            
            if monData.flash_bomb {
                print("monData.flash_bomb: ", monData.flash_bomb)

                self.itemArray.append("bomb_flash")
            }
            if monData.sonic_bomb {
                print("monData.sonic_bomb: ", monData.sonic_bomb)

                
                self.itemArray.append("bomb_sonic")
            }
            if monData.pitfall_trap {
                print("monData.pitfall_trap: ", monData.pitfall_trap)

                self.itemArray.append("trap_pitfall")
            }
            if monData.shock_trap {
                print("monData.shock_trap: ", monData.shock_trap)

                self.itemArray.append("trap_shock")
            }
            
            
            print("Items Array: ", self.itemArray)

            
            //Get back to the main queue
            DispatchQueue.main.async {
                self.trapCollectionView.reloadData()

            }
            
        } catch let jsonError {print(jsonError)}
    }// items
    
    func getMonsterWeakness(withID id: Int) {
        
        guard let url = URL(string: "http://127.0.0.1:5000/app/weakness/\(id)") else {
            fatalError("URL guard stmt failed")
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            self.weakness(with: data)

        }.resume()
    }// getMonsterItem
    
    func weakness(with data: Data) {
        do {
            //Decode data
            print("In weakness:")
            let monData2 = try JSONDecoder().decode(Weakness.self, from: data)
            print(monData2)
            
            
            if monData2.dragon {
                self.weaknessArray.append("Dragon")
            }
            if monData2.fire {
                self.weaknessArray.append("Fire")
            }
            if monData2.ice {
                self.weaknessArray.append("Ice")
            }
            if monData2.water {
                self.weaknessArray.append("Water")
            }
            if monData2.thunder {
                self.weaknessArray.append("Thunder")
            }
            if monData2.para {
                self.weaknessArray.append("Paralysis")
            }
            if monData2.poison {
                self.weaknessArray.append("Poison")
            }
            if monData2.sleep {
                self.weaknessArray.append("Sleep")
            }
            if monData2.blast {
                self.weaknessArray.append("Blastblight")
            }
            print("Weakness Array: ", self.weaknessArray)

        
            DispatchQueue.main.sync {
                self.weaknessCollectionView.reloadData()
            }
            
        } catch let jsonError {print(jsonError)}
    }// items
    
}

extension DamageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.trapCollectionView {
            // Item Cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrapCollectionViewCell.identifier, for: indexPath) as! TrapCollectionViewCell
            let item = itemArray[indexPath.item]
            print("Items Row: ", item)
            cell.imageView.image = UIImage(named: item)
            return cell
        }
        else {
            // Weakness Cell
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: TrapCollectionViewCell.identifier, for: indexPath) as! TrapCollectionViewCell
            
            let itemB = weaknessArray[indexPath.item]
            print("Weakness Row: ", itemB)
            cellB.imageViewB.image = UIImage(named: itemB)
            return cellB
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.trapCollectionView {
            return itemArray.count
        }
        return weaknessArray.count
    }
}

// Defines padding 
extension DamageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}

