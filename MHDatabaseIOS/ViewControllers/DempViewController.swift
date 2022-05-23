//
//  DempViewController.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/21/22.
//

import UIKit

class DempViewController: UIViewController {
    
    @IBOutlet weak var categoryLabal: UILabel!
    @IBOutlet weak var codeNameLabel: UILabel!
    
    struct phylums: Codable {
        let id: Int
        let category: String
        let codename: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .system
        view.backgroundColor = .systemBackground
        
        let dataURL = URL(string: "http://127.0.0.1:5000/app/phylums/4")!
        
        loadJSON(inURL: dataURL)
    }
    
    @IBAction func tap(_ sender: Any) {
    }
    
    func loadJSON(inURL: URL) {

        URLSession.shared.dataTask(with: inURL) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            do {
                //Decode data
                let JSONData = try JSONDecoder().decode(phylums.self, from: data)
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    self.categoryLabal.text = JSONData.category
                    print("category is: "+JSONData.category)
                    
                    
                    self.codeNameLabel.text = JSONData.codename
                    print("codename is: "+JSONData.codename)

                }
                
            } catch let jsonError {print(jsonError)}

            }.resume()
    }

}
