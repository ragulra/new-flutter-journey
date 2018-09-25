import 'package:integration_test/all_string.dart' as allString;
import 'package:flutter_driver/flutter_driver.dart';

SerializableFinder emptyMessage = find.text(allString.EMPTY);
SerializableFinder showStores = find.text(allString.SHOW_STORES);
SerializableFinder showProducts = find.text(allString.SHOW_PRODUCTS);
 
SerializableFinder firstStore = find.byValueKey(allString.getStringKeyForListItem(allString.STORE_TYPE, 0));
 
SerializableFinder firstProduct = find.byValueKey(allString.getStringKeyForListItem(allString.PRODUCT_TYPE, 0));