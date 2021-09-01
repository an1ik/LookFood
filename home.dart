import 'package:flutter/material.dart';
import 'package:food/homepages/product_details.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/services/my_icons.dart';

class Home extends StatefulWidget {
  final Map<String, Map<String, dynamic>> products;
  Home({Key key, this.products}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(this.products);
}

class _HomeState extends State<Home> {
  Map<String, Map<String, dynamic>> products;
  _HomeState(this.products);
  @override
  Widget build(BuildContext context) {
    DateTime timeNow = DateTime.now();
    return Container(
      child: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Image(
                  image: AssetImage('assets/fridge.jpg'), fit: BoxFit.fitWidth),
              SvgPicture.asset('assets/Food.svg', fit: BoxFit.none),
              SizedBox(height: 30),
              ...?getAllProducts()
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> getAllProducts() {
    List<Widget> productsCard = [];
    List<Widget> rows = [];
    int indexCard = 0;
    for (Map<String, dynamic> product in products.values) {
      rows.add(getProductContainer(product));
      indexCard++;
      if (indexCard % 2 == 0) {
        productsCard.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rows,
        ));
        productsCard.add(SizedBox(height: 15));
        rows = [];
      }
    }
    if (rows.length > 0) {
      productsCard.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rows,
      ));
    }
    return productsCard;
  }

  Widget getProductContainer(Map<String, dynamic> product) {
    return InkWell(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetails(product: product)))
            .then((_product) {
          setState(() {
            if (_product == null) {
              for (Map<String, dynamic> product in products.values) {
                if (product["quanity"].isEmpty) {
                  products.remove(product["product name"]);
                  break;
                }
              }
            } else {
              if (_product["quanity"].isEmpty) {
                products.remove(_product["product name"]);
              }
            }
          });
        });
      },
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width * 0.4,
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            decoration: BoxDecoration(
              color: Color(0xff6F9648),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[600],
                  blurRadius: 17.0,
                ),
              ],
            ),
          ),
          Positioned(
            child: Container(
              child: Column(
                children: [
                  Align(
                    child: Text(
                      product["product name"],
                      style: TextStyle(
                          fontFamily: 'HeliosAnique',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Spacer(flex: 4),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                "x ${sum(product["quanity"])}${product["measure"]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Krub_L',
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "${product["shelf life now"][0]} days left",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Krub_L',
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 7),
                              LinearProgressIndicator(
                                value: product["shelf life now"][0] /
                                    product["period of storage"],
                                backgroundColor: Color(0xffc4c4c4),
                                valueColor:
                                    AlwaysStoppedAnimation(Color(0xff637C4A)),
                              ),
                            ],
                          ),
                        ),
                        flex: 6,
                      ),
                    ],
                  ),
                  Spacer(flex: 2)
                ],
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
              height: MediaQuery.of(context).size.width * 0.26,
              width: MediaQuery.of(context).size.width * 0.4,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                color: Color(0xffF8F8F8),
                border: Border.all(color: Color(0xffc1c1c1), width: 0.3),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            right: 0,
            top: 0,
          ),
          Positioned(
            child: IconButton(
              icon: Icon(MyIcons.cross),
              color: Colors.white,
              iconSize: 32,
              onPressed: () {
                setState(() {
                  products.remove(product["product name"]);
                });
              },
            ),
            left: MediaQuery.of(context).size.width * 0.02,
            bottom: MediaQuery.of(context).size.width * 0.02,
          ),
          Positioned(
            child: TextButton(
              child: Text(
                'add',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'HeliosAnique',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all<Color>(Color(0x22c0c0c0))),
              onPressed: () {
                setState(() {
                  if (product["measure"] == "g") {
                    if (product["shelf life now"].last ==
                        product["period of storage"]) {
                      product["quanity"].last += 100;
                    } else {
                      product["quanity"].add(100);
                      product["shelf life now"]
                          .add(product["period of storage"]);
                    }
                  } else {
                    if (product["shelf life now"].last ==
                        product["period of storage"]) {
                      product["quanity"].last += 1;
                    } else {
                      product["quanity"].add(1);
                      product["shelf life now"]
                          .add(product["period of storage"]);
                    }
                  }
                });
              },
            ),
            right: MediaQuery.of(context).size.width * 0.02,
            bottom: MediaQuery.of(context).size.width * 0.02,
          ),
          Positioned(
            child: Image(
              image: AssetImage(product["pictures"]),
            ),
            top: MediaQuery.of(context).size.width * 0.08,
            left: MediaQuery.of(context).size.width * 0.04,
          ),
        ],
      ),
      highlightColor: Colors.grey[100],
      borderRadius: BorderRadius.all(Radius.circular(15)),
    );
  }

  sum(List<int> product) {
    int sum = 0;
    for (int count in product) {
      sum += count;
    }
    return sum;
  }
}


