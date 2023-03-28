//
//  UserData+CoreDataProperties.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 28/03/23.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var userId: Int16
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var address: String?
    @NSManaged public var profileImageUrl: String?
    @NSManaged public var location: Data?

}

extension UserData : Identifiable {

}
