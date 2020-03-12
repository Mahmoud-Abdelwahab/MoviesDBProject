//
//  NsCodingID.swift
//  MoviesDBProject
//
//  Created by kasper on 3/12/20.
//  Copyright © 2020 kasper. All rights reserved.
//

import Foundation

class NsCodingID{
    
    var myIDs:[String]
    
    init( ids : [String]) {
        self.myIDs = ids;
    }
    
    
    init(coder aDecoder : NSCoder) {
        self.myIDs = aDecoder .decodeObject(forKey: "myIDS") as! [String];
       }
       
    func initWithCoder(aDecoder : NSCoder)->NsCodingID{
        self.myIDs = aDecoder.decodeObject(forKey: "myIDS")as! [String]
        return self ;
        }
    
    func encodeWithCoder(aCoder :NSCoder){
        aCoder.encode(self.myIDs , forKey :"myIDS")
    }
}
