import 'package:mtodo/models/category.dart';
import 'package:mtodo/models/todo.dart';
import 'package:mtodo/repositories/repository.dart';

class TodoService{

  Repository _repository;

  TodoService(){
    _repository = Repository();
  }

  saveTodo(Todo todo) async{
   return await _repository.save('todos', todo.createMap());
  }

  getTodo() async{
    return await _repository.getAll('todos');

  }

   getTodoById(categoryId) async {
    return await _repository.getById('todos', categoryId);
   }

  updateTodo(Todo todo) async{
    return await _repository.update('todos', todo.createMap());
  }

  deleteTodo(categoryId) async{
    return await _repository.delete('todos', categoryId);
  }

}

