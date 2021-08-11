import 'package:exam/MainUi/PopularEventsPage.dart';
import 'package:exam/loginPageUI/homePage.dart';
import 'package:flutter/material.dart';

import 'bottomBarUi/bottombar4.dart';

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  //bool _toggled = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: toggled ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        List<String> path = settings.name.toString().split("/");
        if (path[1] == "PopularEventsPage") {
          return MaterialPageRoute(
            builder: (context) => PopularEventsPage(
              int.parse(path[2]),
            ),
          );
        }
      },
      home: HomePage(),
    );
  }
}

