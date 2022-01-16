import 'dart:async';

import 'package:observer/models/stock_ticker.dart';

class MainStockTicker extends StockTicker {
  MainStockTicker() {
    title = 'Main';
    stockTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setStock(140000, 180000);
      notifySubscribers();
    });
  }
}
