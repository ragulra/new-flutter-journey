import 'package:flutter/material.dart';

/* diimpor biar bisa pake @required */
import 'package:meta/meta.dart';

/* 
  buat kelas unit
*/
class Unit {
  final String name;
  final double conversion;

  /* 
    buat constructor kelas unit
  */
  const Unit({
    @required this.name,
    @required this.conversion
  }) /* assert di pake buat ngecek kalo nilai yang 
        dimasukkan dengan kondisi yang kita tentukan */
      : assert(name != null),
        assert(conversion != null);

  /* 
    konversi unit dari json
  */
  Unit.fromJson(Map jsonMap) :
    name = jsonMap['name'],
    conversion = jsonMap['conversion'].toDouble(),
    assert(name != null),
    assert(conversion != null);
}