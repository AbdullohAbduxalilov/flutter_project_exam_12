import 'package:exam/MainUi/PopularEventsPage.dart';
import 'package:exam/MainUi/exploreEventsPage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreEventsPage(),
    );
  }
}