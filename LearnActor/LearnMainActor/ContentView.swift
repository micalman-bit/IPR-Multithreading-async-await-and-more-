//
//  ContentView.swift
//  LearnMainActor
//
//  Created by Andrey Samchenko
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var todoListVM = TodoListViewModel()
    
    var body: some View {
        List(todoListVM.todos, id: \.id) { todo in
            Text(todo.title)
        })
        
        .task {
            await todoListVM.populateTodos()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
