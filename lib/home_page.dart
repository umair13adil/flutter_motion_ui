import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_complex_ui/painter_bottom.dart';
import 'package:google_fonts/google_fonts.dart';

import 'painter_top.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> list_1 = [
    'assets/images/car_1.jpg',
    'assets/images/car_2.jpg',
    'assets/images/car_3.jpg',
    'assets/images/car_4.jpeg'
  ];

  List<String> list_2 = [
    'assets/images/car_5.jpeg',
    'assets/images/car_6.jpeg',
    'assets/images/car_7.jpeg',
    'assets/images/car_8.jpg',
    'assets/images/car_9.webp',
    'assets/images/car_10.webp',
    'assets/images/car_11.jpg',
    'assets/images/car_12.jpg',
    'assets/images/car_13.jpg',
    'assets/images/car_14.jpg',
    'assets/images/car_15.png'
  ];

  var shouldSwitch = false;
  var isSuccessful = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        CustomPaint(
          child: Container(
            height: 250.0,
          ),
          painter: BottomPainter(context: context),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CustomPaint(
                  child: Container(
                    height: 150.0,
                  ),
                  painter: TopPainter(context: context),
                ),
                Positioned(
                  left: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                    child: IconButton(
                      color: Colors.white,
                      iconSize: 35.0,
                      icon: Icon(Icons.menu),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 300.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: list_1
                          .map((e) => _buildListItem(
                              list_1.indexOf(e), list_1.indexOf(e) * 20.0))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Top Cars",
                        style: GoogleFonts.lato(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    height: 150.0,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: list_2.length,
                        itemBuilder: (context, index) => AnimatedContainer(
                              duration: Duration(milliseconds: 700),
                              child: Card(
                                color: Colors.transparent,
                                elevation: 12.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    list_2[index],
                                    height: 150.0,
                                    width: 150.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )),
                  )
                ],
              ),
            )
          ],
        ),
        _buildDrawer(MediaQuery.of(context).size.height * 0.60),
      ],
    ));
  }

  Widget _buildListItem(int index, double padding) {
    var isFirst = index == list_1.length - 1;
    var scaleFactor = 21.5;
    return Positioned(
      right: padding,
      child: isFirst
          ? Draggable(
              data: list_1[index],
              axis: Axis.horizontal,
              feedback: _buildChild(index, scaleFactor),
              childWhenDragging: Container(),
              onDragStarted: () {
                shouldSwitch = true;
              },
              onDraggableCanceled: (Velocity velocity, Offset offset) {
                if (shouldSwitch) {
                  setState(() {
                    list_1 = rotate(list_1, 1);
                  });
                  shouldSwitch = false;
                }
              },
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 600),
                child: _buildChild(index, scaleFactor),
              ),
            )
          : AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              child: _buildChild(index, scaleFactor),
            ),
    );
  }

  Widget _buildChild(int index, double scaleFactor) {
    return Card(
      color: Colors.transparent,
      elevation: 12.0,
      child: Container(
        height: getDecrementalPaddingValue(list_1, index) * scaleFactor,
        width: getDecrementalPaddingValue(list_1, index) * scaleFactor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Image.asset(
            list_1[index],
            height: 300.0,
            width: 300.0,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  List<Object> rotate(List<Object> list, int v) {
    if (list == null || list.isEmpty) return list;
    var i = v % list.length;
    return list.sublist(i)..addAll(list.sublist(0, i));
  }

  double getDecrementalPaddingValue(List<Object> list, int index) {
    var size = list.length;
    var padding = 0.0;
    for (int i = size; i > 0; i--) {
      if (index == i) {
        padding = i + 10.0;
      }
    }
    return padding;
  }

  Widget _buildDrawer(double height) {
    return Center(
      child: Visibility(
        visible: false,
        child: AnimatedAlign(
          duration: Duration(milliseconds: 600),
          alignment: Alignment.centerLeft,
          child: ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            child: Card(
              shape: Border.all(
                  color: Colors.white, width: 5, style: BorderStyle.solid),
              color: Colors.purple.withOpacity(0.67),
              elevation: 12.0,
              margin: EdgeInsets.all(10.0),
              child: Container(height: height, width: 220.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
