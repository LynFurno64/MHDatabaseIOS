//
//  ViewController.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/21/22.
//
import UIKit
import SideMenu

class ViewController: UIViewController {
    
    var menu: SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()

        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = menu
        
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    

    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }

}

class MenuListController: UITableViewController {
    

    var items = ["Home", "Games", "Monster Classes", "Bookmarks", "Settings"]
    let greyColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = greyColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        //
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.backgroundColor = greyColor
        cell.textLabel?.textColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
}
