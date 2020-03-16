//
//  Favortite.swift
//  MoviesDBProject
//
//  Created by kasper on 3/6/20.
//  Copyright © 2020 kasper. All rights reserved.
//
import UIKit
import Cosmos
class Favortite: UITableViewController {
    var   favourite = [Double]()
  
           var    favouriteList = [MoviePojo]()
    
   
    var movies :[String]?
    
    var core  = MyCoreData.sharedCore;
    
    override func viewWillAppear(_ animated: Bool) {
     
        core.myCoreDataDeleget = self ;
        core.featchFavouriteIdList()
                                   
                            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
   
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let myNet = MyNetworkManger.sharedNetwork;
        let details = self.storyboard?.instantiateViewController(identifier: "details")as!Details
        
         
        // let myNet = MyNetworkManger(details: details);
//myNet.myDelegate = self as! Home;
                myNet.myReviewDelegate = details
                myNet.myVideoDelegate = details
        
         details.myPojo =  favouriteList[indexPath.row] ;
        details.myVideos =  myNet.getVideos(id: favouriteList[indexPath.row].id!)
        MyNetworkManger.sharedNetwork.getReviews(id: favouriteList[indexPath.row].id!)
         
            
          self.navigationController?.pushViewController(details, animated: true)
        

         
       
      
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // return favourite!.count
        return favouriteList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
      let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as! CustumCellFavorite
      
        // Configure the cell...
        cell.title.text =   favouriteList[indexPath.row].title
        
        var s = favouriteList[indexPath.row].poster_path! //s="https://image.tmdb.org/t/p/w600_and_h900_bestv2//"
        cell.Fav_Image.sd_setImage(with: URL(string: s), placeholderImage: UIImage(named: "placeholder.png"))
          
          
          
        cosmosFunc(cosmos: cell.cos, rating: favouriteList[indexPath.row].vote_average ?? 1)
      
//        cell.title.text = "mahmoud"
//        let s = "https://image.tmdb.org/t/p/w600_and_h900_bestv2/aQvJ5WPzZgYVDrxLX4R6cLJCEaQ.jpg"
//        cell.Fav_Image.sd_setImage(with: URL(string: s), placeholderImage: UIImage(named: "placeholder.png"))
        // cosmosFunc(cosmos: cell.cos, rating: favourite![indexPath.row].vote_average ?? 1)
        return cell
    }

    func cosmosFunc(cosmos:CosmosView , rating :Double ) {
         // Change the cosmos view rating
    
        var range : Double = 0
         if (rating < 1){
             range = 0.5
         }else if (rating < 2) {
            range = 1
             
         }else if (rating < 3){
             range = 1.5
             
         }else if (rating < 4){
            range = 2
             
         }else if (rating < 5){
             range = 2.5
             
         }else if (rating < 6){
        range = 3
             
         }else if (rating < 7){
             range = 3.5
             
         }else if (rating < 8){
            range = 4
             
         }else if (rating < 9){
             range = 4.5
             
         }else if (rating <= 10){
         range = 5 }
        
        
        cosmos.rating = range

         // Change the text
        cosmos.text = "(123)"

         // Called when user finishes changing the rating by lifting the finger from the view.
         // This may be a good place to save the rating in the database or send to the server.
        cosmos.didFinishTouchingCosmos = { rating in }

         // A closure that is called when user changes the rating by touching the view.
         // This can be used to update UI as the rating is being changed by moving a finger.
       cosmos.didTouchCosmos = { rating in }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
              core.dislike(id: favouriteList[indexPath.row].id!
            )
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

  
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    


    
    
    
    
    
}



extension Favortite : CoreDataDelegate
{
    func getFavourite(movies: [MoviePojo]) {
        
       favouriteList = movies
          self.tableView.reloadData()
        
        
    }
    
    
    
    
}
