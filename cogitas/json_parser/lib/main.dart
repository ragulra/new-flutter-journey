import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as numberformat;

import 'package:json_parser/data/pc_gaming_parser.dart';

void main() {
  var formatter = numberformat.NumberFormat.currency(name: 'IDR');
  loadPCGaming().then((data) {
    runApp(MaterialApp(
      title: 'JSON Parser',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('PC Gaming 2018'),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text(data[index].id.toString()),
              ),
              title: Text(data[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Brand',
                        ),
                        TextSpan(
                          text: ':   ',
                        ),
                        TextSpan(
                          text: data[index].brand,
                        )
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Price',
                        ),
                        TextSpan(
                          text: ':   ',
                        ),
                        TextSpan(
                          text: formatter.format(data[index].price),
                        )
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Proccesor',
                        ),
                        TextSpan(
                          text: ':   ',
                        ),
                        TextSpan(
                          text: data[index].spec.processor,
                        )
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'RAM',
                        ),
                        TextSpan(
                          text: ':   ',
                        ),
                        TextSpan(
                          text: data[index].spec.ram.toString() + ' GB',
                        )
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'HDD',
                        ),
                        TextSpan(
                          text: ':   ',
                        ),
                        TextSpan(
                          text: data[index].spec.hdd.toString() + ' GB',
                        )
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'SSD',
                        ),
                        TextSpan(
                          text: ':   ',
                        ),
                        TextSpan(
                          text: data[index].spec.ssd.toString() + ' GB',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: data.length,
        ),
      ),
      debugShowCheckedModeBanner: false,
    ));
  });
}
