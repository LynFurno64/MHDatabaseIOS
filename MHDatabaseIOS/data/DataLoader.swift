//
//  DataLoader.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/29/22.
//

import Foundation

class DataLoader {
    @Published var phylumData = [Phylums]()
    
    init(){
        loadPylums()
    }

    func loadPylums(){
        if let filelocation = Bundle.main.url(forResource: "phylums", withExtension: "json") {
            do {
                let data = try Data(contentsOf: filelocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Phylums].self, from: data)
                
                self.phylumData = dataFromJson
            } catch {
                print(error)
            }
        }
    }// loadPylums

}

class BookmarkData {
    var monsterIDs = [String]()

    let manager = FileManager.default
    
    init(){
        file()
    }
    
    func folderURL() -> (URL) {
        guard let url = manager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            return URL(string: "")!
            }
            
        let newFolderUrl = url.appendingPathComponent("data")
        return newFolderUrl
    }
    
    func file(){
        
        let folder = folderURL()
        
        /**
         Checks if directory already exists
         */
        if !folder.hasDirectoryPath {
            do {
                // Create Directory
                try manager.createDirectory(
                    at: folder,
                    withIntermediateDirectories: true,
                    attributes: [:])
                
                // Create file
                let fileUrl = folder.appendingPathComponent("saved.txt")
                manager.createFile(
                    atPath: fileUrl.path,
                    contents: nil,
                    attributes: [FileAttributeKey.creationDate: Date()])
            } catch { print(error) }
        }
    }
    
    func readFile() -> [String]{
        let fileUrl = folderURL().appendingPathComponent("saved.txt")
        var array = ["String"]
        
        if manager.fileExists(atPath: fileUrl.path) {
            //reading
            do {
                let contents = try String(contentsOf: fileUrl, encoding: .utf8)
                array = contents.components(separatedBy: " ")
                return array
            }
            catch {print(error)}
        }
        return array
    }
    
    func writeToFile(withArray arr: [String]){
        let fileUrl = folderURL().appendingPathComponent("saved.txt")
        
        monsterIDs = arr
        
        let savedString = monsterIDs.joined(separator: " ")

        //writing
            do {
                try savedString.write(to: fileUrl, atomically: false, encoding: .utf8)
            }
            catch {print(error)}
    }
    
    func getContent(){
        let fileUrl = folderURL().appendingPathComponent("saved.txt")
        if manager.fileExists(atPath: fileUrl.path) {
            //reading
            do {
                let text2 = try String(contentsOf: fileUrl, encoding: .utf8)
                print("Files:",text2)
            }
            catch {print(error)}

        }
    }
    
    
}
