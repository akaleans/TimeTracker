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
    let hours = Expression<Double?>("hours")
    
    var list = [ProjectItem]()
    do{
        for item in try! db.prepare(projects) {
            list.append(ProjectItem(id: Int(item[pid]), name: item[name], description: item[description], hours: item[hours] ?? 0.0))
        }
    }
    return list
}

func addProject(in_name: String, in_description: String, in_hours: Double){
    let db = try! Connection("Users/khalenstensby/Desktop/timetracker/TimeTracker/db.sqlite3")
    
    let projects = Table("projects")
    let name = Expression<String>("name")
    let description = Expression<String>("description")
    let hours = Expression<Double>("hours")
    
    do {
        try db.run(projects.insert(name <- in_name, description <- in_description, hours <- in_hours))
    } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
        print("Constraint failed: \(message), in \(String(describing: statement))")
    } catch let error {
        print("Insertion failed: \(error)")
    }
}

func deleteProject(in_pid: Int){
    let db = try! Connection("Users/khalenstensby/Desktop/timetracker/TimeTracker/db.sqlite3")
    
    let projects = Table("projects")
    let id = Expression<Int64>("id")

    let row = projects.filter(id == Int64(in_pid))
    do{
        if try db.run(row.delete()) > 0{
            print("Deleted row")
        } else {
            print("Row not found")
        }
    } catch {
        print("Delete failed: \(error)")
    }
}

func updateHours(in_pid: Int, in_hours: Double){
    let db = try! Connection("Users/khalenstensby/Desktop/timetracker/TimeTracker/db.sqlite3")
    
    let projects = Table("projects")
    let id = Expression<Int64>("id")
    let hours = Expression<Double>("hours")
    
    let row = projects.filter(id == Int64(in_pid))
    do{
        if try db.run(row.update(hours += in_hours)) > 0{
            print("Updated row")
        } else {
            print("Row not found")
        }
    } catch {
        print("Update failed: \(error)")
    }
}

