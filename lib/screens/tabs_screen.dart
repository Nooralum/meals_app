import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widget/main_drawer.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
   final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late final List<Map<String, dynamic>> _pages;
  int _selectPageIndex = 0;

  @override
  void initState() {
    _pages =[
   { 
    'page': CategoriesScreen(),
    'title' : 'Categories',
    },
    {
    'page': FavoritesScreen(widget.favoriteMeals),
    'title' : 'Favorites',
   
    }
  ];
    
    super.initState();
  }

  void _selectPage(int index){
    setState(() {
      _selectPageIndex = index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectPageIndex]['title']),

          // bottom: TabBar(
          //   tabs: [
          //     Tab(
          //       icon: Icon(Icons.category), 
          //       text: 'Categories'
          //       ),
          //       Tab(
          //       icon: Icon(Icons.star), 
          //       text: 'Favorites'
          //       )
          //   ]
          //   ),
          
        ),
        drawer: MainDrawer(),
        body: _pages[_selectPageIndex]['page'],
        //  TabBarView(
        //   children: [
        //     CategoriesScreen(),
        //     FavoritesScreen(),
        //   ]
        //   ),
       bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage ,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories',
            ),
           BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favorites',
            )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectPageIndex,
        type: BottomNavigationBarType.shifting,
        ),
      );
  }
}