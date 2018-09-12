import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<String> _loadPCGamingAsset() async {
  return await rootBundle.loadString('assets/pc_gaming.json');
}

List<PcGaming> _parsePCGaming(String jsondata) {
  Map decoded = json.decode(jsondata);

  List<PcGaming> pcgamings = List<PcGaming>();
  for (var pcgaming in decoded['data']) {
    pcgamings.add(
      PcGaming(
        id: pcgaming['id'],
        name: pcgaming['name'],
        brand: pcgaming['brand'],
        spec: Spec(
          processor: pcgaming['specification']['processor'],
          videoCard: pcgaming['specification']['video_card'],
          ram: pcgaming['specification']['ram'],
          hdd: pcgaming['specification']['hdd'],
          ssd: pcgaming['specification']['ssd'],
        ),
        price: pcgaming['price'],
      ),
    );
  }

  return pcgamings;
}

Future<List<PcGaming>> loadPCGaming() async {
  String data = await _loadPCGamingAsset();
  List<PcGaming> pcs = _parsePCGaming(data);
  
  return pcs;
}

class PcGaming {
  final int id;
  final String name;
  final String brand;
  final int price;
  final Spec spec;

  PcGaming({
    this.id,
    this.name,
    this.brand,
    this.price,
    this.spec,
  });
}

class Spec {
  final String processor;
  final String videoCard;
  final int ram;
  final int hdd;
  final int ssd;

  Spec({
    this.processor,
    this.videoCard,
    this.ram,
    this.hdd,
    this.ssd,
  });
}
