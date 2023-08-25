//
//  Data.swift
//  iOS_Todo_App_Update
//
//  Created by kiakim on 2023/08/25.
//

import Foundation

struct TodoList {
    var date: String?
    var contents: String?
    var isDone: Bool?
}




extension TodoList {
    static var data = [
        TodoList(date:"8.25",contents: "일어나기",isDone: false),
        TodoList(date:"8.25",contents: "점심먹기",isDone: true),
        TodoList(date:"8.25",contents: "저녁먹기",isDone: true)
    ]
}
