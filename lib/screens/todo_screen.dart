import 'package:flutter/material.dart';
import 'package:mtodo/models/todo.dart';
import 'package:mtodo/services/category_service.dart';
import 'package:intl/intl.dart';
import 'package:mtodo/services/todo_service.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitle = TextEditingController();

  var _todoDescription = TextEditingController();

  var _todoDate = TextEditingController();

  var _categories = List<DropdownMenuItem>();

  var _selectedValue;


  Todo _todo = Todo();
  TodoService _todoService = TodoService();

  @override
  void initState(){
    super.initState();
    _loadCategories();
  }

  _loadCategories()async{
    var _categoryService = CategoryService();
    var categories = await _categoryService.getCategories();
    categories.forEach((category){

      setState(() {
        _categories.add(DropdownMenuItem(child: Text(category['name']), value: Text(category['name']),));

      });

    });
  }

  DateTime _date = DateTime.now();

  _selectTodoDate(BuildContext context) async{
   var _pickDate = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2000), lastDate: DateTime(2099));
   if(_pickDate !=null){
     setState(() {
       _date = _pickDate;
       _todoDate.text = DateFormat('yyyy-MM-dd').format(_pickDate);
     });
   }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Todo"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              TextField(
                controller: _todoTitle,
                decoration: InputDecoration(
                    hintText: 'Todo title',
                    labelText: 'Cook food'
                ),
              ),

              TextField(
                controller: _todoDescription,
                decoration: InputDecoration(
                    hintText: 'Todo description',
                    labelText: 'Cook rice and curry'
                ),
              ),

              TextField(
                controller: _todoDate,
                decoration: InputDecoration(
                    hintText: 'YY-MM-DD',
                    labelText: 'YY-MM-DD',
                    prefixIcon: InkWell(
                      onTap: (){
                        _selectTodoDate(context);
                      },
                        child: Icon(Icons.calendar_today)
                    )
                ),
              ),

              DropdownButtonFormField(
                value: _selectedValue,
                items: _categories,
                hint:Text("Select one category") ,
                onChanged: (value){
                  setState(() {
                    _selectedValue = value;
                  });

                },


              ),

              RaisedButton(
                onPressed: () async {
                  _todo.title = _todoTitle.text;
                  _todo.description = _todoDescription.text;
                  _todo.todoDate = _todoDate.text;
                  _todo.category = _selectedValue.toString();

                  var result = await  _todoService.saveTodo(_todo);

                  if(result!=null){
                    print('hi dear');
                  }


                },
                child: Text("Save"),
              )
            ],
          )
        ],
      ),
    );
  }
}
