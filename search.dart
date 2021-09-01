
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

class Search extends StatefulWidget {
  final Map<String, Map<String, dynamic>> products;
  final List<String> searchHistory;
  Search({Key key, this.products, this.searchHistory}) : super(key: key);

  @override
  _SearchState createState() => _SearchState(this.products, this.searchHistory);
}

class _SearchState extends State<Search> {
  Map<String, Map<String, dynamic>> products;
  final List<String> searchHistory;
  _SearchState(this.products, this.searchHistory);
  final textController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  bool showCancel = false, showResult = false;

  void initState() {
    super.initState();
    textController.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          showCancel = true;
          showResult = false;
        } else {
          if (textController.text.isNotEmpty) {
            showCancel = false;
            showResult = true;
            if (searchHistory.first != textController.text) {
              searchHistory.removeLast();
              searchHistory.insert(0, textController.text);
            }
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          child:
                              ImageIcon(AssetImage('assets/icons/search.png')),
                          padding: EdgeInsets.symmetric(horizontal: 9),
                        ),
                        Flexible(
                          child: TextField(
                            controller: textController,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Krub_R',
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              hintText: 'Article name or keywords...',
                            ),
                          ),
                        ),
                        Align(
                          child: Container(
                            child: GestureDetector(
                              child:
                                  SvgPicture.asset('assets/icons/XCircle.svg'),
                              onTap: () {
                                textController.text = '';
                              },
                            ),
                            padding: EdgeInsets.all(7),
                          ),
                          alignment: Alignment.centerRight,
                        )
                      ],
                    ),
                    height: 39,
                    decoration: BoxDecoration(
                        color: Color(0xffEBEBEB),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
                ...?getCancelTextButton(),
              ],
            ),
            SizedBox(height: 10),
            SvgPicture.asset('assets/under_line.svg'),
            ...?getSearch(),
          ],
        ),
      ),
    );
  }

  List<Widget> getCancelTextButton() {
    if (showCancel) {
      return [
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Color(0xffBBD356),
              fontFamily: 'Krub_R',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          onPressed: () {
            setState(() {
              showCancel = false;
              FocusScope.of(context).unfocus();
            });
          },
        ),
      ];
    } else {
      return [SizedBox(width: 15)];
    }
  }

  List<Widget> getSearch() {
    if (textController.text == "") {
      return getSearchHistory();
    } else {
      if (showResult) {
        return getResultSearch();
      } else {
        return getSimilarSearch();
      }
    }
  }

  List<Widget> getSearchHistory() {
    List<Widget> allHistory = [];
    resultSearch.clear();
    for (String request in searchHistory) {
      allHistory += [
        Container(
            child: TextButton(
              child: Text(
                request,
                style: TextStyle(
                  color: Color(0xff5C5C5C),
                  fontFamily: 'Krub_R',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                textController.text = request;
                for (String request in products.keys) {
                  if (request.indexOf(textController.text) >= 0) {
                    resultSearch.add(request);
                    showAddButton.add(false);
                  }
                }
              },
              style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
              ),
            ),
            padding: EdgeInsets.only(left: 15)),
        Divider(height: 0.5),
      ];
    }
    return [
      Flexible(
        child: ListView(
          children: [
            Column(
                children: [...allHistory],
                crossAxisAlignment: CrossAxisAlignment.start),
          ],
        ),
      ),
    ];
  }

  List<String> resultSearch = [];
  List<bool> showAddButton = [];

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

  List<Widget> getSimilarSearch() {
    List<Widget> similarSearch = [];
    resultSearch.clear();
    for (String request in products.keys) {
      if (request.indexOf(textController.text) >= 0) {
        resultSearch.add(request);
        showAddButton.add(false);
        similarSearch += [
          Container(
              child: TextButton(
                child: Text(
                  request,
                  style: TextStyle(
                    color: Color(0xff5C5C5C),
                    fontFamily: 'Krub_R',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () {
                  textController.text = request;
                  FocusScope.of(context).unfocus();
                },
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                ),
              ),
              padding: EdgeInsets.only(left: 15)),
          Divider(height: 0.5),
        ];
      }
    }
    return [
      Flexible(
        child: ListView(
          children: [
            Column(
                children: [...similarSearch],
                crossAxisAlignment: CrossAxisAlignment.start),
          ],
        ),
      ),
    ];
  }

  sum(List<int> product) {
    int sum = 0;
    for (int count in product) {
      sum += count;
    }
    return sum;
  }
}


