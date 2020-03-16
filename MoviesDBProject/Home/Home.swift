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
import Network
import SystemConfiguration
private let reuseIdentifier = "Cell"

class Home: UICollectionViewController {
    let queue = DispatchQueue(label: "InternetConnectionMonitor")

    
   let BaseURL = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&page=3&api_key=6c91a3562a4da002fd32cd0819428f2e"
     let highest_rate = "https://api.themoviedb.org/3/discover/movie?sort_by=highest-rated.%20desc&api_key=6c91a3562a4da002fd32cd0819428f2e"
    
     var LikedMovies = [MoviePojo]();
    var MoviesArray = [MoviePojo]();
    @IBOutlet weak var menu: UIBarButtonItem!
    let monitor = NWPathMonitor()
   let dropDown = DropDown()
    let myCore = MyCoreData.sharedCore;
     let myNetwork = MyNetworkManger.sharedNetwork;
    override func viewDidLoad() {
        super.viewDidLoad()
      //  let myNetwork = MyNetworkManger(home: self);
        
       
        myNetwork.myDelegate = self ;
        
        monitor.pathUpdateHandler = { pathUpdateHandler in
                      if pathUpdateHandler.status == .satisfied {
                          print("Internet connection is on.")
                        self.myNetwork.getConnection(URL: self.BaseURL);
                       DispatchQueue.main.async {
                       }
                        
                      } else {
                          print("There's no internet connection.")
            DispatchQueue.main.async {
                self.MoviesArray = (self.myCore.featchData())
                                 
                   self.collectionView.reloadData()
                       }
                      
                      }
                  }


                  monitor.start(queue: queue)
        
        
        
        
        // The view to which the drop down will appear on
               dropDown.anchorView = menu // UIView or UIBarButtonItem

               // The list of items to display. Can be changed dynamically
               dropDown.dataSource = ["Populatity", "Highest Rate"]
               // Action triggered on selection
               dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                if item == "Populatity"{
                    self.myNetwork.getConnection(URL: self.BaseURL);

                }else{
                    self.myNetwork.getConnection(URL: self.highest_rate);

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
     
       // Change the text
                    cell.cos.settings.fillMode = .full
             
                    cell.cos.text = "(123)"
                    cell.cos.settings.updateOnTouch = false
                  cell.cos.settings.disablePanGestures = true
                     // Called when user finishes changing the rating by lifting the finger from the view.
                     // This may be a good place to save the rating in the database or send to the server.
                    cell.cos.didFinishTouchingCosmos = { rating in }

                     // A closure that is called when user changes the rating by touching the view.
                     // This can be used to update UI as the rating is being changed by moving a finger.
                   cell.cos.didTouchCosmos = { rating in }
        
        var range : Double = 0
                          if ((MoviesArray[indexPath.row].vote_average ?? 1) < 1){
                              range = 0.5
                          }else if ((MoviesArray[indexPath.row].vote_average ?? 1) < 2){
                             range = 1
                              
                          }else if ((MoviesArray[indexPath.row].vote_average ?? 1) < 3){
                              range = 1.5
                              
                          }else if ((MoviesArray[indexPath.row].vote_average ?? 1) < 4){
                             range = 2
                              
                          }else if ((MoviesArray[indexPath.row].vote_average ?? 1) < 5){
                              range = 2.5
                              
                          }else if ((MoviesArray[indexPath.row].vote_average ?? 1) < 6){
                         range = 3
                              
                          }else if ((MoviesArray[indexPath.row].vote_average ?? 1) < 7){
                              range = 3.5
                              
                          }else if ((MoviesArray[indexPath.row].vote_average ?? 1) < 8){
                             range = 4
                              
                          }else if ((MoviesArray[indexPath.row].vote_average ?? 1) < 9){
                              range = 4.5
                              
                          }else if ((MoviesArray[indexPath.row].vote_average ?? 1) <= 10){
                          range = 5 }
        //MoviesArray[indexPath.row].vote_average ?? 1
 cell.cos.rating = range
              
        
      //  cosmosFunc(cosmos: cell.cos, rating: MoviesArray[indexPath.row].vote_average ?? 1)
        return cell
        // Configure the cell
    
      
    }



    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let obj = MoviePojo(id: MoviesArray[indexPath.row].id, popularity: MoviesArray[indexPath.row].popularity,
                            vote_average: MoviesArray[indexPath.row].vote_average,
                            title: MoviesArray[indexPath.row].title,
                            release_date: MoviesArray[indexPath.row].release_date,
                            overview: MoviesArray[indexPath.row].overview,
                            poster_path: MoviesArray[indexPath.row].poster_path);
        
          let details = self.storyboard?.instantiateViewController(identifier: "details")as!Details
        
       // let myNet = MyNetworkManger(details: details);
        myNetwork.myDelegate = self;
        myNetwork.myReviewDelegate = details
        myNetwork.myVideoDelegate = details
        let myID =  MoviesArray[indexPath.row].id! ;
         
           // myID643102
        myNetwork.getVideos(id: myID)
        myNetwork.getReviews(id: myID)
       // myNet.getReviews(id: myID)
                
        details.myPojo = obj;
        self.navigationController?.pushViewController(details, animated: true)
        
        ////  get video list here and then presnt this object data in another view
        
    }
    
   func tabBarController(_ tabBarController: UITabBarController,
  didSelect viewController: UIViewController)
  {
//    if viewController is  {
//               print("First tab")
//           } else if viewController is SecondViewController {
//               print("Second tab")
//           }
    
    
    }
 
   

}


extension Home:GetMovieApiDelegate{
    func getMovieArray(arr: [MoviePojo]) {
        MoviesArray = arr;
       // self.myCore.deleteAllData()
        self.myCore.AddToCoreData(ApiArray: MoviesArray)
        self.collectionView.reloadData()
    }
    
    
    
}
