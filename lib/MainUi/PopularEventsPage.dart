import 'package:exam/data/concertdata.dart';
import 'package:flutter/material.dart';

class PopularEventsPage extends StatefulWidget {
  int indeks;

  PopularEventsPage(this.indeks);

  @override
  _PopularEventsPageState createState() => _PopularEventsPageState();
}

class _PopularEventsPageState extends State<PopularEventsPage> {
  var key0 = GlobalKey<FormFieldState>();
  String? nameInput0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            elevation: 0,
            shadowColor: Colors.black,
            //title: Text("Sliver App Bar"),
            //backgroundColor: Colors.cyanAccent,
            expandedHeight: 360.0,
            floating: true,
            pinned: true,
            snap: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
                //StretchMode.blurBackground,
                StretchMode.fadeTitle
              ],
              centerTitle: true,
              background: Image.network(
                "${Concert.image[widget.indeks]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 7.0,),
                  Container(
                    child: Text(
                      "${Concert.name[widget.indeks]}",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600),
                    ),
                    margin: EdgeInsets.only(left: 20.0, bottom: 10.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, bottom: 10.0),
                    child: Text(
                      "${Concert.time[widget.indeks]}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Container(
                    height: 55.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 10.0),
                          alignment: Alignment.center,
                          height: 40.0,
                          width: 100.0,
                          child: Text(
                            "About",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 10.0),
                          alignment: Alignment.center,
                          height: 40.0,
                          width: 160.0,
                          child: Text(
                            "Participants",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 10.0),
                          alignment: Alignment.center,
                          height: 40.0,
                          width: 150.0,
                          child: Text(
                            "Location",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0,right: 10.0,top: 15.0),
                    child: Text(
                      """${Concert.data[widget.indeks]} 
                    """,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Buy tickets for \$${Concert.ticetPrice[widget.indeks]}",
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
                        margin:
                            EdgeInsets.symmetric(vertical: 5.0),
                      ),
                      onTap: (){
                        print("sdds");
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Save for later",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        margin:
                        EdgeInsets.symmetric( vertical: 5.0),
                      ),
                        onTap: (){
                        print("sdsds");
                        }
                    ),
                  ),
                ],
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}



