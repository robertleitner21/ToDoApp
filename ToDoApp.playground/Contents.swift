import Foundation


class TodoViewModel {
    
    // Create the reference for todoviewmodel
    
    private var remoteTodos: [[String : Any]] = [["id": UUID().uuidString, "title": "delectus aut autem", "completed": 0],
                                         ["id": UUID().uuidString, "title": "quis ut nam facilis et officia qui", "completed": 0],
                                         ["id": UUID().uuidString, "title": "fugiat veniam minus", "completed": 1],
                                         ["id": UUID().uuidString, "title": "et porro tempora", "completed": 1],
                                         ["id": UUID().uuidString, "title": "laboriosam mollitia et enim quasi adipisci quia provident illum", "completed": 0],
                                         ["id": UUID().uuidString, "title": "qui ullam ratione quibusdam voluptatem quia omnis", "completed": 0],
                                         ["id": UUID().uuidString, "title": "illo expedita consequatur quia in", "completed": 0],
                                         ["id": UUID().uuidString, "title": "quo adipisci enim quam ut ab", "completed": 1],
                                         ["id": UUID().uuidString, "title": "molestiae perspiciatis ipsa", "completed": 0],
                                         ["id": UUID().uuidString, "title": "illo est ratione doloremque quia maiores aut", "completed": 1]]
    
    func addTodos(title: String, completed: Bool) {
        remoteTodos.append(["id": UUID().uuidString, "title": title, "completed": completed ? 1 : 0])
    }
    
    func getFormattedTodosList() -> String {
        var formattedTodosList = ""
        for todo in remoteTodos {
            formattedTodosList.append("id: \(todo["id"]), title: \(todo["title"]), completed: \(todo["completed"])\n")
        }
        return formattedTodosList
    }
    
    func deleteTodos(with id: String) {
        for (index, todo) in remoteTodos.enumerated() {
            for (key, value) in todo {
                if key == "id" && value as? String == id {
                    remoteTodos.remove(at: index)
                    return
                }
            }
        }
        print("Todo with id: \(id) not found")
    }
    
    func toggleTodos(with id: String) {
        for (index, todo) in remoteTodos.enumerated() {
            for (key, value) in todo {
                if key == "id" && value as? String == id {
                    if let previousCompletedStatus = todo["completed"] as? Int {
                        let actualCompletedStatus = previousCompletedStatus == 0 ? 1 : 0
                        remoteTodos.remove(at: index)
                        remoteTodos.insert(["id": todo["id"], "title": todo["title"], "completed": actualCompletedStatus], at: index)
                    }
                }
            }
        }
    }
}



class TodoViewControler {
    
    var textFieldText: String? = nil
    var completed: Bool = false
    
    var viewModel: TodoViewModel!
    
    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
    }
    
    //funkcja imitujaca interfejs zwracania textu z textfield
    func fillImaginaryTextField(with text: String?) {
        guard let returnedText = text, !returnedText.isEmpty else {
            print("Textfield is empty!")
            return
        }
        textFieldText = text
    }
    
    //funkcja imitujaca interfejs przelaczenia checkbox
    func toggleImaginaryCheckbox() {
        if completed {
            completed = false
        } else {
            completed = true
        }
    }
    
    //funkcja imitujaca przycisniecie przycisku AddNewToDo
    func imaginaryButtonActionAddNewToDo() {
        if let todoName = textFieldText {
            viewModel.addTodos(title: todoName, completed: completed)
        }
    }
    
    //funkcja imitujaca przycisniecie przycisku RemoveTodo dla obiektu z id
    func imaginaryButtonActionRemoveTodo(with id: String) {
        viewModel.deleteTodos(with: id)
    }
    
    //funkcja imitujaca przelaczenie checkbox dla obiektu z id
    func imaginaryButtonActionToggleTodo(with id: String) {
        viewModel.toggleTodos(with: id)
    }
    
    //funkcja imitujaca tabele
    func printAllTodos() {
        print(viewModel.getFormattedTodosList())
    }

}

var testViewController = TodoViewControler(viewModel: TodoViewModel())

testViewController.fillImaginaryTextField(with: nil)
testViewController.imaginaryButtonActionAddNewToDo()
testViewController.printAllTodos()

testViewController.fillImaginaryTextField(with: "TEST1")
testViewController.imaginaryButtonActionAddNewToDo()
testViewController.printAllTodos()

testViewController.toggleImaginaryCheckbox()
testViewController.fillImaginaryTextField(with: "TEST2")
testViewController.imaginaryButtonActionAddNewToDo()
testViewController.printAllTodos()
