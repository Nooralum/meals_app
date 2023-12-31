import 'package:flutter/material.dart';
import 'package:meals_app/widget/category_item.dart';
import 'package:meals_app/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding:  EdgeInsets.all(25),
      children: DUMMY_CATEGORIES
       .map(
        (catData) => CategoryItem(
        catData.id, 
        catData.title, 
        catData.color
        )
        ).toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 20,
        childAspectRatio: 3/2,
        mainAxisSpacing: 20,

        ),
    );
  
  }
}