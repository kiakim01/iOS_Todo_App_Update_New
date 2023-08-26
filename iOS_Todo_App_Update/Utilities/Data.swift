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
    static var data:[TodoList] = [
        //data를 1개로 조정하면 에러가 발생하는 이유 ?
        TodoList(date:"8.26",contents: "userDefaults에 데이터 저장",isDone: false),
        TodoList(date:"8.26",contents: "isDoneButton 동작구현 ",isDone:  false),
        TodoList(date:"8.26",contents: "if isDone = true stroke  ",isDone:  false)
    ]
}
