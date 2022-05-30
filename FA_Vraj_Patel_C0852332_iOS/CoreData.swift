//
//  CoreData.swift
//  FA_Vraj_Patel_C0852332_iOS
//
//  Created by Vraj Patel on 30/05/22.
//


import UIKit
import Foundation
import CoreData

class CoreDataHelp {
    static var instance : CoreDataHelp = CoreDataHelp()
    
    func dataCount() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate(format: "userId = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                return arr.count
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return 0
    }
    
    func save(turn : String) {
      
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
        let managedContext =
        appDelegate.persistentContainer.viewContext
        
        let objEntityGame = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: managedContext) as! Entity
        
        objEntityGame.turnOn = turn
        objEntityGame.userId = "MyGame"
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func addGame(move : MoveName, turn : String, start : String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate(format: "userId = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! Entity
                    if obj.array == nil {
                        var arrMoves : [String] = []
                        arrMoves.append(move.rawValue)
                        obj.array = arrMoves as NSObject
                    } else {
                        var arrImg = obj.array as! [String]
                        arrImg.append(move.rawValue)
                        obj.array = arrImg as NSObject
                    }
                    obj.turnOn = start
                    obj.turnOff = turn
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func changeTurn(move : String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate(format: "userId = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! Entity
                    obj.turnOn = move
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func removeLastMove(turn : String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate(format: "userId = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! Entity
                    if obj.array != nil {
                        var arrImg = obj.array as! [String]
                        arrImg.removeLast()
                        obj.array = arrImg as NSObject
                    }
                    obj.turnOn = turn
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func updateNought(count : Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate(format: "userId = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! Entity
                    obj.winO = Double(count)
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func updateCross(count : Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate(format: "userId = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! Entity
                    var arrMoves = obj.array as! [String]
                    arrMoves.removeAll()
                    obj.winX = Double(count)
                    obj.array = arrMoves as NSObject
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getGameData() {
        appDelegate.arrGameData.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
        
        do {
            appDelegate.arrGameData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func resetCoreData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate(format: "userId = %@", "MyGame")
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    managedContext.delete(managedObject)
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
