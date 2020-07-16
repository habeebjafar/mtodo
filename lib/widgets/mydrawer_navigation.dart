import 'package:flutter/material.dart';
import 'package:mtodo/screens/categories_screen.dart';
import 'package:mtodo/screens/home_screen.dart';

class MyDrawerNavigation extends StatefulWidget {
  @override
  _MyDrawerNavigationState createState() => _MyDrawerNavigationState();
}

class _MyDrawerNavigationState extends State<MyDrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("M Todo"),
              accountEmail: Text("Category and priority based app"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                 backgroundColor: Colors.black54,
                  child: Icon(Icons.filter_list, color: Colors.white,),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),

            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => HomeScreen()
                ));
              },
            ),

            ListTile(
              title: Text("Categories"),
              leading: Icon(Icons.category),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (_) => CategoriesScreen()
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
