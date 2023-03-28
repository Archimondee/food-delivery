//
//  UserData+CoreDataClass.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 28/03/23.
//
//

import CoreData
import Foundation

@objc(UserData)
public class UserData: NSManagedObject {
  class func saveUserData(_ user: User, context: NSManagedObjectContext) -> UserData {
    let request: NSFetchRequest<UserData> = UserData.fetchRequest()
    // Select * from user data where user id
    request.predicate = NSPredicate(format: "userId = %d", user.id)
    let userData: UserData
    if let data = try? context.fetch(request).first {
      userData = data
    } else {
      let entity = NSEntityDescription.entity(forEntityName: "UserData", in: context)!
      userData = NSManagedObject(entity: entity, insertInto: context) as! UserData
    }

    userData.userId = Int16(user.id)
    userData.name = user.name
    userData.email = user.email
    userData.phone = user.phone
    userData.address = user.address
    userData.profileImageUrl = user.profileImage?.url
    if let location = user.location,
       let data = try? JSONEncoder().encode(location)
    {
      userData.location = data
    } else {
      userData.location = nil
    }

    return userData
  }

  class func fetchUserData(context: NSManagedObjectContext) -> User? {
    let request: NSFetchRequest<UserData> = UserData.fetchRequest()

    var user: User?
    if let userData = try? context.fetch(request).first {
      user = User(userData: userData)
    }

    return user
  }
}
