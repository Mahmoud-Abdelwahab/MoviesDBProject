//
//  Details.swift
//  MoviesDBProject
//
//  Created by kasper on 3/10/20.
//  Copyright © 2020 kasper. All rights reserved.
//
import Foundation
import UIKit
import Cosmos
class Details: UITableViewController,
UICollectionViewDelegate, UICollectionViewDataSource {
    var cell :CustomDetailsCell!
    var myVideos : [String]?
    var myPojo : MoviePojo?
    @IBOutlet weak var review: UILabel!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var cosmos: CosmosView!
    override func viewDidLoad() {
          super.viewDidLoad()
        myVideos=[String]();
        
        myTitle.text = myPojo?.title
        overview.text = myPojo?.overview
        releaseYear.text = myPojo?.release_date
        cosmosFunc(cosmos: cosmos, rating: myPojo?.vote_average ?? 1)
        myImage?.sd_setImage(with: URL(string: myPojo!.poster_path!), placeholderImage: UIImage(named: "placeholder.png"))
        
      }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  myVideos!.count ;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
         cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomDetailsCell
        
        let url = URL(string: myVideos![indexPath.row])
          let requestObj = URLRequest(url: url! as URL)
        cell.myWebView.load(requestObj)
    
          
        
          return cell
          // Configure the cell
        
    }
    
    func cosmosFunc(cosmos:CosmosView , rating :Double ) {
         // Change the cosmos view rating
    
        cosmos.rating = rating

         // Change the text
        cosmos.text = "(123)"

         // Called when user finishes changing the rating by lifting the finger from the view.
         // This may be a good place to save the rating in the database or send to the server.
        cosmos.didFinishTouchingCosmos = { rating in }

         // A closure that is called when user changes the rating by touching the view.
         // This can be used to update UI as the rating is being changed by moving a finger.
       cosmos.didTouchCosmos = { rating in }
    }
  

    // MARK: - Table view data source

   /* override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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


extension Details : VideosDelegate{
    func getVideos(videos: [String]){
        print(videos)
        
        myVideos = videos
        self.myCollectionView.reloadData();
   
    }
   
   
}
