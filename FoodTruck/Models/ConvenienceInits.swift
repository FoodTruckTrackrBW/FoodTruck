//
//  ConvenienceInits.swift
//  FoodTruck
//
//  Created by Bradley Diroff on 4/28/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation
import CoreData

extension User {
    @discardableResult convenience init(username: String, password: String, userType: String, email: String, favoriteCuisineType: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(from: context)
        self.username = username
        self.password = password
        self.userType = userType
        self.email = email
        self.favoriteCuisineType = favoriteCuisineType
    }
}

extension Truck {
    @discardableResult convenience init(cuisineType: String, departureTime: String, truckImgUrl: String, truckName: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init()
        self.cuisineType = cuisineType
        self.departureTime = departureTime
        self.truckImgUrl = truckImgUrl
        self.truckName = truckName
    }
}