catalogue.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/screens/category.dart';

class Catalogue extends StatefulWidget {
  final Map<String, Map<String, dynamic>> products;
  Catalogue({Key key, this.products}) : super(key: key);

  @override
  _CatalogueState createState() => _CatalogueState(this.products);
}

class _CatalogueState extends State<Catalogue> {
  Map<String, Map<String, dynamic>> products;
  _CatalogueState(this.products);
  int indexBefore;
  bool showResult = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 10),
          Text('Catalogue',
              style: TextStyle(
                fontFamily: 'Krub_R',
                fontSize: 24,
              )),
          SizedBox(height: 17),
          SvgPicture.asset('assets/under_line.svg'),
          Expanded(
            child: ListView.builder(
              itemCount: catalogue.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(height: 17),
                    GestureDetector(
                      child: Row(
                        children: [
                          Container(
                            child:
                                SvgPicture.asset(catalogue[index]["picture"]),
                            width: 80,
                            alignment: Alignment.center,
                          ),
                          Text(catalogue[index]["text"],
                              style: TextStyle(
                                color: Color(catalogue[index]["color"]),
                                fontFamily: 'Krub_L',
                                fontSize: 22,
                                fontWeight: FontWeight.w300,
                              ))
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          if (index == indexBefore) {
                            catalogue[indexBefore]["show"] = false;
                            catalogue[indexBefore]["color"] = 0xff5C5C5C;
                            indexBefore = null;
                          } else {
                            if (indexBefore != null) {
                              catalogue[indexBefore]["show"] = false;
                              catalogue[indexBefore]["color"] = 0xff5C5C5C;
                            }
                            catalogue[index]["show"] = true;
                            catalogue[index]["color"] = 0xff000000;
                            indexBefore = index;
                          }
                        });
                      },
                    ),
                    ...getSubcategories(index, catalogue[index]["show"])
                  ],
                );
              },
            ),
          )
        ],
      )),
    );
  }

  List<Widget> getSubcategories(int index, bool show) {
    String whatSearch, whereSearch;
    List<Widget> subcategories = [];
    if (show) {
      for (String subcategory in catalogue[index]["subcategories"]) {
        subcategories += [
          SizedBox(height: 15),
          GestureDetector(
              child: Text(subcategory,
                  style: TextStyle(
                    color: Color(0xff5C5C5C),
                    fontFamily: 'Krub_L',
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  )),
              onTap: () {
                if (subcategory == "All products") {
                  whatSearch = catalogue[index]["text"];
                  whereSearch = "category";
                } else {
                  whatSearch = subcategory;
                  whereSearch = "subcategory";
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Category(
                            products: products, whatSearch: whatSearch, whereSearch: whereSearch)));
              })
        ];
      }
      return [
        Row(
          children: [
            SizedBox(width: 60),
            Container(
              child: VerticalDivider(color: Colors.black),
              height:
                  (15 + (15 + 16) * catalogue[index]["subcategories"].length)
                      .toDouble(),
            ),
            SizedBox(width: 10),
            Column(
                children: [...subcategories],
                crossAxisAlignment: CrossAxisAlignment.start),
          ],
        )
      ];
    } else {
      return [];
    }
  }

  List<Map<String, dynamic>> catalogue = [
    {
      "picture": "assets/catalogue/milk.svg",
      "text": "Dairy",
      "subcategories": ["All products"],
      "show": false,
      "color": 0xff5C5C5C,
    },
    {
      "picture": "assets/catalogue/fish.svg",
      "text": "Seafood",
      "subcategories": ["All products"],
      "show": false,
      "color": 0xff5C5C5C,
    },
    {
      "picture": "assets/catalogue/apple.svg",
      "text": "Fruits & Vegetables",
      "subcategories": ["All products"],
      "show": false,
      "color": 0xff5C5C5C,
    },
    {
      "picture": "assets/catalogue/chicken.svg",
      "text": "Meat, poultry & etc.",
      "subcategories": ["All products"],
      "show": false,
      "color": 0xff5C5C5C,
    },
    {
      "picture": "assets/catalogue/walnut.svg",
      "text": "Snacks & nuts",
      "subcategories": [
        "All products",
        "Crisps",
        "Nuts",
        "Seeds",
        "Dried fruits",
        "Sweet snacks",
      ],
      "show": false,
      "color": 0xff5C5C5C,
    },
    {
      "picture": "assets/catalogue/sulphites.svg",
      "text": "Dietary nutrition",
      "subcategories": ["All products"],
      "show": false,
      "color": 0xff5C5C5C,
    },
    {
      "picture": "assets/catalogue/drinks.svg",
      "text": "Water, juices & drinks",
      "subcategories": ["All products"],
      "show": false,
      "color": 0xff5C5C5C,
    },
  ];
}


