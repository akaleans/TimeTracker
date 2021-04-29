//
//  database.swift
//  TimeTracker
//
//  Created by Khalen Stensby on 4/21/21.
//

import SQLite

struct ProjectItem: Hashable, Identifiable {
    let id : Int
    let name : String
    let description : String
    let hours : Double
}

func connectDB() -> Connection {
    //let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first! + "/" + Bundle.main.bundleIdentifier!
    
    //try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
    
    let db = try! Connection("Users/khalenstensby/Desktop/timetracker/TimeTracker/db.sqlite3")
    
    let projects = Table("projects")
    let pid = Expression<Int64>("id")
    let name = Expression<String>("name")
    let description = Expression<String>("description")
    let hours = Expression<Double>("hours")

    try! db.run(projects.create(ifNotExists: true) { t in
        t.column(pid, primaryKey: true)
        t.column(name, unique: true)
        t.column(description)
        t.column(hours)
    })

    let schedules = Table("schedules")
    let sid = Expression<Int64>("id")
    let projectID = Expression<Int64>("projectID")
    let clockin = Expression<String>("clockin")
    let clockout = Expression<String>("clockout")

    try! db.run(schedules.create(ifNotExists: true) { t in
        t.column(sid, primaryKey: true)
        t.column(projectID)
        t.column(clockin)
        t.column(clockout)
    })
    
    return db
}

func getProjects() -> [ProjectItem] {
    let db = try! Connection("Users/khalenstensby/Desktop/timetracker/TimeTracker/db.sqlite3")
    
    let projects = Table("projects")
    let pid = Expression<Int64>("id")
    let name = Expression<String>("name")
    let description = Expression<String>("description")
    let hours = Expression<Double>("hours")
    
    var list = [ProjectItem]()
    do{
        for item in try! db.prepare(projects) {
            list.append(ProjectItem(id: Int(item[pid]), name: item[name], description: item[description], hours: item[hours]))
        }
    }
    return list
}

/*
 copy from server
 */
