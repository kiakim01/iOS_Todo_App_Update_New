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
    //여기는 꼭 옵셔널이여야 하는가 ?
    var isDone: Bool?
}




extension TodoList {
    static var data = [
        TodoList(date:"8.25",contents: "UI 마무리",isDone: false),
        TodoList(date:"8.25",contents: "점심먹기",isDone: true),
        TodoList(date:"8.25",contents: "저녁먹기",isDone: true)
    ]
}
