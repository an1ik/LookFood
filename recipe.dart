import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class Recipe extends StatefulWidget {
  final Map<String, dynamic> recipe;
  Recipe({Key key, this.recipe}) : super(key: key);

  @override
  RecipeState createState() => RecipeState(this.recipe);
}

class RecipeState extends State<Recipe> {
  final Map<String, dynamic> recipe;
  RecipeState(this.recipe);
  ScrollController _controller;
  double containerHeight = 351.0;
  double containerBlur = 0.0;

  @override
  void initState() {
    int _count = 0;
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels < 351.0) {
        containerHeight = 351.0 - _controller.position.pixels;
        containerBlur = (351.0 - containerHeight) / 64.0;
        _count = 0;
        setState(() {});
      } else {
        if (_count <= 1) {
          containerHeight = 0.0;
          _count += 1;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Container(
            child: Stack(children: [
              Image(
                image: AssetImage(recipe["picture"]),
                fit: BoxFit.none,
                width: double.infinity,
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: containerBlur, sigmaY: containerBlur),
                  child: Container(color: Colors.transparent),
                ),
              ),
              Positioned(
                  child: SafeArea(
                    child: GestureDetector(
                      child: SvgPicture.asset('assets/icons/arrow.svg'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  left: MediaQuery.of(context).size.width * 0.06),
              Positioned(
                child: SafeArea(
                  child: GestureDetector(
                    child: SvgPicture.asset('assets/icons/menu.svg'),
                    onTap: () {},
                  ),
                ),
                right: MediaQuery.of(context).size.width * 0.06,
              ),
            ]),
            height: containerHeight,
          ),
          SizedBox(height: 10),
          SvgPicture.asset(recipe["title"]),
          SizedBox(height: 12),
          SvgPicture.asset('assets/under_line.svg'),
          Expanded(
            child: ListView(
              children: [
                SizedBox(height: (351.0 - containerHeight)),
                Text(
                  recipe["description"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Krub_L',
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      letterSpacing: -0.24),
                ),
                SizedBox(height: 25),
                ...getCalories(),
                SizedBox(height: 25),
                Align(
                  child: Padding(
                    child: SvgPicture.asset('assets/text/ingredientstext.svg'),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                ...getIngredients(),
                SizedBox(height: 40),
                Align(
                  child: Padding(
                    child: SvgPicture.asset('assets/text/directionstext.svg'),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                ...getDirections(),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Text('${recipe["people_servings"]}',
                            style: TextStyle(
                              fontFamily: 'Krub_L',
                              fontSize: 48,
                              fontWeight: FontWeight.w200,
                            )),
                        Text('people',
                            style: TextStyle(
                              fontFamily: 'Krub_L',
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            )),
                        Text('servings',
                            style: TextStyle(
                              fontFamily: 'Krub_L',
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                            )),
                      ],
                    )),
                    Expanded(
                        child: SvgPicture.asset('assets/recipe/lookfood.svg')),
                    Expanded(child: SvgPicture.asset('assets/useorganic.svg')),
                  ],
                ),
                SizedBox(height: 25)
              ],
              controller: _controller,
            ),
          ),
        ]),
        backgroundColor: Colors.white);
  }

  List<Row> getCalories() {
    return [
      Row(
        children: [
          Column(
            children: [
              SvgPicture.asset("assets/text/fattext.svg"),
              RichText(
                text: TextSpan(
                    text: "${recipe["fat"]}",
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
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          Column(
            children: [
              SvgPicture.asset("assets/text/carbstext.svg"),
              RichText(
                text: TextSpan(
                    text: "${recipe["carbs"]}",
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
            ],
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
          Column(
            children: [
              SvgPicture.asset("assets/text/proteintext.svg"),
              RichText(
                text: TextSpan(
                    text: "${recipe["protein"]}",
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
            ],
            crossAxisAlignment: CrossAxisAlignment.end,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      )
    ];
  }

  List<Widget> getIngredients() {
    List<Widget> ingredients = [];
    for (List<String> ingredient in recipe["ingredients"]) {
      ingredients.add(Column(children: [
        SizedBox(height: 15),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            GestureDetector(
              child: SvgPicture.asset(ingredient[0] == "available"
                  ? 'assets/recipe/vote_tick.svg'
                  : 'assets/recipe/vote_cube.svg'),
              onTap: () {
                setState(() {
                  ingredient[0] = ingredient[0] == "available"
                      ? "not available"
                      : "available";
                });
              },
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Expanded(
              child: Text(
                ingredient[1],
                style: TextStyle(
                  fontFamily: 'Krub_L',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ]));
    }
    return ingredients;
  }

  List<Widget> getDirections() {
    List<Widget> directions = [];
    int count = 0;
    for (Map<String, dynamic> direction in recipe["directions"]) {
      count += 1;
      directions.add(
        Column(
          children: [
            SizedBox(height: 15),
            Row(children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              GestureDetector(
                child: SvgPicture.asset(direction["status"] == "available"
                    ? 'assets/recipe/vote_tick.svg'
                    : 'assets/recipe/vote_circle.svg'),
                onTap: () {
                  setState(() {
                    if (direction["status"] == "available") {
                      direction["status"] = "not available";
                      direction["strike_out"] = TextDecoration.none;
                    } else {
                      direction["status"] = "available";
                      direction["strike_out"] = TextDecoration.lineThrough;
                    }
                  });
                },
              ),
              SizedBox(width: 10),
              Text("Step $count",
                  style: TextStyle(fontFamily: 'Krub_R', fontSize: 18))
            ]),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Expanded(
                  child: Text(
                    direction["text"],
                    style: TextStyle(
                        fontFamily: 'Krub_R',
                        fontSize: 16,
                        decoration: direction["strike_out"]),
                  ),
                ),
              ],
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      );
    }
    return directions;
  }
