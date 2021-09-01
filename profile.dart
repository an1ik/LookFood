import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/homepages/catalogue.dart';
import 'package:food/homepages/home.dart';
import 'package:food/screens/create_acc.dart';
import 'package:food/services/auth.dart';
import 'package:food/services/my_icons.dart';

import 'About.dart';
import 'homepage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Spacer(flex: 5),
            Expanded(
                flex: 29,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 24, bottom: 25),
                            child: Image(
                                image: AssetImage(
                                    'assets/images/profile_photo.jpg')),
                          )),
                      flex: 64,
                    ),
                    Expanded(
                      flex: 36,
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: FlatButton(
                                child: Container(
                                    child: SvgPicture.asset(
                                  "assets/icons/icon right.svg",
                                  height: 45,
                                  width: 45,
                                )),
                                onPressed: () {}),
                          )),
                    )
                  ],
                )),
            Expanded(
              flex: 26,
              child: Stack(children: <Widget>[
                Image(
                    image: AssetImage('assets/images/A_plus.png'),
                    width: double.infinity),
                Positioned(
                  child: Text(
                    'James\nCameron',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'HeliosAntique.ttf',
                      fontSize: 36,
                    ),
                  ),
                  left: 15,
                ),
              ]),
            ),
            Expanded(
                flex: 40,
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                              child: InkWell(
                                  child: SvgPicture.asset(
                                    "assets/Profile_preference.svg",
                                    width: 100,
                                    height: 100,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => About()),
                                    );
                                  })),
                        )),
                    Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                              child: InkWell(
                                  child: SvgPicture.asset(
                                    "assets/Profile_language.svg",
                                    width: 100,
                                    height: 100,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => About()),
                                    );
                                  })),
                        )),
                    Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                              child: InkWell(
                                  child: SvgPicture.asset(
                                    "assets/Profile_question.svg",
                                    width: 100,
                                    height: 100,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => About()),
                                    );
                                  })),
                        )),
                    Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                              child: InkWell(
                                  child: SvgPicture.asset(
                                    "assets/Profile_About.svg",
                                    width: 100,
                                    height: 100,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => About()),
                                    );
                                  })),
                        )),
                    Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                              child: InkWell(
                                  child: SvgPicture.asset(
                                    "assets/Profile_Logout.svg",
                                    width: 100,
                                    height: 100,
                                  ),
                                  onTap: () {
                                    AuthService().logOut();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                  })),
                        )),
                    Spacer()
                  ],
                )),
          ],
        ));
  }
}


category.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Category extends StatefulWidget {
  final Map<String, Map<String, dynamic>> products;
  final String whatSearch, whereSearch;
  Category({Key key, this.products, this.whatSearch, this.whereSearch})
      : super(key: key);

  @override
  _CategoryState createState() =>
      _CategoryState(this.products, this.whatSearch, this.whereSearch);
}

class _CategoryState extends State<Category> {
  final Map<String, Map<String, dynamic>> products;
  final String whatSearch, whereSearch;
  _CategoryState(this.products, this.whatSearch, this.whereSearch);
  List<String> resultSearch = [];
  List<bool> showAddButton = [];
  bool findOnce = false;

