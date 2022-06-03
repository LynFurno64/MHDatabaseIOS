//
//  MonsterDataManger.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/25/22.
//

import Foundation

class MonsterDataManager {

    
    static let urlSession = URLSession(configuration: .default)
    
   
    
    static func monster(id: Int,
                        completionHandler: @escaping (_ monster: Monster) -> Void) {
        
      let mhUrl = buildMonsterURL(id: id)
        
      let task = urlSession.dataTask(with: mhUrl) { (data, _, _) in
        let monster = try! JSONDecoder().decode(Monster.self, from: data!)
        DispatchQueue.main.async {
          completionHandler(monster)
        }
      }
      
      task.resume()
    }
    
    static func monsterData(name: String, id: Int,
                        completionHandler: @escaping (_ monster: Monster) -> Void) {
        
      let mhUrl = buildURL(name: name, id: id)
        
      let task = urlSession.dataTask(with: mhUrl) { (data, _, _) in
        let monster = try! JSONDecoder().decode(Monster.self, from: data!)
        DispatchQueue.main.async {
          completionHandler(monster)
        }
      }
      
      task.resume()
    }
    
    
    private static func buildMonsterURL(id: Int) -> URL {
      var urlComponents = URLComponents()
      urlComponents.scheme = "https"
      urlComponents.host = "127.0.0.1:5000"
      urlComponents.path = "/app/monsterList/\(id)"
      return urlComponents.url!
    }
    
    private static func buildURL(name: String, id: Int) -> URL {
      var urlComponents = URLComponents()
      urlComponents.scheme = "https"
      urlComponents.host = "127.0.0.1:5000"
      urlComponents.path = "/app/\(name)/\(id)"
      return urlComponents.url!
    }
}
