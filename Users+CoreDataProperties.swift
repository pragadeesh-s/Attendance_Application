//
//  Users+CoreDataProperties.swift
//  Attendance Application
//
//  Created by Pragadeesh S on 20/09/23.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var photo: Data?
    @NSManaged public var date: [Date]?
}

extension Users : Identifiable {

}
