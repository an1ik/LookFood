import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food/screens/homepage.dart';

class Onbordind extends StatefulWidget {
  @override
  _Onbordind createState() => _Onbordind();
}

class _Onbordind extends State<Onbordind> {
  final int _numPages = 3; //Переменная, содержащие в себе количество экранов на данном листе программы
  int _currentPage = 0;
  

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),//Длительность анимации перехода
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: 17.0,//высота контейнера
      width: 17.0,// ширина контейнера
      decoration: BoxDecoration(
        border: isActive ? Border.all(color: Colors.white) :Border.all(color: Col-ors.black),//если значение интекатора показывает активный экран, то цвет белый
        borderRadius: BorderRadius.all(Radius.circular(13)),// коэффицент за-кругления углов
      ),
    );
  }

  final _pageViewController = PageController();

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: Stack(alignment: Alignment.center, children: <Widget>[
            PageView( //Метод, дающий возможность про-листывать экраны по горизонтали 
              physics: ClampingScrollPhysics(),
              controller: _pageViewController, //Переменная, фиксирующая проли-стываемый экран при нахождении в границах экрана телефона
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/onb1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Row(children: <Widget>[
                      Spacer(flex: 2),
                      Expanded(
                        child: Container(
                            child: Column(children: <Widget>[
                          Spacer(flex: 2),
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/save_food.png"),
                                  ),
                                ),
                              ),
                              flex: 1),
                          Spacer(flex: 1),
                        ])),
                        flex: 2,
                      )
                    ])),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/onb2.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                      child: Row(children: <Widget>[
                    Spacer(flex: 1),
                    Expanded(
                        flex: 3,
                        child: Container(
                            child: Column(children: <Widget>[
                          Spacer(flex: 1),
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/eat_right.png"),
                                  ),
                                ),
                              ),
                              flex: 3),
                          Spacer(flex: 13),
                        ]))),
                    Spacer(flex: 1),
                  ])),
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/onb3.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                      child: Column(children: <Widget>[
                    Spacer(flex: 1),
                    Expanded(
                        flex: 10,
                        child: Container(
                            child: Row(children: <Widget>[
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/use_organic.png"),
                                  ),
                                ),
                              ),
                              flex: 5),
                          Spacer(flex: 1),
                        ]))),
                    Spacer(
                      flex: 4,
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                          child: Row(children: <Widget>[
                            Spacer(flex: 5),
                            Expanded(
                                child: FlatButton(
                                    child: Container(
                                        child: SvgPicture.asset(
                                      "assets/icons/CaretRight.svg",
                                      height: 30,
                                      width: 30,
                                    )
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      );
                                    }),
                                flex: 2),
                          ]),
                        )),
                  ])),
                ),
              ],
            ),
            Positioned(
                child: Container(child:Row(
                  children: _buildPageIndicator(),
                )),
                bottom: 60,)
      ]),
    );
  }
}



