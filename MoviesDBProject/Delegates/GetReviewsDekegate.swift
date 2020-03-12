//
//  GetReviewsDekegate.swift
//  MoviesDBProject
//
//  Created by kasper on 3/12/20.
//  Copyright © 2020 kasper. All rights reserved.
//

import Foundation
protocol GetReviewsDelegate {
    func getReviews(reviewsAuther:[String] , reviewsContent:[String]);
  
}
