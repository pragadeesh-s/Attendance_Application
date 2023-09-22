//
//  UsersDATABASE+CoreDataProperties.swift
//  Attendance Application
//
//  Created by Pragadeesh S on 22/09/23.
//
//

import Foundation
import CoreData


extension UsersDATABASE {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UsersDATABASE> {
        return NSFetchRequest<UsersDATABASE>(entityName: "UsersDATABASE")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var photo: Data?
    @NSManaged public var date: [Date]?

}

extension UsersDATABASE : Identifiable {

}
