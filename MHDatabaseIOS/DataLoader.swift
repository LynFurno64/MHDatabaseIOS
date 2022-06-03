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
