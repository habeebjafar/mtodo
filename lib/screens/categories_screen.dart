import 'package:flutter/material.dart';
import 'package:mtodo/models/category.dart';
import 'package:mtodo/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

 Category _category = Category();
 CategoryService _categoryService =CategoryService();

  var _categoryName = TextEditingController();
  var _categoryDescription = TextEditingController();

  List<Category> _categoryList = List<Category>();

  var _editCategoryName = TextEditingController();

  var _editCategoryDescription = TextEditingController();

  var category;


  void initState(){
    super.initState();
    getAllCategories();
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

      getAllCategories() async{
    _categoryList = List<Category>();
    var allCategories = await _categoryService.getCategories();
    allCategories.forEach((category){
      setState(() {
        var cModel = Category();
        cModel.name = category['name'];
        cModel.id = category['id'];
        cModel.description = category['description'];
        _categoryList.add(cModel);
      });

    });

  }

  _showFormInDialog(BuildContext context) {
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
            onPressed:(){
              Navigator.pop(context);
            } ,
            child: Text("Cancel"),
          ),
          FlatButton(
            onPressed:() async {
              _category.name = _categoryName.text;
              _category.description = _categoryDescription.text;
              var result = await _categoryService.saveCategory(_category);
              if(result>0){
                Navigator.pop(context);
                getAllCategories();
                _showSnackBar (Text('successfully added'));
              }
              print(result);
            } ,
            child: Text("Save"),
          ),
        ],
        title: Text("Category form"), content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _categoryName,
              decoration: InputDecoration(
                labelText: "Category name",
                hintText: "write cateory name"
              ),
            ),

            TextField(
              controller: _categoryDescription,
              decoration: InputDecoration(
                  labelText: "Category description",
                  hintText: "write cateory description"
              ),
            )
          ],
        ),

      ),
      );
    });
  }

 _editCategoryDialog(BuildContext context) {
   return showDialog(context: context, barrierDismissible: true, builder: (param){
     return AlertDialog(
       actions: <Widget>[
         FlatButton(
           onPressed:(){
             Navigator.pop(context);
           } ,
           child: Text("Cancel"),
         ),
         FlatButton(
           onPressed:() async {
             _category.id = category[0]['id'];
             _category.name = _editCategoryName.text;
             _category.description = _editCategoryDescription.text;
             var result = await _categoryService.updateCategory(_category);
             if(result>0){
               Navigator.pop(context);
               getAllCategories();
               _showSnackBar (Text('successfully upadated'));
             };
             print(result);
           } ,
           child: Text("Update"),
         ),
       ],
       title: Text("Category edit form"), content: SingleChildScrollView(
       child: Column(
         children: <Widget>[
           TextField(
             controller: _editCategoryName,
             decoration: InputDecoration(
                 labelText: "Category name",
                 hintText: "write cateory name"
             ),
           ),

           TextField(
             controller: _editCategoryDescription,
             decoration: InputDecoration(
                 labelText: "Category description",
                 hintText: "write cateory description"
             ),
           )
         ],
       ),

     ),
     );
   });
 }


 _deleteCategoryDialog(BuildContext context, categoryId) {
   return showDialog(context: context, barrierDismissible: true, builder: (param){
     return AlertDialog(
       actions: <Widget>[
         FlatButton(
           onPressed:(){
             Navigator.pop(context);
           } ,
           color: Colors.green,
           child: Text("Cancel", style: TextStyle(color: Colors.white),),
         ),
         FlatButton(
           onPressed:()  {
             var deleteItem = _categoryService.deleteCategory(categoryId);
             if(deleteItem != null){
               getAllCategories();
               Navigator.pop(context);
               _showSnackBar(Text("succeffully deleted"));
             }
           } ,
           color: Colors.red,
           child: Text("Delete", style: TextStyle(color: Colors.white),),
         ),
       ],
       title: Text("Are you sure you want to delete"),
     );
   });
 }

 _editCategory(BuildContext context, categoryId) async{

     category = await _categoryService.getCategoryById(categoryId);
    setState(() {
      _editCategoryName.text = category[0]['name'] ?? 'no name';
      _editCategoryDescription.text = category[0]['description'] ?? 'no description';
    });

    _editCategoryDialog(context);

 }

 _showSnackBar (message){
        var _snackBar = SnackBar(
          content: message,
          duration: Duration(milliseconds: 2000),
        );
        _scaffoldKey.currentState.showSnackBar(_snackBar);
 }

  @override
  Widget build(BuildContext context) {
   // getAllCategories();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Categories"),
        leading: RaisedButton(
          elevation: 0.0,
          color: Colors.red,
          child: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: ()=>Navigator.pop(context),
        ),
      ),

     body:  ListView.builder(
           itemCount: _categoryList.length,
             itemBuilder: (BuildContext, index){
             return Card(
                 child: ListTile(
                   leading: IconButton(icon: Icon(Icons.edit), onPressed: (){
                     _editCategory(context,_categoryList[index].id);

                   },
                   ),
                   title: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text(_categoryList[index].name,),
                       IconButton(
                         icon: Icon(Icons.delete),
                         onPressed: (){
                           _deleteCategoryDialog(context, _categoryList[index].id);

                           },
                       ),
                     ],
                   ),
                 )
             );
             }
         ),

         /*  Column(
           children: <Widget>[
             Card(
                 child: ListTile(
                   leading: IconButton(icon: Icon(Icons.edit), onPressed: (){},),
                   title: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text(_categoryList[index].name,),
                       IconButton(icon: Icon(Icons.delete), onPressed: (){},),
                     ],
                   ),
                 )
             )
           ],
         );*/


     floatingActionButton: FloatingActionButton(
       onPressed: ()=> _showFormInDialog(context),
       child: Icon(Icons.add),
     ),
    );
  }
}
