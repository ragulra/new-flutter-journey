import 'package:flutter/material.dart';

import 'shopping_list_item.dart';

final List<Product> _kProducts = <Product>[
  new Product(name: 'Pasta Gigi'),
  new Product(name: 'Sikat Gigi'),
  new Product(name: 'Tai gigigigiGigi'),
  new Product(name: 'Tai gigigigiGigi'),
];

void main() {
  runApp(
    new MaterialApp(
      title: 'Flutter Shopping Cart',
      home: new ShopplingList(products: _kProducts),
    )
  );
}

class ShopplingList extends StatefulWidget {
  final List<Product> products;

  ShopplingList({Key key, this.products}) : super(key: key);

  @override
    ShoppingListState createState() {
      // TODO: implement createState
      return new ShoppingListState();
    }
}

class ShoppingListState extends State<ShopplingList> {
  Set<Product> _shoppingCart = new Set<Product>();

  void _handleCartChange(Product product, bool inCart) {
    setState(() {
      if (inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Shopping Cart'),
        ),
        body: new ListView(
          children: widget.products.map(
            (Product product) {
              return new ShoppingListItem(
                product: product,
                inCart: _shoppingCart.contains(product),
                onCartChanged: _handleCartChange,
              );
            }
          ).toList()
        ),
      );
    }
}