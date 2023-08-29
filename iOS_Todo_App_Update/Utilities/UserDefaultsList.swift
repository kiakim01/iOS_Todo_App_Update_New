//
//  UserDefaultsList.swift
//  iOS_Todo_App_Update
//
//  Created by kiakim on 2023/08/28.
//

import Foundation

// Q: Codable ??
struct TodoData: Codable {
    var date: Date
    var contents: String
    var isDone: Bool
}

class TodoManager {
    static let shared = TodoManager() // Singleton instance
    
    var todoItems: [TodoData] = []
 
    private init() {
           loadTodoItemsFromUserDefaults()
       }
       
       func addTodoItem(date: Date, contents: String, isDone: Bool = false) {
           let newTodo = TodoData(date: date, contents: contents, isDone: isDone)
           todoItems.append(newTodo)
           saveTodoItemsToUserDefaults()
     
               for todo in todoItems {
                   print("Date: \(todo.date), Contents: \(todo.contents), IsDone: \(todo.isDone)")
               }
           
           
       }
       
       private func saveTodoItemsToUserDefaults() {
           let encodedData = try? JSONEncoder().encode(todoItems)
           UserDefaults.standard.set(encodedData, forKey: "Key_TodoItems")
       }
       
       private func loadTodoItemsFromUserDefaults() {
           if let encodedData = UserDefaults.standard.data(forKey: "Key_TodoItems"),
              let savedTodoItems = try? JSONDecoder().decode([TodoData].self, from: encodedData) {
               todoItems = savedTodoItems
           }
       }
}

