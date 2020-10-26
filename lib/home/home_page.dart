import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:podrinho_app/widgets/banner_widget_area.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Future<List<Widget>> createList() async {
      List<Widget> items = new List<Widget>();
      String dataString =
          await DefaultAssetBundle.of(context).loadString("assets/data.json");
      List<dynamic> dataJSON = jsonDecode(dataString);

      dataJSON.forEach((object) {
        String finalString = "";
        List<dynamic> dataList = object["placeItems"];
        dataList.forEach((item) {
          finalString = finalString + item + " | ";
        });

        items.add(Padding(
          padding: EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2.0,
                      blurRadius: 5.0),
                ]),
            margin: EdgeInsets.all(5.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  child: Image.asset(
                    object["placeImage"],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(object["placeName"]),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: Text(
                            finalString,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black54,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          "Compra mínima de: ${object["minOrder"]}",
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      });

      return items;
    }

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.menu), onPressed: () {}),
                    Text(
                      "Podrinho",
                      style: TextStyle(fontSize: 50, fontFamily: "Samantha"),
                    ),
                    IconButton(icon: Icon(Icons.person), onPressed: () {})
                  ],
                ),
              ),
              BannerWidgetArea(),
              Container(
                child: FutureBuilder(
                    initialData: <Widget>[Text("")],
                    future: createList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: snapshot.data,
                          ),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              )
            ],
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.black,
          child: Icon(
            MdiIcons.food,
            color: Colors.white,
          )),
    );
  }
}
