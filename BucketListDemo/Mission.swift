//
//  Mission.swift
//  BucketListDemo
//
//  Created by Ketul Patel on 6/16/15.
//  Copyright (c) 2015 Ketul Patel. All rights reserved.
//

import Foundation
class Mission: NSObject, NSCoding {
    static var key: String = "Missions"
    static var schema: String = "theList"
    var objective: String
    var createdAt: NSDate
    // use this init for creating a new Task
    init(obj: String) {
        objective = obj
        createdAt = NSDate()
    }
    // MARK: - NSCoding protocol
    // used for encoding (saving) objects
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(objective, forKey: "objective")
        aCoder.encodeObject(createdAt, forKey: "createdAt")
    }
    // used for decoding (loading) objects
    required init(coder aDecoder: NSCoder) {
        objective = aDecoder.decodeObjectForKey("objective") as! String
        createdAt = aDecoder.decodeObjectForKey("createdAt") as! NSDate
        super.init()
    }
    // MARK: - Queries
    static func all() -> [Mission] {
        var missions = [Mission]()
        let path = Database.dataFilePath("theList")
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                missions = unarchiver.decodeObjectForKey(Mission.key) as! [Mission]
                unarchiver.finishDecoding()
            }
        }
        return missions
    }
    func save() {
        var missionsFromStorage = Mission.all()
        var exists = false
        for var i = 0; i < missionsFromStorage.count; ++i {
            if missionsFromStorage[i].createdAt == self.createdAt {
                missionsFromStorage[i] = self
                exists = true
            }
        }
        if !exists {
            missionsFromStorage.append(self)
        }
        Database.save(missionsFromStorage, toSchema: Mission.schema, forKey: Mission.key)
    }
    func destroy() {
        var missionsFromStorage = Mission.all()
        for var i = 0; i < missionsFromStorage.count; ++i {
            if missionsFromStorage[i].createdAt == self.createdAt {
                missionsFromStorage.removeAtIndex(i)
            }
        }
        Database.save(missionsFromStorage, toSchema: Mission.schema, forKey: Mission.key)
    }
}
