import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'dummy_data.dart';
import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData){
     setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

    void _toggleFavorite(String mealId){
     final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
     if (existingIndex>=0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
       
     } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId ));
      });
     }
    }

    bool _isMealFavorite(String id){
      return _favoriteMeals.any((meal) => meal.id == id);
    }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Noor Délices',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        hintColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51,51, 1)
          ),
          bodyText2: TextStyle(
            color: Color.fromRGBO(20, 51,51, 1)
          ),
          subtitle1: TextStyle(
            fontSize: 24,
            fontFamily: 'RobottoCondensed',
            fontWeight: FontWeight.bold,

          )
        )
      ),
      // home:  CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
       CategoryMealScreen.routeName:(ctx) => CategoryMealScreen(),
       MealDetailScreen.routeName: (ctx)=> MealDetailScreen(_toggleFavorite, _isMealFavorite),
       FiltersScreen.routeName:(ctx)=> FiltersScreen(_filters as Function, _setFilters as Map<String, bool>)
      },
      onGenerateRoute: (settings){
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx)=> CategoriesScreen());
      },
      // onUnknownRoute: (settings){
      //   return MaterialPageRoute(builder: (ctx)=> CategoriesScreen());
      // },
    );
  }
}