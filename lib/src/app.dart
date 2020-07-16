import 'package:flutter/material.dart';
import 'package:mtodo/screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: HomeScreen(),
    );
  }
}
