//
//  TypesViewController.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/22/22.
//

import UIKit

class TypesViewController: UIViewController {
    @IBOutlet weak var typeTableView: UITableView!
    @IBOutlet weak var typStackTView: UITableView!
    
    let subGroupList = ["Normal", "Subspecies", "Rare Subspecies", "Variants", "Deviants"]
    let categoryList = ["Neopteron", "Temnoceran", "Bird Wyvern", "Flying Wyvern", "Piscine Wyvern", "Carapaceon", "Amphibian", "Fanged Beast", "Leviathan", "Snake Wyvern", "Brute Wyvern", "Fanged Wyvern", "Elder Dragon","???"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        typeTableView.delegate = self
        typeTableView.dataSource = self
        
    }
}

extension TypesViewController: UITableViewDelegate {
    func tableView(_ typeTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Touched")
    }
}

extension TypesViewController: UITableViewDataSource{
    func tableView(_ typeTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Tablerow: ", categoryList.count)
        return categoryList.count
    }
    
    func tableView(_ typeTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = typeTableView.dequeueReusableCell(withIdentifier: "typeCell", for: indexPath)
        cell.textLabel?.text = categoryList[indexPath.row]
        return cell
    }
    
}

