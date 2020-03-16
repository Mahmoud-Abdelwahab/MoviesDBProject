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
import YouTubePlayer_Swift
class Details: UITableViewController,
UICollectionViewDelegate, UICollectionViewDataSource {
    var cell :CustomDetailsCell!
    var myVideos : [String]?
    var myReviewsContent : [String]?
    var myReviewsAuther : [String]?
    var myPojo : MoviePojo?
    var movieArray :[MoviePojo]?
    static var liked = false;
 
     let mycore = MyCoreData.sharedCore;
    
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet var myTableView: UITableView!
    
    @IBOutlet weak var autherContent: UILabel!
   @IBOutlet weak var myReviewsContentLable: UILabel!
    
    
   
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var cosmos: CosmosView!
    
    @IBAction func goToMoreReviews(_ sender: Any) {
        
        let reviewVC = self.storyboard?.instantiateViewController(identifier: "Review")as!Reviews
            
            reviewVC.reviewsAutherArray = myReviewsAuther ?? [""]
            
            
            
            reviewVC.reviewsContentArray = myReviewsContent ?? [""]
            self.navigationController?.pushViewController(reviewVC, animated: true)
    }
    
    override func viewDidLoad() {
        
          super.viewDidLoad()
        
        myVideos=[String]();
        myReviewsAuther = [String]();
        myReviewsContent = [String]();
        
        myTitle.text = myPojo?.title
        overview.text = myPojo?.overview
        releaseYear.text = myPojo?.release_date
        
        
     
               
               //MoviesArray[indexPath.row].vote_average ?? 1
     
                     
        
        cosmosFunc(cosmos: cosmos, rating: myPojo?.vote_average ?? 1)
        
        
        if let x =  myPojo?.poster_path {
        myImage?.sd_setImage(with: URL(string: x), placeholderImage: UIImage(named: "film.jpg"))
        }
        if  (myReviewsContent!.count>0 && myReviewsAuther!.count>0)
          {
            print("Contains a value!")
            autherContent.text = myReviewsAuther?.first
            myReviewsContentLable.text = myReviewsContent?.first

          
           }
    

      }
    
  
    @IBAction func AddToFavouriteBtn(_ sender: Any) {
        
      //  FavoritImage.image =
   
//       FavoritImage.tintColor.ciColor.green
//           FavoritImage.image?.withRenderingMode(.alwaysTemplate)
      if checkIfFileExist() != true
      {
        mycore.AddFavouriteCoreData(movieId: myPojo?.id ?? 0.0)
        Details.liked = true
        favBtn.tintColor = UIColor.green

            print("Like ******** > ")
      } else{
        mycore.dislike(id: myPojo!.id!)
                                 Details.liked = false ;
                                 favBtn.tintColor = UIColor.red

                                 print("Like ******** > ")
        }
       
//        if(Details.liked == false )
//        {
//            
//        
//            if checkIfFileExist() != true
//            {
//            mycore.AddFavouriteCoreData(movieId: myPojo?.id ?? 0.0)
//            Details.liked = true
//            favBtn.tintColor = UIColor.green
//
//                print("Like ******** > ")
//                
//            }
//
//        }else if( Details.liked == true)
//        {
//            
//            if checkIfFileExist() != true
//                       {
//                       mycore.AddFavouriteCoreData(movieId: myPojo?.id ?? 0.0)
//                       Details.liked = true
//                       favBtn.tintColor = UIColor.green
//
//                           print("Like ******** > ")
//                           
//            } else{
//                // call delete with id then make liked = false
//                           mycore.dislike(id: myPojo!.id!)
//                           Details.liked = false ;
//                           favBtn.tintColor = UIColor.orange
//
//                           print("Like ******** > ")
//
//            }
//          
//        }
//        
         //liked = true
   
    }
    
    
    func checkIfFileExist() -> Bool {
        var exist :Bool = false ;
        
     var idList = mycore.FavouriteIdList()
        for i in idList
        {
            if i == myPojo?.id
            {
                exist = true;
            }
        }
        
        
        
        return exist ;
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  myVideos!.count ;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
         cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomDetailsCell
//        cell.myYouTubeViewer.playerVars = ["playsinline":1 as AnyObject]
        
        if myVideos != nil{
// cell.myYouTubeViewer.loadVideoID(myVideos![indexPath.row])
    cell.myYouTubeViewer.load(videoId: myVideos![indexPath.row])
            
        }else{
            
        }
        
          return cell
          // Configure the cell
        
    }
    
    func cosmosFunc(cosmos:CosmosView , rating :Double ) {
         // Change the cosmos view rating
    
        var range : Double = 0
                    if (rating < 1){
                        range = 0.5
                    }else if (rating < 2){
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
        cosmos.settings.fillMode = .full
              
               cosmos.settings.updateOnTouch = false
         // Called when user finishes changing the rating by lifting the finger from the view.
         // This may be a good place to save the rating in the database or send to the server.
        cosmos.didFinishTouchingCosmos = { rating in }

         // A closure that is called when user changes the rating by touching the view.
         // This can be used to update UI as the rating is being changed by moving a finger.
       cosmos.didTouchCosmos = { rating in }
    }
  

   
  

}



extension Details : VideosDelegate{
    func getVideos(videos: [String]){
       
        
        myVideos = videos
         print("videos ********* ")
        self.myCollectionView.reloadData();
    }
   
   
}


extension Details : GetReviewsDelegate{
    func getReviews(reviewsAuther: [String], reviewsContent: [String]) {
         myReviewsAuther = reviewsAuther ;
         myReviewsContent = reviewsContent ;
         autherContent.text = myReviewsAuther?.first
        
        
     myReviewsContentLable.text = myReviewsContent?.first
        myTableView.reloadData()
    }
   
}
