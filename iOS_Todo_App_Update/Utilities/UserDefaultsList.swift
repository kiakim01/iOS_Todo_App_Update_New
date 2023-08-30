//
//  UserDefaultsList.swift
//  iOS_Todo_App_Update
//
//  Created by kiakim on 2023/08/28.
//

import Foundation

// Q: Codable ??
class TodoData: Codable {
    var date: Date?
    var contents: String?
    var isDone: Bool?
    
    init(date: Date? = nil, contents: String? = nil, isDone: Bool? = nil) {
        self.date = date
        self.contents = contents
        self.isDone = isDone
    }
}

class TodoManager {
    static let shared = TodoManager() // Singleton instance
    
    var todoItems: [TodoData] = []
 
    private init() {
           loadTodoItemsFromUserDefaults()
       }
       //isDone 값은 여기서 결정
    
    
    
    func addTodoItem(date: Date?, contents: String?, isDone: Bool? = false) {
        // 필수 속성이 있는지 검증
        guard let date = date, let contents = contents else {
            // 데이터가 불완전한 경우 처리
            print("할 일 항목에 불완전한 데이터가 제공되었습니다.")
            return
        }
        
        let newTodo = TodoData(date: date, contents: contents, isDone: isDone)
        todoItems.append(newTodo)
        saveTodoItemsToUserDefaults()
        
        for todo in todoItems {
            print("날짜: \(todo.date ?? Date()), 내용: \(todo.contents ?? ""), 완료 여부: \(todo.isDone ?? isDone)")
        }
    }


       
      func saveTodoItemsToUserDefaults() {
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

