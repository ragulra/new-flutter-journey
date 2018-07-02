import 'package:flutter/material.dart';

void main() {
  runApp(
    new MaterialApp(
      title: 'Gaming PC List',
      home: new Home(),
    )
  );
}

class Home extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red[900],
          title: new Text('Gaming PC List'),
        ),
        body: new ListView(
          children: <Widget>[
            new PCGaming(imageUrl: 'https://lh6.googleusercontent.com/-w58rba3jrgU/UR8zmNRG_1I/AAAAAAAAAR8/8YDNnGOkJco/s400/10.png', text: 'iBuyPower Paladin D875', desc: 'Harga : US\$ 1,549 (Sekitar 15 Jutaan)'),
            new Divider(),
            new PCGaming(imageUrl: 'https://lh6.googleusercontent.com/-2En72-h95ik/UR8zsKCWDDI/AAAAAAAAAS8/qD2qB1EyEIg/s610/9.jpg', text: 'Alienware Aurora R4', desc: 'Harga : US\$ 2,499 (Sekitar 24 Jutaan)',),
            new Divider(),
            new PCGaming(imageUrl: 'https://lh6.googleusercontent.com/-UTjku_2sKXQ/UR8zrdat_FI/AAAAAAAAAS0/d787wJU-iCo/s350/8.jpg', text: 'Maingear X-Cube FM1', desc: 'Harga : US\$ 649 (Sekitar 6 Jutaan)',),
            new Divider(),
            new PCGaming(imageUrl: 'https://lh5.googleusercontent.com/-5vQifQVf7bM/UR8zqSZw-jI/AAAAAAAAASo/y-AcaszIN6A/s500/7.jpg', text: 'AVA Direct Xeon 5600', desc: 'Harga : US\$ 2,738 (Sekitar 27 Jutaan)',),
            new Divider(),
            new PCGaming(imageUrl: 'https://lh5.googleusercontent.com/-wjnyg-HaR-E/UR8zpfpsrsI/AAAAAAAAASY/cAeKjKnsLRk/s512/6.jpg', text: 'Origin Genesis', desc: 'Harga : US\$ 1,963 (Sekitar 19 Jutaan)',),
            new Divider(),
            new PCGaming(imageUrl: 'https://lh3.googleusercontent.com/-IYJMpDvR7_s/UR8zoyBQrgI/AAAAAAAAASU/XRsM2TyZVUw/s500/5.jpg', text: 'Maingear Shift', desc: 'Harga : US\$ 4,699 (Sekitar 46 Jutaan)',),
            new Divider(),
            new PCGaming(imageUrl: 'https://lh6.googleusercontent.com/-diOZO8RdjXE/UR8zmnwYr5I/AAAAAAAAASE/y18COOuA1Xw/s400/4.jpg', text: 'CyberPower Cobra', desc: 'Harga : US\$ 1,849 (Sekitar 18 Jutaan)',),
            new Divider(),
            new PCGaming(imageUrl: 'https://lh6.googleusercontent.com/-iYTM66XwsQI/UR8zlm3IVbI/AAAAAAAAARw/obMOLYOoddk/s500/3.jpg', text: 'Velocity Raptor Signature Edition', desc: 'Harga : US\$ 4,599 (Sekitar 45 Jutaan)',),
            new Divider(),
            new PCGaming(imageUrl: 'https://lh4.googleusercontent.com/-9d1kOCiIbzk/UR8zhMLkK2I/AAAAAAAAARg/3soCafDnAdg/s500/2.jpg', text: 'Digital Storm Hailstorm', desc: 'Harga : US\$ 2,313 (Sekitar 23 Jutaan)',),
            new Divider(),
            new PCGaming(imageUrl: 'https://lh5.googleusercontent.com/-438vjhJzigE/UR8zj1laPZI/AAAAAAAAARo/lqnZ5MbhBhw/s381/1.png', text: 'Cyberpower Black Pearl', desc: 'Harga : US\$ 1,195 (Sekitar 11 Jutaan)',),
          ],
        ),
      );
    }
}

class PCGaming extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String desc;

  PCGaming({this.imageUrl, this.text, this.desc});

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new Container(
        padding: const EdgeInsets.all(20.0),
        child: new Center(
          child: new Row(
            children: <Widget>[
              new Image(
                image: new NetworkImage(imageUrl),
                width: 100.0,
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: new Center(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(text),
                      new Text(desc, style: new TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
}