//
//  MyNetworkManger.swift
//  MoviesDBProject
//
//  Created by kasper on 3/6/20.
//  Copyright © 2020 kasper. All rights reserved.
//
import Alamofire
import Foundation

class MyNetworkManger{
  
    var myDelegate:GetMovieApiDelegate?
    private  var MovieURl = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.%20desc&api_key=6c91a3562a4da002fd32cd0819428f2e"
    
    init(home:Home) {
        myDelegate = home as? GetMovieApiDelegate ;
    }
    
    
      
      
   
    
    
    func getConnection(URL:String) {
        var movies = [MoviePojo]()
        Alamofire.request(URL).responseJSON
            { response in if let jsonObject = response.result.value{
        let movieArray = jsonObject as! Dictionary<String, Any>
                
                let jsonArray = movieArray["results"]
                
                for item in jsonArray as! [AnyObject] {
                    //Do stuff
                    var preUrl="https://image.tmdb.org/t/p/w600_and_h900_bestv2//"
                    var poster = item["poster_path"] as?String //
                    preUrl += poster ?? "";
                  //  let Origianl = preUrl + poster!
                    //https://image.tmdb.org/t/p/w600_and_h900_bestv2//
                    //https://image.tmdb.org/t/p/w600_and_h900_bestv2//bDlDnHzNZRF3wbd1xWjK9in1kKb.jpg
                    let myObj = MoviePojo(id: item["id"]as?Int, popularity: item["popularity"] as? Double, vote_average: item["vote_average"] as? Double, title: item["title"]as? String, release_date: item["release_date"]as? String, overview: item["overview"]as? String, poster_path: preUrl)
                    
                    movies.append(myObj)
                    }
                self.myDelegate?.getMovieArray(arr: movies)
                }
                }
     
        }
    
    
    //////////// videos /////////////
    
    func getVideos(id : Int){
        
        var videosList = [Int]()
        
        
      
        
        
        var ViedoURL : String = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=6c91a3562a4da002fd32cd0819428f2e"
        
               Alamofire.request(ViedoURL).responseJSON
                   { response in if let jsonObject = response.result.value{
               let movieArray = jsonObject as! Dictionary<String, Any>
                       
                    
                    print(movieArray)
//                       let jsonArray = movieArray["results"]
//
//                       for item in jsonArray as! [AnyObject] {
//                           //Do stuff
//                           var preUrl="https://image.tmdb.org/t/p/w600_and_h900_bestv2//"
//                           var poster = item["poster_path"] as?String //
//                           preUrl += poster ?? "";
//                         //  let Origianl = preUrl + poster!
//                           //https://image.tmdb.org/t/p/w600_and_h900_bestv2//
//                           //https://image.tmdb.org/t/p/w600_and_h900_bestv2//bDlDnHzNZRF3wbd1xWjK9in1kKb.jpg
//                           let myObj = MoviePojo(id: item["id"]as?Int, popularity: item["popularity"] as? Double, vote_average: item["vote_average"] as? Double, title: item["title"]as? String, release_date: item["release_date"]as? String, overview: item["overview"]as? String, poster_path: preUrl)
//
//                           movies.append(myObj)
//                           }
//                       self.myDelegate?.getMovieArray(arr: movies)
//                       }
                       }
        
    }
    
        
    }

}
