import 'package:exam/bottomBarUi/bottombar2.dart';
import 'package:exam/bottomBarUi/bottombar3.dart';
import 'package:exam/bottomBarUi/bottombar4.dart';
import 'package:exam/data/categoriesData.dart';
import 'package:exam/data/concertdata.dart';
import 'package:exam/models/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:exam/models/picture.dart';

class ExploreEventsPage extends StatefulWidget {
  const ExploreEventsPage({Key? key}) : super(key: key);

  @override
  _ExploreEventsPageState createState() => _ExploreEventsPageState();
}

class _ExploreEventsPageState extends State<ExploreEventsPage> {
  DataBaseHelper? dataBaseHelper;
  List<Widget>? bottomBarBodilar;
  List<Picture>? allPicture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bottomBarBodilar = [
      //home
      uiBody(),
      //search
      BottomBar2(),
      //my orders
      BottomBar3(),
      //profile
      BottomBar4(),
    ];
    dataBaseHelper = DataBaseHelper();
    allPicture = <Picture>[];
    dataBaseHelper!.takePicture().then((mobiledata){
      for(var readData in mobiledata){
        allPicture!.add(Picture.fromMap(readData));
      }
      setState(() {
      });
    });



  }

  final ScrollController listViewController = new ScrollController();
  int _selectedIndex = 0;
  List<Picture>? allpicture;



  allFunction(String image) async {
    dataBaseHelper!.takeUrl(image).then((value) {
      return dataBaseHelper!.addPicture(Picture("Rasm 1", value)).then((value) {
        dataBaseHelper!.takePicture().then((mobileData) {
          for (var readData in mobileData) {
            allpicture!.add(Picture.fromMap(readData));
          }
          setState(() {});
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    bottomBarBodilar = [
      //home
      uiBody(),
      //search
      BottomBar2(),
      //my orders
      BottomBar3(),
      //profile
      BottomBar4(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SnappingSheet(
        // TODO: Add your content that is placed
        // behind the sheet. (Can be left empty)
        child: bottomBarBodilar![_selectedIndex],
        grabbingHeight: 75,
        // TODO: Add your grabbing widget here,
        grabbing: myGrabbingWidget(),
        sheetBelow: SnappingSheetContent(
          draggable: true,
          // TODO: Add your sheet content here
          child: MySheetPage(),
        ),
      ),
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: Colors.black,
        animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        showElevation: false,

        // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            activeColor: Colors.blue,
            icon: Icon(
              Icons.event,
            ),
            title: Text(
              'Explore',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          FlashyTabBarItem(
            activeColor: Colors.blue,
            icon: Icon(Icons.calendar_today_outlined),
            title: Text(
              'Calendar',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          FlashyTabBarItem(
            activeColor: Colors.blue,
            icon: Icon(Icons.airplane_ticket),
            title: Text(
              'Tickets',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          FlashyTabBarItem(
            activeColor: Colors.blue,
            icon: Icon(Icons.settings),
            title: Text(
              "Settings",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget uiBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 25.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "NOVEMBER 20, 9:31 PM",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Container(
                    child: Text(
                      "Explore events",
                      style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 25.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1534308143481-c55f00be8bd7?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2lkZSUyMHByb2ZpbGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80",
                      ),
                      radius: 25.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
              color: Colors.grey.shade800,
            ),
            margin: EdgeInsets.only(
              right: 25.0,
              top: 15.0,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.grey,
                focusColor: Colors.white,
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.lightBlueAccent,
                            Colors.purpleAccent,
                            Colors.red,
                          ]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: Icon(
                      Icons.filter,
                    ),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {});
                  },
                ),
                labelText: 'Search...',
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                child: Text(
                  "POPULAR",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: 150.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(0),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/PopularEventsPage/$index");
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Text(
                                  "Concert",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 18.0,
                                  ),
                                ),
                                margin: EdgeInsets.only(
                                  left: 20.0,
                                  bottom: 2.0,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${Concert.name[index]}",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                margin:
                                    EdgeInsets.only(left: 20.0, bottom: 10.0),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          Column(
                            children: [
                              Padding(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    color: Colors.white,
                                  ),
                                  height: 40.0,
                                  width: 40.0,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text("${Concert.month[index]}"),
                                        margin: EdgeInsets.only(top: 4.0),
                                      ),
                                      Container(
                                        child: Text(
                                          "${Concert.date[index]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                padding:
                                    EdgeInsets.only(right: 10.0, top: 10.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "${Concert.image[index]}"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Colors.red,
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                      width: 210.0,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                child: Text(
                  "FOR YOU",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 120.0,
            width: 330.0,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Colors.white,
                        ),
                        height: 50.0,
                        width: 50.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 14.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://therockandblues.com/wp-content/uploads/2018/07/tickets.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        left: 25.0,
                        right: 10.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Claim 3 free tickets!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      margin: EdgeInsets.only(
                        left: 10.0,
                        bottom: 5.0,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Open a Premium account and",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      margin: EdgeInsets.only(
                        left: 10.0,
                      ),
                    ),
                    Container(
                      child: Text(
                        "get 3 tickets instantly.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      margin: EdgeInsets.only(left: 10.0, bottom: 30.0),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.lightBlueAccent,
                    Colors.purpleAccent,
                    Colors.red,
                  ]),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Container(
                child: Text(
                  "CATEGORIES",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: 60.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(0),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(7.0),
                                    ),
                                    color: Colors.white,
                                  ),
                                  height: 35.0,
                                  width: 35.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "${CategoriesData.images[index]}",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "${CategoriesData.name[index]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                                margin: EdgeInsets.only(
                                  left: 1.0,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${CategoriesData.numberOfEvents[index]} events",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                                margin:
                                    EdgeInsets.only(left: 2.0, bottom: 13.0),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Colors.grey.shade800,
                      ),
                      margin: EdgeInsets.only(right: 10.0),
                      width: 150.0,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myGrabbingWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 50,
            height: 7,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            color: Colors.grey[200],
            height: 2,
            margin: EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
          )
        ],
      ),
    );
  }
}

class MySheetPage extends StatefulWidget {
  const MySheetPage({Key? key}) : super(key: key);

  @override
  _MySheetPageState createState() => _MySheetPageState();
}

class _MySheetPageState extends State<MySheetPage> {
  RangeValues _currentRangeValues = const RangeValues(50, 90);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text("Filter Events"),
            ),
            Container(
              child: Text(
                "LOCATION",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  color: Colors.grey.shade800,
                ),
                margin: EdgeInsets.only(top: 15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '  Los Angelas California',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    child: Text(
                      "Localize me",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                "EVENT CATEGORY",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 70.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(0),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/OngeneratePage1/$index");
                      },
                      child: Container(
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(7.0),
                                          ),
                                          color: Colors.white,
                                        ),
                                        height: 35.0,
                                        width: 35.0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0, vertical: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "${CategoriesData.images[index]}",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "${CategoriesData.name[index]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      margin: EdgeInsets.only(
                                        left: 1.0,
                                      ),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              ],
                            ),
                            Positioned(
                              right: 1,
                              child: Container(
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Colors.grey.shade800,
                        ),
                        margin: EdgeInsets.only(right: 10.0),
                        width: 145.0,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 70.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(0),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/OngeneratePage1/$index");
                      },
                      child: Container(
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(7.0),
                                          ),
                                          color: Colors.white,
                                        ),
                                        height: 35.0,
                                        width: 35.0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0, vertical: 8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "${CategoriesData.images[3+index]}",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "${CategoriesData.name[3+index]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      margin: EdgeInsets.only(
                                        left: 1.0,
                                      ),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              ],
                            ),
                            Positioned(
                              right: 1,
                              child: Container(
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Colors.grey.shade800,
                        ),
                        margin: EdgeInsets.only(right: 10.0),
                        width: 130.0,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0, right: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "TICKET PRICE",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "\$50 - \$90",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Expanded(
                child: RangeSlider(
                  values: _currentRangeValues,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 60.0,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Apply filters",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.lightBlueAccent,
                          Colors.purpleAccent,
                          Colors.red,
                        ]),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                ),
                onTap: () {
                  print("sdds");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
