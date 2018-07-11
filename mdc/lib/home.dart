import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'supplemental/asymmetric_view.dart';
import 'model/data.dart';
import 'model/product.dart';

class HomePage extends StatelessWidget {
  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = getProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString()
    );

    return products.map((product) {
      return Card(
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    product == null ? '' : product.name,
                    style: theme.textTheme.button,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    product == null ? '' : formatter.format(product.price),
                    style: theme.textTheme.caption,
                  )
                ],
              ),
            )
            )
          ],
        ),
      );
    }).toList();
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              print('Menu Button');
            },
          ),
          title: Text('SHRINE'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('Filter Button');
              },
            ),
            IconButton(
              icon: Icon(Icons.tune),
              onPressed: () {
                print('Filter Button');
              },
            )
          ],
        ),
        // body: GridView.count(
        //   crossAxisCount: 2,
        //   padding: EdgeInsets.all(16.0),
        //   childAspectRatio: 8.0 / 9.0,
        //   children: _buildGridCards(context)
        // )
        body: AsymmtericView(products: getProducts(Category.all)),
      );
    }
}