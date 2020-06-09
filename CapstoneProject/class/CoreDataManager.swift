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
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    
    let modelName: String = "User"
    var idExist:Bool = false
    var pwCorrect:Bool = false
    
    
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
    
    //Check User Id when register
    func checkID(ID: String){
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
    
    //check user when login
    func checkUser(ID:String , Password:String){
        
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
            if idExist == false {
                return
            }else{
                for data in result as! [NSManagedObject] {
                    let pw = data.value(forKey: "password") as! String
                    if pw == Password {
                        pwCorrect = true
                    }else {
                        continue
                    }
                }
            }
        } catch{
            print("fetch error")
        }
    }
    // TODO: name 추가
    func updateUser(ID:String, Password:String, phoneNum:String , email:String){
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
        fetchRequest1.predicate = NSPredicate(format: "id = %@", ID)
        
        do{
            let test = try managedContext?.fetch(fetchRequest)
            let objectUpdate = test?[0] as! NSManagedObject
            objectUpdate.setValue(Password, forKey: "password")
            objectUpdate.setValue(phoneNum , forKey: "phone")
            objectUpdate.setValue(email, forKey: "email")
            
            
            do{
                try managedContext?.save()
            }catch {
                print("update error")
            }
        }catch {
            print("update error")
        }
        
    }
    
//    func getUser(ID:String)->Dictionary<String, Any>{
//        var userData:Dictionary<String,String> = Dictionary<String,String>()
//        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "User")
//        fetchRequest1.predicate = NSPredicate(format: "id = %@", ID)
//        
//        do{
//            let test = try managedContext?.fetch(fetchRequest)
//            let objectUpdate = test?[0] as! NSManagedObject
//            
//            
//            let password:String = objectUpdate.value(forKey: "password") as! String
//            let phone:String = objectUpdate.value(forKey: "phone") as! String
//            let email:String = objectUpdate.value(forKey: "email") as! String
//            userData.updateValue(password, forKey: "password")
//            userData.updateValue(phone, forKey: "phone")
//            userData.updateValue(email, forKey: "email")
//            
//            do{
//                try managedContext?.save()
//            }catch {
//                print("update error")
//            }
//        }catch {
//            print("update error")
//        }
//        
//        return userData
//    }
}
