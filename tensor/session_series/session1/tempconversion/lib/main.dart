import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Conversion',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.redAccent
      ),
      home: TempConvHome(),
    )
  );
}

class TempConvHome extends StatefulWidget {
  @override
    _TempConvHome createState() => _TempConvHome();
}

class _TempConvHome extends State<TempConvHome> {
  double input;
  double output;
  bool forC;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      input = 0.0;
      output = 0.0;
      forC = true;
    }

  Widget converterTitle() {
    return Text(
      'Temp Converter',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 24.0,
        fontWeight: FontWeight.w500
      ),
    );
  }

  Widget inputField() {
    return TextField(
      keyboardType: TextInputType.number,
      onChanged: (str) {
        try {
          input = double.parse(str);
        } catch(e) {
          input = 0.0;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(23.0),
          borderSide: BorderSide(width: 2.0)
        ),
        labelText: "Input a Value in ${forC == false ? "Fahrenheit" : "Celcius"}"
      ),
    );
  }

  Widget tempSwitch() {
    return Container(
      child: Row(
        children: <Widget>[
          Switch(
            value: forC,
            onChanged: (e) {
              setState(() {
                forC = !forC;
              });
            },
          ),
          Text(
            'Choose Fahrenheit or Celcius',
            style: TextStyle(
              color: Theme.of(context).primaryColor
            ),
          )
        ],
      ),
    );
  }

  Widget converterButton() {
    return OutlineButton.icon(
      highlightColor: Theme.of(context).accentColor,
      splashColor: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23.0)
      ),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 2.0
      ),
      label: Text('Convert', style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w500
        )
      ),
      icon: Icon(Icons.compare_arrows, color: Theme.of(context).primaryColor),
      onPressed: () {
        setState(() {
          forC == false 
            ? output = (input - 32) * (5 / 9)
            : output = (input * 9 / 5) + 32;
        });
        AlertDialog dialog = AlertDialog(
          content: forC == false
            ? Text("${input.toStringAsFixed(2)} F : ${output.toStringAsFixed(3)} C")
            : Text("${input.toStringAsFixed(2)} C : ${output.toStringAsFixed(3)} F")
        );
        showDialog(context: context, builder: (BuildContext context) {
          return dialog;
        });
      },
    );
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            padding: const EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height  * 0.5,
          color: Theme.of(context).cardColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              converterTitle(),
              inputField(),
              tempSwitch(),
              converterButton()
            ],
          )
        ),
      );
    }
}