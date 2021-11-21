import 'package:ecom/screens/cart.dart';
import 'package:flutter/material.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'screens/home.dart';
import 'package:ecom/screens/sample.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final title = 'Oman Phone';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        drawer: SafeArea(
            child: Drawer(
          child:
              DrawerHeader(child: Text("Personal Details will be shown here")),
        )),
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(MyApp.title),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
              ),
            ),
          ],
        ),
        body: _currentIndex == 0 ? Home() : SamplePage(),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.search),
              title: Text("Search"),
              selectedColor: Colors.pink,
            ),

            /// Cat
            SalomonBottomBarItem(
              icon: Icon(Icons.category),
              title: Text("Categories"),
              selectedColor: Colors.orange,
            ),

            /// Cart
            SalomonBottomBarItem(
              icon: Icon(Icons.settings),
              title: Text("settings"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}
