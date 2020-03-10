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
    
    
    var myPojo : MoviePojo?
    @IBOutlet weak var review: UILabel!
    
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var cosmos: CosmosView!
    override func viewDidLoad() {
          super.viewDidLoad()
        
       // myPojo=MoviePojo();
      }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell:CustomDetailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomDetailsCell
        
    
     //   cell.myImage.image = UIImage(named:"film.jpg")
          
          return cell
          // Configure the cell
        
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
