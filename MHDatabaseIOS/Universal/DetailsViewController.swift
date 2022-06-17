//
//  DetailsViewController.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/26/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private var elementArray = [String]()
    private var ailmentArray = [String]()
    private var gameArray = [String]()
    private var relativeArray = [String]()
    
    private var markedArray = [String]()

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var elementCollectionView: UICollectionView!
    @IBOutlet weak var ailmentTableView: UITableView! // ailmentCell
    
    @IBOutlet weak var familyLablel: UILabel!
    @IBOutlet weak var generationLablel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var gamesTextView: UITextView!
    @IBOutlet weak var relatedTextView: UITextView!
    
    @IBOutlet weak var relatedView: UIView!

    @IBOutlet weak var bookmarkButton: UIBarButtonItem!
    private var bookmarked = false
    
    // varibles passed from other views
    var passedImage : UIImage! = nil
    var passedMonId : Int! = 1
    var passedName : String! = "Detials"
    var passedClass : String! = "No Data"
    var passedGen : Int! = 0
    var passedVary : Int! = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myImageView.image = passedImage
        navTitle.title = passedName
        nameLabel.text = passedName
        
        setFamilyText(vary: passedVary)
        classLabel.text = passedClass
        generationLablel.text = "Debut in Gen " +  String(passedGen)
        
        let layout = UICollectionViewFlowLayout()
        elementCollectionView.collectionViewLayout = layout
        elementCollectionView.register(TrapCollectionViewCell.nib(), forCellWithReuseIdentifier: TrapCollectionViewCell.identifier)
        elementCollectionView.delegate = self
        elementCollectionView.dataSource = self
        getMonsterData(withPath: "strength", id: passedMonId)
        
        ailmentTableView.dataSource = self
        getMonsterData(withPath: "ailments", id: passedMonId)
        
        getMonsterData(withPath: "games", id: passedMonId)
        getMonsterData(withPath: "family", id: passedMonId)
        
        markedArray = BookmarkData().readFile()
        print(markedArray)
        
        for id in markedArray {
            if passedMonId == Int(id){
                bookmarked = true
                bookmarkButton.isSelected = true
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print(bookmarkButton.isSelected)
    }
    
    func setFamilyText(vary : Int) {
        switch vary {
        case 1:
            familyLablel.text = "Base"
            break
        case 2:
            familyLablel.text = "Subspecies"
            familyLablel.textColor = .systemGreen
            break
        case 3:
            familyLablel.text = "Rare Species"
            familyLablel.textColor = .systemBlue
            break
        case 4:
            familyLablel.text = "Variant"
            familyLablel.textColor = .systemRed
            break
        case 5:
            familyLablel.text = "Deviant"
            familyLablel.textColor = .systemPurple
            break
        default:
            familyLablel.text = "?????"
        }
    }// setFamilyText
    
    
    @IBAction func more(_ sender: UIBarButtonItem) {
        let damageVC = storyboard?.instantiateViewController(withIdentifier: DamageViewController.identifier) as! DamageViewController
        damageVC.passedMonId = passedMonId
        
        self.navigationController?.present(damageVC, animated: true)
    }
    
    
    @IBAction func marked(_ sender: UIBarButtonItem) {
        if bookmarked {
            sender.isSelected = false
            bookmarked = false
            if let index = markedArray.firstIndex(of: String(passedMonId)) {
                markedArray.remove(at: index)
            }
            print("Marked out",markedArray)
            BookmarkData().writeToFile(withArray: markedArray)
        }
        else {
            sender.isSelected = true
            bookmarked = true
            markedArray.append(String(passedMonId))
            print("Marked in",markedArray)
            BookmarkData().writeToFile(withArray: markedArray)
        }
    }
    
    // MARK: - Networking
    func getMonsterData(withPath name: String, id: Int) {
        guard let url = URL(string: "http://127.0.0.1:5000/app/\(name)/\(id)") else {
            fatalError("URL guard stmt failed")
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            switch name {
            case "strength":
                self.strength(with: data)
                break
            case "ailments":
                self.ailments(with: data)
                break
            case "games":
                self.games_in(with: data)
                break
            case "family":
                self.family(with: data)
                break
            default:
                break
            }

        }.resume()
    }// getMonsterData
    
    func strength(with data: Data) {
        do {
            //Decode data
            let monData = try JSONDecoder().decode(Strength.self, from: data)
            if monData.dragon { self.elementArray.append("Dragon") }
            if monData.fire { self.elementArray.append("Fire") }
            if monData.ice { self.elementArray.append("Ice") }
            if monData.water { self.elementArray.append("Water") }
            if monData.thunder { self.elementArray.append("Thunder") }
            
            //Get back to the main queue
            DispatchQueue.main.sync {
                self.elementCollectionView.reloadData()
            }
            
        } catch let jsonError {print(jsonError)}
    }// strength
    
    func ailments(with data: Data) {
        do {
            //Decode data
            let monData = try JSONDecoder().decode(Ailments.self, from: data)
            
            if monData.blight != "" {
                let list = monData.blight.components(separatedBy: ", ")
                list.forEach { item in
                    self.ailmentArray.append(item)
                }
            }
            if monData.natural != "" {
                let list = monData.natural.components(separatedBy: ", ")
                list.forEach { item in
                    self.ailmentArray.append(item)
                }
            }
            if monData.status != "" {
                let list = monData.status.components(separatedBy: ", ")
                list.forEach { item in
                    self.ailmentArray.append(item)
                }
            }
            //Get back to the main queue
            DispatchQueue.main.sync {
                self.ailmentTableView.reloadData()
            }
            
        } catch let jsonError {print(jsonError)}
        
    }// ailments
    
    func games_in(with data: Data){
        do {
            let database = try JSONDecoder().decode(Games.self, from: data)
            
            for x in database.games_in {
                self.gameArray.append(x.games)
            }
            //Get back to the main queue
            DispatchQueue.main.async {
                var list = ""
                self.gameArray.forEach { item in
                    if (item == self.gameArray[0]) {
                        list.append(item)
                    } else {
                        let appended = "  " + item
                        list.append(appended)
                    }
                }
                self.gamesTextView.text = list
            }
            
        } catch let jsonError {print(jsonError)}
    }/** games_in */
    
    func family(with data: Data){
        do { let jsonData = try JSONDecoder().decode(Relatives.self, from: data)
            for x in jsonData.relatives {
                self.relativeArray.append(x.name)
            }
            //Get back to the main queue
            DispatchQueue.main.async {
                var list = ""
                self.relativeArray.forEach { item in
                    if (item == self.relativeArray[0]) {
                        list.append(item)
                    } else {
                        let appended = "\n" + item
                        list.append(appended)
                    }
                }
                print(list)
                if list.isEmpty {
                    self.relatedView.isHidden = true
                }
                self.relatedTextView.text = list
            }
        } catch let jsonError {print(jsonError)}
    }/** family */
 
}


extension DetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Item Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrapCollectionViewCell.identifier, for: indexPath) as! TrapCollectionViewCell
        let item = elementArray[indexPath.item]
        print("Items Row: ", item)
        cell.imageView.image = UIImage(named: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elementArray.count
    }
}

// Defines padding
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
}


extension DetailsViewController: UITableViewDataSource{
    func tableView(_ typeTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ailmentArray.count
    }
    
    func tableView(_ typeTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = typeTableView.dequeueReusableCell(withIdentifier: "ailmentCell", for: indexPath)
        cell.textLabel?.text = ailmentArray[indexPath.row]
        return cell
    }
}
