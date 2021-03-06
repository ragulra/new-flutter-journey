import 'package:meta/meta.dart';

import 'package:flutter/material.dart';

import 'unit.dart';

const _padding = EdgeInsets.all(16.0);

class ConverterRoute extends StatefulWidget {
  final String name;
  final Color color;
  final List<Unit> units;

  const ConverterRoute({
    @required this.name,
    @required this.color,
    @required this.units
  }) : assert(name != null),
      assert(color != null),
      assert(units != null);

  @override
    _ConverterRouteState createState() {
      // TODO: implement createState
      return _ConverterRouteState();
    }
}

class _ConverterRouteState extends State<ConverterRoute> {
  /* 
    definisikan fromvalue dan tovalue
    definisikan inputvalue user
    definisikan convertedValue (hasil dari konversi) input
    definisikan list dropdownitem
    definisikan validasierror
  */
  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _convertedValue = '';
  List<DropdownMenuItem> _unitMenuItems;
  bool _showValidationError = false;

  /* 
    buat item dropdown list
  */
  void _createDropdownMenuItems() {
    var newItems = <DropdownMenuItem>[];
    for (var unit in widget.units) {
      newItems.add(DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      ));
    }
    setState(() { _unitMenuItems = newItems; });
  }

  /* 
    kembali ke awal
  */
  void _setDefaults() {
    setState(() {
      _fromValue = widget.units[0];
      _toValue = widget.units[1];
    });
  }

  /* 
    update konversi
  */
  void _updateConversion() {
    setState(() {
      _convertedValue = _format(_inputValue * (_toValue.conversion) / _fromValue.conversion);
    });
  }

  /* 
    bikin format konversi
  */
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while(outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, 1 + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  /* 
    update input value
  */
  void _updateInputValue(String input) {
    setState(() {
      if (input == null || input.isEmpty) {
        _convertedValue = '';
      } else {
        try {
          final inputDouble = double.parse(input);
          _showValidationError = false;
          _inputValue = inputDouble;
        } on Exception catch(e) {
          print('Error: $e');
          _showValidationError = true;
        }
      }
    });
  }

  /* 
    get unit
  */
  Unit _getUnit(String unitName) {
    return widget.units.firstWhere(
      (Unit unit) {
        return unit.name == unitName;
      },
      orElse: null,
    );
  }

  /* 
    set from value ke getunit
  */
  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  /* 
    bikin dropdown menu
  */
  Widget _createDropdown(String currentValue, ValueChanged<dynamic> onChanged) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0
        )
      ),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50]
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: currentValue,
              items: _unitMenuItems,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _createDropdownMenuItems();
      _setDefaults();
    }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      final input = Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              style: Theme.of(context).textTheme.display1,
              decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.display1,
                errorText: _showValidationError ? 'Invalid number entered.' : null,
                labelText: 'Input',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0)
                )
              ),
              keyboardType: TextInputType.number,
              onChanged: _updateInputValue,
            ),
            _createDropdown(_fromValue.name, _updateFromConversion)
          ],
        ),
      );

      final arrows = RotatedBox(
        quarterTurns: 1,
        child: Icon(
          Icons.compare_arrows,
          size: 40.0,
        ),
      );

      final output = Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InputDecorator(
              child: Text(
                _convertedValue,
                style: Theme.of(context).textTheme.display1,
              ),
              decoration: InputDecoration(
                labelText: 'Output',
                labelStyle: Theme.of(context).textTheme.display1,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0)
                )
              ),
            ),
            _createDropdown(_toValue.name, _updateFromConversion)
          ],
        ),
      );

      final converter = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          input,
          arrows,
          output
        ],
      );

      // PART `navigator`
      // final unitsWidget = units.map((Unit unit) {
      //   return Container(
      //     color: color,
      //     margin: EdgeInsets.all(8.0),
      //     padding: EdgeInsets.all(16.0),
      //     child: Column(
      //       children: <Widget>[
      //         Text(
      //           unit.name,
      //           style: Theme.of(context).textTheme.headline,
      //         ),
      //         Text(
      //           'Convertion: ${unit.conversion}',
      //           style: Theme.of(context).textTheme.subhead,
      //         )
      //       ],
      //     ),
      //   );
      // }).toList();
      
      return Padding(
        padding: _padding,
        child: converter,
      );
  }
}