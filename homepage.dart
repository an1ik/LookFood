import 'package:flutter/material.dart';
import 'package:food/homepages/catalogue.dart';
import 'package:food/homepages/home.dart';
import 'package:food/homepages/leaf.dart';
import 'package:food/homepages/search.dart';
import 'package:food/services/landing.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  dynamic getPage(int _currentIndex) {
    if (_currentIndex == 0) {
      return Home(products: products);
    } else {
      if (_currentIndex == 1) {
        return Catalogue(products: products);
      } else {
        if (_currentIndex == 2) {
          return Search(products: products, searchHistory: searchHistory);
        } else {
          if (_currentIndex == 3) {
            return Leaf(recipes: recipes);
          } else {
            if (_currentIndex == 4) {
              return Landing();
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getPage(_currentIndex),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 25, color: Col-or(0xff86A40A)),
          unselectedIconTheme:
              IconThemeData(size: 25, color: Color(0xff6F6F6F)),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/home.png')),
                label: 'home'),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/catalogue.png')),
                label: 'catalogue'),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/search.png')),
                label: 'search'),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/leaf.png')),
                label: 'leaf'),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/person.png')),
                label: 'profile'),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        decoration: BoxDecoration(
          color: Color(0xffEBEBEB).withOpacity(0.75),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(22), topLeft: Radius.circular(22)),
        ),
      ),
    );
  }

  List<String> searchHistory = [
    "Avocado",
    "Tomato",
    "Banana",
    "Passion Fruit",
    "Peach",
    "Mango"
  ];

  Map<String, Map<String, dynamic>> products = {
    "Avocado": {
      "product name": "Avocado",
      "pictures": "assets/products/avocado1.png",
      "category": "Fruits & Vegetables",
      "fat": 26,
      "carbs": 89,
      "protein": 124,
      "measure": "pc",
      "period of storage": 4,
      "quanity": [3],
      "shelf life now": [2],
      "text.svg": "assets/text/avocadotext.svg",
      "description":
          "Avocado also has a high water content, which\nprovides excellent hy-dration of the skin, while it is\nvery low in sugar and calories, which has a\npositive effect on the figure."
    },
    "Tomato": {
      "product name": "Tomato",
      "pictures": "assets/products/tomato1.png",
      "category": "Fruits & Vegetables",
      "fat": 56,
      "carbs": 47,
      "protein": 13,
      "measure": "g",
      "period of storage": 21,
      "quanity": [800],
      "shelf life now": [5],
      "text.svg": "assets/text/avocadotext.svg",
      "description":
          "Avocado also has a high water content, which\nprovides excellent hy-dration of the skin, while it is\nvery low in sugar and calories, which has a\npositive effect on the figure."
    },
    "Banana": {
      "product name": "Banana",
      "pictures": "assets/products/banan1.png",
      "category": "Fruits & Vegetables",
      "fat": 96,
      "carbs": 58,
      "protein": 104,
      "measure": "pc",
      "period of storage": 11,
      "quanity": [4],
      "shelf life now": [5],
      "text.svg": "assets/text/avocadotext.svg",
      "description":
          "Avocado also has a high water content, which\nprovides excellent hy-dration of the skin, while it is\nvery low in sugar and calories, which has a\npositive effect on the figure."
    },
    "Passion Fruit": {
      "product name": "Passion Fruit",
      "pictures": "assets/products/mar1.png",
      "category": "Fruits & Vegetables",
      "fat": 66,
      "carbs": 73,
      "protein": 54,
      "measure": "g",
      "period of storage": 7,
      "quanity": [100],
      "shelf life now": [6],
      "text.svg": "assets/text/avocadotext.svg",
      "description":
          "Avocado also has a high water content, which\nprovides excellent hy-dration of the skin, while it is\nvery low in sugar and calories, which has a\npositive effect on the figure."
    },
    "Peach": {
      "product name": "Peach",
      "pictures": "assets/products/peach1.png",
      "category": "Fruits & Vegetables",
      "fat": 38,
      "carbs": 12,
      "protein": 17,
      "measure": "pc",
      "period of storage": 6,
      "quanity": [3],
      "shelf life now": [2],
      "text.svg": "assets/text/avocadotext.svg",
      "description":
          "Avocado also has a high water content, which\nprovides excellent hy-dration of the skin, while it is\nvery low in sugar and calories, which has a\npositive effect on the figure."
    },
    "Mango": {
      "product name": "Mango",
      "pictures": "assets/products/mango1.png",
      "category": "Fruits & Vegetables",
      "fat": 26,
      "carbs": 24,
      "protein": 78,
      "measure": "g",
      "period of storage": 10,
      "quanity": [400],
      "shelf life now": [8],
      "text.svg": "assets/text/avocadotext.svg",
      "description":
          "Avocado also has a high water content, which\nprovides excellent hy-dration of the skin, while it is\nvery low in sugar and calories, which has a\npositive effect on the figure."
    },
    "Strawberries": {
      "product name": "Strawberries",
      "pictures": "assets/products/strawberries1.png",
      "category": "Fruits & Vegetables",
      "fat": 11,
      "carbs": 37,
      "protein": 28,
      "measure": "pc",
      "period of storage": 10,
      "quanity": [11],
      "shelf life now": [9],
      "text.svg": "assets/text/avocadotext.svg",
      "description":
          "Avocado also has a high water content, which\nprovides excellent hy-dration of the skin, while it is\nvery low in sugar and calories, which has a\npositive effect on the figure."
    },
    "Cereals": {
      "product name": "Cereals",
      "pictures": "assets/products/cereals1.png",
      "category": "Dietary nutrition",
      "fat": 156,
      "carbs": 93,
      "protein": 24,
      "measure": "g",
      "period of storage": 235,
      "quanity": [500],
      "shelf life now": [67],
      "text.svg": "assets/text/avocadotext.svg",
      "description":
          "Avocado also has a high water content, which\nprovides excellent hy-dration of the skin, while it is\nvery low in sugar and calories, which has a\npositive effect on the figure."
    },
    "Tom Yam": {
      "product name": "Tom Yam",
      "pictures": "assets/products/tomYam1.png",
      "category": "Seafood",
      "fat": 113,
      "carbs": 67,
      "protein": 134,
      "measure": "pc",
      "period of storage": 11,
      "quanity": [1],
      "shelf life now": [5],
      "text.svg": "assets/text/avocadotext.svg",
      "description":
          "Avocado also has a high water content, which\nprovides excellent hy-dration of the skin, while it is\nvery low in sugar and calories, which has a\npositive effect on the figure."
    },
    "Greenery": {
      "product name": "Greenery",
      "pictures": "assets/products/greenery1.png",
      "category": "Fruits & Vegetables",
      "fat": 17,
      "carbs": 23,
      "protein": 21,
      "measure": "g",
      "period of storage": 24,
      "quanity": [100],
      "shelf life now": [14],
      "text.svg": "assets/text/avocadotext.svg",
      "description":
          "Avocado also has a high water content, which\nprovides excellent hy-dration of the skin, while it is\nvery low in sugar and calories, which has a\npositive effect on the figure."
    },
    "Olive Oil": {
      "product name": "Olive Oil",
      "pictures": "assets/products/oliveOil1.png",
      "category": "Dietary nutrition",
      "fat": 165,
      "carbs": 50,
      "protein": 42,
      "measure": "pc",
      "period of storage": 226,
      "quanity": [1],
      "shelf life now": [64],
      "text.svg": "assets/text/avocadotext.svg",
      "description":
          "Avocado also has a high water content, which\nprovides excellent hy-dration of the skin, while it is\nvery low in sugar and calories, which has a\npositive effect on the figure."
    },
    "Hummus": {
      "product name": "Hummus",
      "pictures": "assets/products/hummus1.png",
      "category": "Snacks & nuts",
      "subcategory": "Sweet snacks",
      "fat": 66,
      "carbs": 48,
      "protein": 70,
      "measure": "pc",
      "period of storage": 14,
      "quanity": [1],
      "shelf life now": [10],
      "text.svg": "assets/text/avocadotext.svg",
      "description":
          "Avocado also has a high water content, which\nprovides excellent hy-dration of the skin, while it is\nvery low in sugar and calories, which has a\npositive effect on the figure."
    }
  };

  Map<String, Map<String, dynamic>> recipes = {
    "Avocado_salad": {
      "recipe name": "Avocado salad",
      "picture": 'assets/recipe/avocadosaladpicture.jpg',
      "title": 'assets/recipe/avocadosalad.svg',
      "description":
          'A classic avocado salad is a must for picnics and\npotlucks. This ve-gan version gets its creaminess\nfrom blended avocado. Any mix of salad greens will\nwork well, but try arugula if you want to give this\nhearty salad a peppery kick.',
      "fat": 38,
      "carbs": 85,
      "protein": 125,
      "ingredients": [
        ["not available", "½ cup thinly sliced red onion"],
        ["not available", "1 medium ripe avocado, pitted and roughly chopped"],
        ["not available", "¼ cup cilantro leaves"],
        ["not available", "¼ cup lime juice"],
        [
          "not available",
          "2 medium ears corn, kernels removed, or 2 cups frozen corn, thawed and patted dry"
        ],
        ["not available", "½ teaspoon salt"],
        ["not available", "8 cups mixed salad greens"],
      ],
      "directions": [
        {
          "status": "not available",
          "text":
              "Place onion in a medium bowl and cover with cold water. Set aside. Combine avocado, cilantro, lime juice, oil, garlic and salt in a mini food processor. Process, scraping down the sides as needed, until smooth and creamy.",
          "strike_out": TextDecoration.none,
        },
        {
          "status": "not available",
          "text":
              "Just before serving, combine salad greens, corn, tomatoes and beans in a large bowl. Drain the onions and add to the bowl, along with the avocado dressing. Toss to coat.",
          "strike_out": TextDecoration.none,
        },
      ],
      "people_servings": 4,
    },
    "Nuts pancake": {
      "recipe name": "Nuts pancake",
      "picture": 'assets/recipe/nutsPancakePicture.jpg',
      "title": 'assets/recipe/nutsPancake.svg',
      "description":
          "A classic pancakes is a must for picnics and\npotlucks. This vegan version gets its creaminess\nfrom blended avocado. Any mix of salad greens will\nwork well, but try arugula if you want to give this\nhearty salad a peppery kick.",
      "fat": 80,
      "carbs": 117,
      "protein": 47,
      "ingredients": [
        ["not available", "½ cup thinly sliced red onion"],
        ["not available", "1 medium ripe avocado, pitted and roughly chopped"],
        ["not available", "¼ cup cilantro leaves"],
        ["not available", "¼ cup lime juice"],
        [
          "not available",
          "2 medium ears corn, kernels removed, or 2 cups frozen corn, thawed and patted dry"
        ],
        ["not available", "½ teaspoon salt"],
        ["not available", "8 cups mixed salad greens"],
      ],
      "directions": [
        {
          "status": "not available",
          "text":
              "Place onion in a medium bowl and cover with cold water. Set aside. Combine avocado, cilantro, lime juice, oil, garlic and salt in a mini food processor. Process, scraping down the sides as needed, until smooth and creamy.",
          "strike_out": TextDecoration.none,
        },
        {
          "status": "not available",
          "text":
              "Just before serving, combine salad greens, corn, tomatoes and beans in a large bowl. Drain the onions and add to the bowl, along with the avocado dressing. Toss to coat.",
          "strike_out": TextDecoration.none,
        },
      ],
      "people_servings": 2,
    }
  };
}


