import 'package:Ethos/home_page.dart';
import 'package:Ethos/menu/notifications.dart';
import 'package:flutter/material.dart';
import 'menu/menu.dart';
import 'home_page.dart';
import 'databaseFiles/database_helpers.dart';


void main() async{
  // Inicjalizacja bazy danych
  await initHive();
  // Usługa notyfikacji
  NotificationSchedule().init();
  // Aplikacja
  runApp(Ethos());
}

class Ethos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.indigo),
      home: _HomeView(),
    );
  }
}


// Widget "matka"
class _HomeView extends StatelessWidget {

  final _pageController = PageController(initialPage: 0);
  var _currentPage = 0;
  final _pageMatrix = [1, 0];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ethos'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {
              _pageController.animateToPage(_pageMatrix[_currentPage], duration: const Duration(milliseconds: 550), curve: Curves.easeInOut);
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
          _currentPage = num;
        },
      ),
      );
  }

}



