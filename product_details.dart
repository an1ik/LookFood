import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> product;
  ProductDetails({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState(this.product);
}

class _ProductDetailsState extends State<ProductDetails> {
  Map<String, dynamic> _product;
  _ProductDetailsState(this._product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: Stack(children: <Positioned>[
                    Positioned(
                      child: Container(
                        child: Image(
                          image: AssetImage(_product["pictures"]),
                          fit: BoxFit.contain,
                        ),
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                        child: GestureDetector(
                          child: SvgPicture.asset(
                            'assets/icons/arrow.svg',
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.of(context).pop(_product);
                          },
                        ),
                        left: MediaQuery.of(context).size.width * 0.06),
                    Positioned(
                      child: GestureDetector(
                        child: SvgPicture.asset('assets/icons/menu.svg'),
                        onTap: () {},
                      ),
                      right: MediaQuery.of(context).size.width * 0.06,
                    ),
                  ]),
                  flex: 210),
              Expanded(
                child: Text(
                  _product["product name"],
                  style: TextStyle(
                      fontFamily: 'Krub_L',
                      fontSize: 38,
                      fontWeight: FontWeight.w300),
                ),
                flex: 50,
              ),
              Spacer(flex: 10),
              Expanded(
                child: FittedBox(
                  child: Text(
                    'x${sum(_product["quanity"])} ${_product["measure"] == "pc" ? "pieces" : "gram"}',
                    style: TextStyle(fontFamily: 'HeliosAnique', fontSize: 28),
                  ),
                  fit: BoxFit.fitHeight,
                ),
                flex: 30,
              ),
              Spacer(flex: 30),
              Expanded(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: SvgPicture.asset("assets/text/fattext.svg"),
                            flex: 20,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: "${_product["fat"]}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Krub_L',
                                    fontSize: 40,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "g",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ]),
                            ),
                            flex: 50,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      Column(
                        children: [
                          Expanded(
                            child:
                                SvgPicture.asset("assets/text/carbstext.svg"),
                            flex: 20,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: "${_product["carbs"]}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Krub_L',
                                    fontSize: 40,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "g",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ]),
                            ),
                            flex: 50,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                      Column(
                        children: [
                          Expanded(
                            child:
                                SvgPicture.asset("assets/text/proteintext.svg"),
                            flex: 20,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: "${_product["protein"]}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Krub_L',
                                    fontSize: 40,
                                    fontWeight: FontWeight.w200,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "g",
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ]),
                            ),
                            flex: 50,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.end,
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                  flex: 70),
              Spacer(flex: 20),
              Expanded(
                child: Center(
                  child: Text(
                    _product["description"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Krub_L',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -0.24),
                  ),
                ),
                flex: 100,
              ),
              Spacer(flex: 20),
              Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('assets/useorganic.svg'),
                                  SvgPicture.asset('assets/vitaminB5.svg'),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.025),
                              ...?getExpirationDateProduct()
                            ],
                          ),
                        ),
                        Stack(children: [
                          SvgPicture.asset('assets/healthy.svg'),
                          Positioned(
                            child: InkWell(
                              child: Container(
                                child: Center(
                                    child:
                                        SvgPicture.asset('assets/minus.svg')),
                                width: 30,
                                height: 30,
                              ),
                              onTap: () {
                                setState(() {
                                  if (_product["quanity"].length != 0) {
                                    if (_product["measure"] == "g") {
                                      if (_product["quanity"].last > 100) {
                                        _product["quanity"].last -= 100;
                                      } else {
                                        _product["quanity"]
                                            .remove(_product["quanity"].last);
                                        _product["shelf life now"].remove(
                                            _product["shelf life now"].last);
                                      }
                                    } else {
                                      if (_product["quanity"].last > 1) {
                                        _product["quanity"].last -= 1;
                                      } else {
                                        _product["quanity"]
                                            .remove(_product["quanity"].last);
                                        _product["shelf life now"].remove(
                                            _product["shelf life now"].last);
                                      }
                                    }
                                  }
                                });
                              },
                            ),
                            left: MediaQuery.of(context).size.width * 0.09,
                            bottom: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Positioned(
                            child: GestureDetector(
                              child: InkWell(
                                child: Container(
                                  child: Center(
                                      child:
                                          SvgPicture.asset('assets/plus.svg')),
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (_product["quanity"].isEmpty) {
                                    if (_product["measure"] == "g") {
                                      _product["quanity"].add(100);
                                      _product["shelf life now"]
                                          .add(_product["period of storage"]);
                                    } else {
                                      _product["quanity"].add(1);
                                      _product["shelf life now"]
                                          .add(_product["period of storage"]);
                                    }
                                  } else {
                                    if (_product["measure"] == "g") {
                                      if (_product["shelf life now"].last ==
                                          _product["period of storage"]) {
                                        _product["quanity"].last += 100;
                                      } else {
                                        _product["quanity"].add(100);
                                        _product["shelf life now"]
                                            .add(_product["period of storage"]);
                                      }
                                    } else {
                                      if (_product["shelf life now"].last ==
                                          _product["period of storage"]) {
                                        _product["quanity"].last += 1;
                                      } else {
                                        _product["quanity"].add(1);
                                        _product["shelf life now"]
                                            .add(_product["period of storage"]);
                                      }
                                    }
                                  }
                                });
                              },
                            ),
                            right: MediaQuery.of(context).size.width * 0.06,
                            bottom: MediaQuery.of(context).size.height * 0.04,
                          ),
                        ])
                      ],
                    ),
                  ),
                  flex: 240),
            ],
          ),
        ),
        backgroundColor: Colors.white);
  }

  sum(List<int> product) {
    int sum = 0;
    for (int count in product) {
      sum += count;
    }
    return sum;
  }

  List<Widget> getExpirationDateProduct() {
    List<Widget> expirationDateProduct;
    if (_product["shelf life now"].isEmpty) {
      return null;
    } else {
      if (_product["shelf life now"].length >= 2) {
        expirationDateProduct = [
          Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Container(
                child: LinearProgressIndicator(
                  value: _product["shelf life now"][1] /
                      _product["period of storage"],
                  backgroundColor: Color(0xff585858),
                  valueColor: AlwaysStoppedAnimation(Color(0xffBBD356)),
                ),
                width: 150,
              ),
              SizedBox(width: 10),
              Expanded(
                child: FittedBox(
                  child: Text(
                    'x ${_product["quanity"][1]}',
                    style: TextStyle(
                        fontFamily: 'Krub_L',
                        fontSize: 18,
                        fontWeight: FontWeight.w200),
                  ),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ),
          Spacer(flex: 15),
        ];
      }
      return [
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            RichText(
              text: TextSpan(
                  text: "${_product["shelf life now"][0]}",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Krub_L',
                    fontSize: 40,
                    fontWeight: FontWeight.w200,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: " days left",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
        Spacer(flex: 5),
        ...?expirationDateProduct,
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Container(
              child: LinearProgressIndicator(
                value: _product["shelf life now"][0] /
                    _product["period of storage"],
                backgroundColor: Color(0xff585858),
                valueColor: AlwaysStoppedAnimation(Color(0xffBBD356)),
              ),
              width: 150,
            ),
            SizedBox(width: 10),
            Expanded(
              child: FittedBox(
                child: Text(
                  'x ${_product["quanity"][0]}',
                  style: TextStyle(
                      fontFamily: 'Krub_L',
                      fontSize: 18,
                      fontWeight: FontWeight.w200),
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
        Spacer(flex: 60)
      ];
    }
  }
}

