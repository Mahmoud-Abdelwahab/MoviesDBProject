//
//  Home.swift
//  MoviesDBProject
//
//  Created by kasper on 3/6/20.
//  Copyright © 2020 kasper. All rights reserved.
//

import UIKit
import Cosmos
import  DropDown
import SDWebImage
private let reuseIdentifier = "Cell"

class Home: UICollectionViewController {
   let BaseURL = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.%20desc&api_key=6c91a3562a4da002fd32cd0819428f2e"
     let Release_dateURL = "https://api.themoviedb.org/3/discover/movie?sort_by=release_date.%20desc&api_key=6c91a3562a4da002fd32cd0819428f2e"
    
     var LikedMovies = [MoviePojo]();
    var MoviesArray = [MoviePojo]();
    @IBOutlet weak var menu: UIBarButtonItem!
    
    let dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myNetwork = MyNetworkManger(home: self);
        myNetwork.getConnection(URL: self.BaseURL);

        // The view to which the drop down will appear on
               dropDown.anchorView = menu // UIView or UIBarButtonItem

               // The list of items to display. Can be changed dynamically
               dropDown.dataSource = ["Populatity", "Release Date"]
               // Action triggered on selection
               dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                if item == "Populatity"{
                    myNetwork.getConnection(URL: self.BaseURL);

                }else{
                    myNetwork.getConnection(URL: self.Release_dateURL);

                }
                 print("Selected item: \(item) at index: \(index)")
               
               }

               // Will set a custom width instead of the anchor view width
               
               dropDown.width = 200
              
            //   dropDown.hide()
        
        
        	
    }

    @IBAction func showMenu(_ sender: Any) {
            dropDown.show()
       }
       
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return MoviesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell: CustumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustumCollectionViewCell
        cell.MyTitle.text = MoviesArray[indexPath.row].title
        
      //  cell.MyImage.image = UIImage(named:MoviesArray[indexPath.row].poster_path!)
        
        var s = MoviesArray[indexPath.row].poster_path! //s="https://image.tmdb.org/t/p/w600_and_h900_bestv2//"
      cell.MyImage.sd_setImage(with: URL(string: s), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        
        cosmosFunc(cosmos: cell.cos, rating: MoviesArray[indexPath.row].vote_average ?? 1)
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
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var obj = MoviePojo(id: MoviesArray[indexPath.row].id, popularity: MoviesArray[indexPath.row].popularity, vote_average: MoviesArray[indexPath.row].vote_average, title: MoviesArray[indexPath.row].title, release_date: MoviesArray[indexPath.row].release_date, overview: MoviesArray[indexPath.row].overview, poster_path: MoviesArray[indexPath.row].poster_path);
        
        ////  get video list here and then presnt this object data in another view
        
    }
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


extension Home:GetMovieApiDelegate{
    func getMovieArray(arr: [MoviePojo]) {
        MoviesArray = arr;
        self.collectionView.reloadData()
    }
    
    
    
}
