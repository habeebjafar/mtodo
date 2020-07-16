import 'package:flutter/material.dart';
import 'package:mtodo/models/todo.dart';
import 'package:mtodo/screens/todo_screen.dart';
import 'package:mtodo/services/todo_service.dart';
import 'package:mtodo/widgets/mydrawer_navigation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Todo _todo = Todo();
  TodoService _todoService = TodoService();

  List<Todo> _todoList = List<Todo>();


  void initState(){
    super.initState();
    getAllTodos();
  }

  getAllTodos() async{
    _todoList = List<Todo>();
    var allTodos = await _todoService.getTodo();
    allTodos.forEach((mTodo){
     setState(() {
       var todoModel = Todo();
       todoModel.id= mTodo['id'];
       todoModel.title = mTodo['title'];
       todoModel.description = mTodo['description'];
       todoModel.category = mTodo['category'];
       todoModel.todoDate = mTodo['todoDate'];
       todoModel.isFinished = mTodo['isFinished'];
       _todoList.add(todoModel);
     });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("M Todo"),
      ),
      drawer: MyDrawerNavigation(),
      body: ListView.builder(
        itemCount: _todoList.length ,
          itemBuilder: (context, index){
          return Card(
            child: ListTile(
              leading: Icon(Icons.edit),

              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(_todoList[index].title),
                      Text('created ${_todoList[index].todoDate}'),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      var deleteItem = _todoService.deleteTodo(index);
                      if(deleteItem!=null){
                          getAllTodos();

                      }
                    },
                    child: Icon(

                        Icons.delete
                    ),
                  ),
                ],
              ),
            ),
          );
          }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=> TodoScreen()
          )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
