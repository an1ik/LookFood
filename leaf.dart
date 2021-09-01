import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/screens/recipe.dart';

class Leaf extends StatefulWidget {
  final Map<String, Map<String, dynamic>> recipes;
  Leaf({Key key, this.recipes}) : super(key: key);

  @override
  _LeafState createState() => _LeafState(this.recipes);
}

class _LeafState extends State<Leaf> {
  final Map<String, Map<String, dynamic>> recipes;
  _LeafState(this.recipes);

  @override
  Widget build(BuildContext context) {
    List<String> _listRecipes = recipes.keys.toList();
    return Container(
      child: SafeArea(
        child: Column(children: [
          SizedBox(height: 10),
          Text('Recipes',
              style: TextStyle(
                fontFamily: 'Krub_R',
                fontSize: 24,
              )),
          SizedBox(height: 17),
          SvgPicture.asset('assets/under_line.svg'),
          Flexible(
            child: ListView.builder(
              itemCount: recipes.keys.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Column(
                    children: [
                      SizedBox(height: 14),
                      Row(
                        children: [
                          SizedBox(width: 7),
                          Container(
                            height: 80,
                            width: 80,
                            child: Image(
                              image: AssetImage(
                                  recipes[_listRecipes[index]]["picture"]),
                              fit: BoxFit.cover,
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            clipBehavior: Clip.hardEdge,
                          ),
                          SizedBox(width: 20),
                          Container(
                            height: 80,
                            child: Column(
                              children: [
                                Text(recipes[_listRecipes[index]]
                                    ["recipe name"]),
                                Container(
                                  width: 140,
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Center(
                                          child: Text(
                                            "${recipes[_listRecipes[index]]["fat"]}",
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
                                          '${recipes[_listRecipes[index]]["carbs"]}',
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
                                          "${recipes[_listRecipes[index]]["protein"]}",
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                      SizedBox(height: 14),
                      SvgPicture.asset('assets/under_line.svg'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Recipe(recipe: recipes[_listRecipes[index]])));
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
