import 'package:flutter/material.dart';

import 'category_route.dart';

// PART `category`
// import 'category.dart';

// PART `category`
// const _categoryName = 'Cake';
// const _categoryIcon = Icons.cake;
// const _categoryColor = Colors.purple;

void main() {
  runApp(
    UnitConverterApp()
  );
}

class UnitConverterApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unit Converter',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.grey[500]
          ),
          primaryColor: Colors.grey[500],
          textSelectionHandleColor: Colors.green[500]
        ),
        home: CategoryRoute(),
        // PART `category`
        // home: Scaffold(
        //   backgroundColor: Colors.redAccent,
        //   body: Center(
        //     child: Category(
        //       name: _categoryName,
        //       color: _categoryColor,
        //       icon: _categoryIcon,
        //     ),
        //   ),
        // ),
      );
    }
}