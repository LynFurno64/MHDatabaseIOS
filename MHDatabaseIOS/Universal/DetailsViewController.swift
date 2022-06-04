//
//  DetailsViewController.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/26/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var familyLablel: UILabel!
    @IBOutlet weak var generationLablel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    
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
        
        getMonsterElement(withID: passedMonId)
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
        // self.navigationController?.pushViewController(damageVC, animated: true)
    }
    
    // Networking \\
    
    func getMonsterElement(withID id: Int) {
        
        guard let url = URL(string: "http://127.0.0.1:5000/app/strength/\(id)") else {
            fatalError("URL guard stmt failed")
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            
            guard let data = data else { return }
            do {
                //Decode data
                let monStrenght = try JSONDecoder().decode(Strength.self, from: data)
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    /*
                    if monStrenght.fire {
                        self.fire.isHidden = false
                    }
                    if monStrenght.water {
                        self.water.isHidden = false
                    }
                    if monStrenght.ice {
                        self.ice.isHidden = false
                    }
                    if monStrenght.thunder {
                        self.thunder.isHidden = false
                    }
                    if monStrenght.dragon {
                        self.dragon.isHidden = false
                    }*/
                    
                }
                
            } catch let jsonError {print(jsonError)}

            }.resume()
    }// getMonsterElement

}
