import 'package:flutter/material.dart';
import 'package:meals_app/widget/meal_item.dart';

import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
   late String categoryTitle;
   late List<Meal> displayedMeals;
   var _loadedInitData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
      if (!_loadedInitData) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
   categoryTitle = routeArgs['title']!;
    final categoryId = routeArgs['id'];
    displayedMeals= DUMMY_MEALS.where((meal){
      return meal.categories.contains(categoryId);
    }).toList();
    _loadedInitData = true;
     }
    super.didChangeDependencies();
  }

   void _removeMeals(String mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(itemBuilder: (ctx, index){
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title, 
            imageUrl: displayedMeals[index].imageUrl, 
            duration: displayedMeals[index].duration, 
            affordability:displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity, 
            removeItem: _removeMeals,
            );
      },
      itemCount: displayedMeals.length,
      )
    );
  }
}