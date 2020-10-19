import 'package:Ethos/home_page.dart';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'home_page.dart';
import 'databaseFiles/database_helpers.dart';


void main() async{ // TODO splash screen to load assets?
  initHive();
  runApp(Ethos());
}

class Ethos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.indigo),
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final _pageController = PageController(initialPage: 0);
  var currentPage = 0;
  final pageMatrix = [1, 0];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Ethos')),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {
              _pageController.animateToPage(pageMatrix[currentPage], duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
            },
          )
        ],
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        children: [
          HomePage(),
          Menu(),
        ],
        onPageChanged: (num) {
          currentPage = num;
        },
      ),
      );
  }
}