  @override
  Widget build(BuildContext context) {
    findSuitableProduct();
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          SizedBox(height: 10),
          Text(whatSearch,
              style: TextStyle(
                fontFamily: 'Krub_R',
                fontSize: 24,
              )),
          SizedBox(height: 17),
          SvgPicture.asset('assets/under_line.svg'),
          ...?getResultSearch(),
        ]),
      ),
      backgroundColor: Colors.white,
    );
  }

  void findSuitableProduct() {
    if (!findOnce) {
      for (String product in products.keys) {
        if (products[product][whereSearch] == whatSearch) {
          resultSearch.add(products[product]["product name"]);
          showAddButton.add(false);
        }
      }
      findOnce = true;
    }
  }

  List<Widget> getResultSearch() {
    return [
      Flexible(
          child: ListView.builder(
        itemCount: resultSearch.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SizedBox(height: 14),
              Row(
                children: [
                  SizedBox(width: 7),
                  Container(
                    height: 80,
                    width: 80,
                    child: Image(
                      image:
                          AssetImage(products[resultSearch[index]]["pictures"]),
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    height: 80,
                    child: Column(
                      children: [
                        Text(resultSearch[index]),
                        Container(
                          width: 140,
                          child: Row(
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    "${products[resultSearch[index]]["fat"]}",
                                    style: TextStyle(
                                        fontFamily: 'Krub_L',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffEBEBEB),
                                ),
                              ),
                              Container(
                                child: Center(
                                    child: Text(
                                  "${products[resultSearch[index]]["carbs"]}",
                                  style: TextStyle(
                                      fontFamily: 'Krub_L',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w200),
                                )),
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffBBD356)),
                              ),
                              Container(
                                child: Center(
                                    child: Text(
                                  "${products[resultSearch[index]]["protein"]}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Krub_L',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w200),
                                )),
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff4C610F)),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Spacer(),
                  ...?getAddButton(index),
                ],
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
              SizedBox(height: 14),
              SvgPicture.asset('assets/under_line.svg'),
            ],
          );
        },
      ))
    ];
  }

  List<Widget> getAddButton(int index) {
    if (showAddButton[index]) {
      return [
        Container(
          width: 90,
          height: 25,
          child: Row(children: [
            GestureDetector(
                child: Container(
                  width: 29,
                  height: 25,
                  child: SvgPicture.asset('assets/minus.svg'),
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffEBEBEB)),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.5),
                          bottomLeft: Radius.circular(12.5))),
                ),
                onTap: () {
                  setState(() {
                    if (products[resultSearch[index]]["quanity"].length != 0) {
                      if (products[resultSearch[index]]["measure"] == "g") {
                        if (products[resultSearch[index]]["quanity"].last >
                            100) {
                          products[resultSearch[index]]["quanity"].last -= 100;
                        } else {
                          if (products[resultSearch[index]]["quanity"].length >
                              1) {
                            products[resultSearch[index]]["quanity"].remove(
                                products[resultSearch[index]]["quanity"].last);
                            products[resultSearch[index]]["shelf life now"]
                                .remove(products[resultSearch[index]]
                                        ["shelf life now"]
                                    .last);
                          }
                        }
                      } else {
                        if (products[resultSearch[index]]["quanity"].last > 1) {
                          products[resultSearch[index]]["quanity"].last -= 1;
                        } else {
                          if (products[resultSearch[index]]["quanity"].length >
                              1) {
                            products[resultSearch[index]]["quanity"].remove(
                                products[resultSearch[index]]["quanity"].last);
                            products[resultSearch[index]]["shelf life now"]
                                .remove(products[resultSearch[index]]
                                        ["shelf life now"]
                                    .last);
                          }
                        }
                      }
                    }
                  });
                }),
            Container(
              width: 32,
              height: 25,
              child: FittedBox(
                child: Center(
                  child:
                      Text('${sum(products[resultSearch[index]]["quanity"])}x'),
                ),
                fit: BoxFit.scaleDown,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffEBEBEB)),
              ),
            ),
            GestureDetector(
              child: Container(
                width: 29,
                height: 25,
                child: SvgPicture.asset('assets/plus.svg'),
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Color(0xffBBD356),
                    border: Border.all(color: Color(0xffEBEBEB)),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12.5),
                        bottomRight: Radius.circular(12.5))),
              ),
              onTap: () {
                setState(() {
                  if (products[resultSearch[index]]["measure"] == "g") {
                    if (products[resultSearch[index]]["shelf life now"].last ==
                        products[resultSearch[index]]["period of storage"]) {
                      products[resultSearch[index]]["quanity"].last += 100;
                    } else {
                      products[resultSearch[index]]["quanity"].add(100);
                      products[resultSearch[index]]["shelf life now"].add(
                          products[resultSearch[index]]["period of storage"]);
                    }
                  } else {
                    if (products[resultSearch[index]]["shelf life now"].last ==
                        products[resultSearch[index]]["period of storage"]) {
                      products[resultSearch[index]]["quanity"].last += 1;
                    } else {
                      products[resultSearch[index]]["quanity"].add(1);
                      products[resultSearch[index]]["shelf life now"].add(
                          products[resultSearch[index]]["period of storage"]);
                    }
                  }
                });
              },
            ),
          ], mainAxisAlignment: MainAxisAlignment.center),
        ),
        Spacer(),
      ];
    } else {
      return [
        GestureDetector(
          child: Container(
            child: Stack(children: [
              Positioned(
                child: Container(
                  width: 25,
                  height: 25,
                  child: SvgPicture.asset('assets/plus.svg'),
                  decoration: BoxDecoration(
                    color: Color(0xffBBD356),
                    shape: BoxShape.circle,
                  ),
                ),
                left: 0,
                bottom: 0,
              ),
              Positioned(
                child: Container(
                  width: 30,
                  height: 20,
                  child: FittedBox(
                    child: Center(
                      child: Text(
                        '${sum(products[resultSearch[index]]["quanity"])}x',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Krub_R',
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(64))),
                ),
                right: 2,
              )
            ]),
            width: 44,
            height: 38,
          ),
          onTap: () {
            setState(() {
              showAddButton[index] = true;
              Timer(Duration(seconds: 3), () {
                setState(() {
                  showAddButton[index] = false;
                });
              });
            });
          },
        )
      ];
    }
  }
  sum(List<int> product) {
    int sum = 0;
    for (int count in product) {
      sum += count;
    }
    return sum;
  }
}
