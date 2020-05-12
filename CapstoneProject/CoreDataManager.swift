//
//  CoreDataManager.swift
//  CapstoneProject
//
//  Created by 이진하 on 2020/05/12.
//  Copyright © 2020 이진하. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var managedContext = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "User"
    var idExist:Bool = false
    
    
    //regist User
    func registUser(ID:String , Password:String, Phone:String , Email:String){
        let entity = NSEntityDescription.entity(forEntityName: modelName, in: managedContext!)
        
        let user = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        user.setValue(ID, forKey: "id")
        user.setValue(Password, forKey: "password")
        user.setValue(Phone, forKey: "phone")
        user.setValue(Email, forKey: "email")
        do{
            try managedContext?.save()
            print("register success")
        }catch let error as NSError{
            print("register error")
        }
    }
    
    //Check User Id
    func checkID(ID: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do{
            let result = try managedContext?.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: "id") as! String
                if id == ID {
                    idExist = true
                }else {
                    continue
                }
            }
        } catch{
            print("fetch error")
        }
        
    }
    
    
}
