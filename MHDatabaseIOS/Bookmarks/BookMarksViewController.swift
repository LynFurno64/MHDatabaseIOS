//
//  BookMarksViewController.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/22/22.
//

import UIKit

class BookMarksViewController: UIViewController {
    var saved = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        /** Convert string array into integer array while also removing the empty element("")*/
        saved.removeAll()
        let marked = BookmarkData().readFile()
        for x in marked {
            if x != ""{
                saved.append(Int(x)!)
            }
        }
        presentSortTable()
    }
    
    // MARK: - Navigation
    func presentSortTable(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Sort", bundle: nil)
        let sortedTableVC = storyBoard.instantiateViewController(withIdentifier: "SortTableView") as! SortTableViewController
        
        sortedTableVC.passedName = "Bookmarks"
        sortedTableVC.passedType = "saved"
        sortedTableVC.passedSaved = saved
        navigationController?.pushViewController(sortedTableVC, animated: false)
    }

}
