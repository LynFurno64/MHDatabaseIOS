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
    let demoVC = DempViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Monsters"
        
        

        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = menu
        
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        let vc = demoVC
        
        self.addChild(vc)
        
    }
    

    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }

}


class MenuListController: UITableViewController {
    
    lazy var demoVC = DempViewController() // Do not create as the App lauch
    let homeVC = ViewController()
    

    var items = ["Home", "Games", "Monster Classes", "Bookmarks", "Settings"]
    let greyColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = greyColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func centeredHeaderView(_ title: String) -> UITableViewHeaderFooterView {
        // Set the header title and make it centered.
        let headerView: UITableViewHeaderFooterView = UITableViewHeaderFooterView()
        var content = UIListContentConfiguration.groupedHeader()
        content.text = title
        content.textProperties.alignment = .center
        headerView.contentConfiguration = content
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
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
        
        let item = items[indexPath.row]
        print(item)
        
        switch item {
        case "Home":
            break
        case "Games":
            
            let storyBoard = UIStoryboard(name: "Demp", bundle: nil)
            let vc =  storyBoard.instantiateViewController(withIdentifier: "dempID") as! DempViewController
            //let navVC = UINavigationController(rootViewController: vc)
            //splitViewController?.showDetailViewController(navVC, sender: navVC) // Replace the detail view controller.
            navigationController?.pushViewController(vc, animated: true) // Just push instead of replace.
                
        case "Monster Classes":
            break
        case "Bookmarks":
            break
        case "Settings":
            break
        default:
            print(item)
        }
        
    }
    
}
