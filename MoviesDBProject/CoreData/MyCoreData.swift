//
//  MyCoreData.swift
//  MoviesDBProject
//
//  Created by kasper on 3/8/20.
//  Copyright © 2020 kasper. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class MyCoreData{
    
    // singletone object 
    static let sharedCore = MyCoreData();
    var myCoreDataDeleget : CoreDataDelegate?
    private init(){
        
    }
    
    
    func AddToCoreData( ApiArray :[MoviePojo] ){
        
      
        //1 app delgate
              
              let appDelegate = UIApplication.shared.delegate as! AppDelegate
              
              //2 manage object context
              
              let manageContext = appDelegate.persistentContainer.viewContext
              
              //3 create entity object
              
              let entity = NSEntityDescription.entity(forEntityName: "Movie", in: manageContext)
              
              // 4 create manage object for movie entity
              
            
              
              //5 set values for the manage object
      //  var moviesArr : [MoviePojo]
        for item in ApiArray
        {
        // var count = 1;
              let movie = NSManagedObject(entity: entity!, insertInto: manageContext)
            movie.setValue(item.id, forKey: "id")
            movie.setValue(item.overview, forKey: "overview")
            movie.setValue(item.popularity, forKey: "popularity")
            movie.setValue(item.poster_path, forKey: "poster_path")
              movie.setValue(item.release_date, forKey: "release_date")
              movie.setValue(item.title, forKey: "title")
              movie.setValue(item.vote_average, forKey: "vote_average")
           
        }
        
        do{
        try manageContext.save()
                  
              }catch let error{
                  
                  
                  print(error)
                  
              }
        
       
                    
        
        
    }// end of add
    
    
    func  featchData() -> [MoviePojo] {
     
        var myMoviesCore = [MoviePojo]()
        
        var moviesArray = [NSManagedObject]()
        //1 app delgate
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            //2 manage object context
            
            let manageContext = appDelegate.persistentContainer.viewContext
            
            //3 create fetch request
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
            
            
            //let prdictae = NSPredicate(format: "title == %@", "Movie1")
            
    //        fetchRequest.predicate = prdictae
            
            
            do{
                moviesArray = try manageContext.fetch(fetchRequest)
                
            }catch let error{
                
                
                print(error)
                
            }
        
   
        // extracting data from array of managed object
        
         for index in 0..<moviesArray.count
        {
         
              let id = moviesArray[index].value(forKey:"id")
              let overview = moviesArray[index].value(forKey:"overview") as! String
              let popularity = moviesArray[index].value(forKey:"popularity") as! Double
              let poster_path = moviesArray[index].value(forKey: "poster_path") as! String
              let release_date =   moviesArray[index].value(forKey:"release_date") as! String
              let title =   moviesArray[index].value(forKey:"title") as! String
              let vote_average =   moviesArray[index].value(forKey:"vote_average") as! Double
         
            var  pojo = MoviePojo();
            pojo.id = (id as! Double)
          //  let r = Double(myrating)
            pojo.overview = overview
           // let rel=Int(myrelase)
            pojo.popularity = popularity
            pojo.poster_path = poster_path
            pojo.release_date = release_date;
             pojo.title = title;
             pojo.vote_average = vote_average;
            
            myMoviesCore.append(pojo)
          
        
        }
        
         return myMoviesCore
        
        
                } // end of retrive func
    
  
    // add favourtie
    
    func AddFavouriteCoreData( movieId : Double ){
        
      
        //1 app delgate
              
              let appDelegate = UIApplication.shared.delegate as! AppDelegate
              
              //2 manage object context
              
              let manageContext = appDelegate.persistentContainer.viewContext
              
              //3 create entity object
              
              let entity = NSEntityDescription.entity(forEntityName: "FavoriteIDTable", in: manageContext)
              
              // 4 create manage object for movie entity
              
            
              
              //5 set values for the manage object
   
        // var count = 1;
              let movie = NSManagedObject(entity: entity!, insertInto: manageContext)
            movie.setValue(movieId, forKey: "id")
//            movie.setValue(myPojo.overview, forKey: "overview")
//            movie.setValue(myPojo.popularity, forKey: "popularity")
//            movie.setValue(myPojo.poster_path, forKey: "poster_path")
//              movie.setValue(myPojo.release_date, forKey: "release_date")
//              movie.setValue(myPojo.title, forKey: "title")
//              movie.setValue(myPojo.vote_average, forKey: "vote_average")
//           
       
        
        do{
        try manageContext.save()
                  
              }catch let error{
                  
                  
                  print(error)
                  
              }
        
       
                    
        
        
    }// end of add
    
    
    // fetch favouriteLsit
    
    func  featchFavouriteIdList() {
        
           var myMoviesIDCore = [Double]()
           
           var moviesArray = [NSManagedObject]()            //1 app delgate
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               
               //2 manage object context
               
               let manageContext = appDelegate.persistentContainer.viewContext
               
               //3 create fetch request
               
               let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteIDTable")
               
               
               //let prdictae = NSPredicate(format: "title == %@", "Movie1")
               
       //        fetchRequest.predicate = prdictae
               
               
               do{
                   moviesArray = try manageContext.fetch(fetchRequest)
                   
               }catch let error{
                   
                   
                   print(error)
                   
               }
           
      
           // extracting data from array of managed object
           
            for index in 0..<moviesArray.count
           {
            
                 let id = moviesArray[index].value(forKey:"id") as! Double
               myMoviesIDCore.append(id)
             
           
           }
           
        
        featchMovieList( idArr: myMoviesIDCore)
           
                   } // end of retrive func
       
       
    
    
    func dislike(id:Double)
    {
      guard  let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else{return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"FavoriteIDTable")
        
        fetchRequest.predicate = NSPredicate(format: "id = %f",id)
        do
        {
            let test = try  managedContext.fetch(fetchRequest)
            let objectToBeDeleted = test[0] as! NSManagedObject
            managedContext.delete(objectToBeDeleted)
            
            do{
                try managedContext.save()
                
            }catch{
                print(error)
            }
            
        }
        catch {
            print("Could not delete")

        }
    }
    
  
    
    
    
    func  featchMovieList(idArr : [Double]){
            
               var myMoviesIDCore = [MoviePojo]()
               
               var moviesArray = [NSManagedObject]()            //1 app delgate
                   let appDelegate = UIApplication.shared.delegate as! AppDelegate
                   
                   //2 manage object context
                   
                   let manageContext = appDelegate.persistentContainer.viewContext
                   
                   //3 create fetch request
                   
                   
        
        for index in 0..<idArr.count{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")

                    fetchRequest.predicate = NSPredicate(format: "id = %f",idArr[index])
                   //let prdictae = NSPredicate(format: "title == %@", "Movie1")
                   
           //        fetchRequest.predicate = prdictae
                   
                do{
                       moviesArray = try manageContext.fetch(fetchRequest)
                    
                       
                   }catch let error{
                       
                       
                       print(error)
                       
                   }
            if moviesArray.count>0
            {
                             let id = moviesArray[0].value(forKey:"id") as! Double
                             let overview = moviesArray[0].value(forKey:"overview") as! String
                             let popularity = moviesArray[0].value(forKey:"popularity") as! Double
                             let poster_path = moviesArray[0].value(forKey: "poster_path") as! String
                             let release_date =   moviesArray[0].value(forKey:"release_date") as! String
                             let title =   moviesArray[0].value(forKey:"title") as! String
                             let vote_average =   moviesArray[0].value(forKey:"vote_average") as! Double
                        
                       var  pojo = MoviePojo();
                                      pojo.id = id
                                    //  let r = Double(myrating)
                                      pojo.overview = overview
                                     // let rel=Int(myrelase)
                                      pojo.popularity = popularity
                                      pojo.poster_path = poster_path
                                      pojo.release_date = release_date;
                                       pojo.title = title;
                                       pojo.vote_average = vote_average;
                                      myMoviesIDCore.append(pojo)
            }
            
        }///
          
            print(myMoviesIDCore)
               
        
        myCoreDataDeleget?.getFavourite(movies: myMoviesIDCore)

             //   return myMoviesIDCore
               
               
                       } // end of retrive func
    
    
    
    func deleteAllData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data error : \(error) \(error.userInfo)")
        }
    }
   
    
    
    func  FavouriteIdList()->[Double] {
           
              var myMoviesIDCore = [Double]()
              
              var moviesArray = [NSManagedObject]()            //1 app delgate
                  let appDelegate = UIApplication.shared.delegate as! AppDelegate
                  
                  //2 manage object context
                  
                  let manageContext = appDelegate.persistentContainer.viewContext
                  
                  //3 create fetch request
                  
                  let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteIDTable")
                  
                  
                  //let prdictae = NSPredicate(format: "title == %@", "Movie1")
                  
          //        fetchRequest.predicate = prdictae
                  
                  
                  do{
                      moviesArray = try manageContext.fetch(fetchRequest)
                      
                  }catch let error{
                      
                      
                      print(error)
                      
                  }
              
         
              // extracting data from array of managed object
              
               for index in 0..<moviesArray.count
              {
               
                    let id = moviesArray[index].value(forKey:"id") as! Double
                  myMoviesIDCore.append(id)
                
              
              }
              
           
           return myMoviesIDCore
              
                      } // end of retrive func
          
   
    
    
    
    
    
    
    
    
}
